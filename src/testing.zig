const std = @import("std");
const builtin = @import("builtin");

fn rdtc() u64 {
    var high: u64 = 0;
    var low: u64 = 0;
    asm volatile (
        \\rdtsc
        : [low] "={eax}" (low),
          [high] "={edx}" (high),
    );
    return (high << 32) | low;
}

fn tsc_freq() u64 {
    const s = get_perf_counter();
    std.Thread.sleep(1000_000);
    const e = get_perf_counter();
    return (e - s) * 1000;
}

fn cntvct_el0() u64 {
    return asm volatile ("mrs %[ret], cntvct_el0"
        : [ret] "=r" (-> u64),
    );
}

fn cntfrq_el0() u64 {
    return asm volatile ("mrs %[ret], cntfrq_el0"
        : [ret] "=r" (-> u64),
    );
}

pub const get_perf_counter = if (builtin.cpu.arch == .x86_64)
    rdtc
else if (builtin.cpu.arch == .aarch64)
    cntvct_el0
else
    @compileError("Only x86_64 is supported");

pub const get_perf_counter_frequency = if (builtin.cpu.arch == .x86_64)
    tsc_freq
else if (builtin.cpu.arch == .aarch64)
    cntfrq_el0
else
    @compileError("Only x86_64 is supported");

pub const InputType = enum {
    undefined,
    random,
    pattern_all_0,
    pattern_all_1,
    pattern_every_2,
    pattern_every_3,
    pattern_every_4,
};

pub const Description = struct {
    function: *const fn ([*]const u8, u64) callconv(.c) void,
    name: []const u8,
    input_size: u64 = 1 << 30,
    input_type: InputType = .undefined,
    iterations: u32 = 10,
};

pub const Result = struct {
    max_time: u64 = 0,
    min_time: u64 = std.math.maxInt(u64),
};

fn longest_test_name(comptime tests: []const Description) usize {
    var longest: usize = 0;
    for (tests) |t| longest = @max(longest, t.name.len);
    return longest;
}

pub fn run(comptime tests: []const Description) !void {
    const freq = get_perf_counter_frequency();

    var results: [tests.len]Result = .{Result{}} ** tests.len;

    inline for (tests, &results) |t, *r| {
        const input = try create_input(t.input_size, t.input_type);
        defer delete_input(input);

        std.log.info(
            "Running test: {s} with input size: {d}, input type: {t}",
            .{ t.name, t.input_size, t.input_type },
        );
        for (0..t.iterations) |i| {
            std.log.info("Iteration: {d}", .{i});
            const start = get_perf_counter();
            t.function(input.ptr, t.input_size);
            const end = get_perf_counter();
            const delta = end - start;
            r.max_time = @max(r.max_time, delta);
            r.min_time = @min(r.min_time, delta);
        }
    }

    inline for (tests, results) |t, r| {
        const min_seconds: f64 =
            @as(f64, @floatFromInt(r.min_time)) / @as(f64, @floatFromInt(freq));
        const min_ms: f64 = min_seconds * 1000;
        const min_gbs: f64 =
            @as(f64, @floatFromInt(t.input_size)) / (min_seconds * @as(f64, (1 << 30)));
        const max_seconds: f64 =
            @as(f64, @floatFromInt(r.max_time)) / @as(f64, @floatFromInt(freq));
        const max_ms: f64 = max_seconds * 1000;
        const max_gbs: f64 =
            @as(f64, @floatFromInt(t.input_size)) / (max_seconds * @as(f64, (1 << 30)));
        std.log.info(
            "Test: {s:<" ++
                std.fmt.comptimePrint("{d}", .{longest_test_name(tests)}) ++
                "} min: {d:>10} {d:>6.2}ms {d:>6.2}Gbs max: {d:>10} {d:>6.2}ms {d:>6.2}Gbs",
            .{ t.name, r.min_time, min_ms, min_gbs, r.max_time, max_ms, max_gbs },
        );
    }
}

fn create_input(size: u64, input_type: InputType) ![]align(4096) u8 {
    const input = try std.posix.mmap(
        null,
        size,
        std.os.linux.PROT.READ | std.os.linux.PROT.WRITE,
        .{ .TYPE = .PRIVATE, .ANONYMOUS = true },
        -1,
        0,
    );
    switch (input_type) {
        .undefined => {},
        .random => {
            const fd = try std.posix.open("/dev/urandom", .{ .ACCMODE = .RDONLY }, 0);
            defer std.posix.close(fd);
            const r = try std.posix.read(fd, input);
            if (r != input.len) return error.CannotGetRandomBytes;
        },
        .pattern_all_0 => @memset(input, 0),
        .pattern_all_1 => @memset(input, 1),
        .pattern_every_2 => {
            for (input, 0..) |*e, i| e.* = @intFromBool(i % 2 == 0);
        },
        .pattern_every_3 => {
            for (input, 0..) |*e, i| e.* = @intFromBool(i % 3 == 0);
        },
        .pattern_every_4 => {
            for (input, 0..) |*e, i| e.* = @intFromBool(i % 4 == 0);
        },
    }
    return input;
}

fn delete_input(input: []align(4096) u8) void {
    std.posix.munmap(input);
}
