const std = @import("std");
const testing = @import("testing.zig");

const TESTS = [_]testing.Description{
    .{
        .function = test_read_into_buffer,
        .name = "test_read_into_buffer",
        .input_type = .not_used,
    },
    .{
        .function = test_read_full,
        .name = "test_read_full",
        .input_type = .not_used,
    },
};

const FILE_SIZE = 1 << 30;
const READ_SIZE = 32 << 10;

pub fn main() !void {
    const tmp_file_fd = try create_tmp_file();
    const buffer = try testing.create_input(FILE_SIZE, .pattern_all_0);
    var results: [1024][2]testing.Result = undefined;
    var buffer_len: u64 = READ_SIZE;
    var multiplier: u64 = 1;
    var i: u64 = 2;
    while (buffer_len < FILE_SIZE) : ({
        multiplier *= 2;
        i += 1;
    }) {
        buffer_len = READ_SIZE * multiplier;
        const iterations = FILE_SIZE / buffer_len;
        const args = [_]u64{
            @intCast(tmp_file_fd),
            @intFromPtr(buffer.ptr),
            buffer_len,
        };
        results[i] = try testing.run(
            &TESTS,
            @ptrCast(&args),
            &.{
                .{ .name = "buffer_len", .value = buffer_len },
                .{ .name = "iterations", .value = iterations },
            },
        );
    }
    testing.print_header(&.{ .{ .name = "BufferLen" }, .{ .name = "Iterations" } });

    buffer_len = READ_SIZE;
    multiplier = 1;
    i = 2;
    while (buffer_len < FILE_SIZE) : ({
        multiplier *= 2;
        i += 1;
    }) {
        buffer_len = READ_SIZE * multiplier;
        const iterations = FILE_SIZE / buffer_len;
        testing.print_results(
            &TESTS,
            &results[i],
            &.{ .{ .value = buffer_len }, .{ .value = iterations } },
        );
    }
}

fn create_tmp_file() !std.posix.fd_t {
    const fd = try std.posix.open(
        "/tmp/archeology_tmp",
        .{ .ACCMODE = .RDWR, .CREAT = true, .TRUNC = true },
        std.os.linux.S.IRWXU,
    );
    try std.posix.ftruncate(fd, FILE_SIZE);
    return fd;
}

fn test_read_into_buffer(
    _: [*]const u8,
    _: u64,
    args_ptr: [*]const u8,
    args_len: u64,
) callconv(.c) void {
    const args: []const u64 = @ptrCast(@alignCast(args_ptr[0..args_len]));
    const fd: std.posix.fd_t = @intCast(args[0]);
    const buffer_ptr: [*]u8 = @ptrFromInt(args[1]);
    const buffer_len = args[2];
    const buffer = buffer_ptr[0..buffer_len];

    const iterations = FILE_SIZE / buffer.len;
    for (0..iterations) |i| {
        const offset = buffer.len * i;
        _ = std.posix.pread(fd, buffer, offset) catch unreachable;
    }
}

fn test_read_full(
    _: [*]const u8,
    _: u64,
    args_ptr: [*]const u8,
    args_len: u64,
) callconv(.c) void {
    const args: []const u64 = @ptrCast(@alignCast(args_ptr[0..args_len]));
    const fd: std.posix.fd_t = @intCast(args[0]);
    const buffer_ptr: [*]u8 = @ptrFromInt(args[1]);
    const buffer = buffer_ptr[0..FILE_SIZE];

    _ = std.posix.pread(fd, buffer, 0) catch unreachable;
}
