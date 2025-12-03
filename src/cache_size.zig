const std = @import("std");
const testing = @import("testing.zig");

extern fn read_32x8(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = read_32x8, .name = "read_32x8" },
};

const SINGLE_READ_SIZE = 256;
const RUNS = 64;

pub fn main() !void {
    var cache_sizes: [RUNS]u64 = undefined;
    var delta: u64 = 4096;
    var current_size: u64 = 4096;
    for (&cache_sizes) |*s| {
        s.* = current_size;
        if (16 << 10 < current_size) delta = 16 << 10;
        if (256 << 10 < current_size) delta = 256 << 10;
        if (1 << 20 < current_size) delta = 1 << 20;
        if (16 << 20 < current_size) delta = 16 << 20;
        current_size += delta;
    }
    var results: [RUNS][1]testing.Result = undefined;
    for (cache_sizes, &results) |cache_size, *result| {
        const loop_counters: [2]u64 = .{
            (1 << 30) / cache_size,
            cache_size / SINGLE_READ_SIZE,
        };
        result.* = try testing.run(
            &TESTS,
            @ptrCast(&loop_counters),
            &.{.{ .name = "cache_size", .value = cache_size }},
        );
    }

    testing.print_header(&.{.{ .name = "CacheSize" }});
    for (cache_sizes, &results) |cache_size, *result|
        testing.print_results(&TESTS, result, &.{.{ .value = cache_size }});
}
