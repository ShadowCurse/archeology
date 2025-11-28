const std = @import("std");
const testing = @import("testing.zig");

extern fn read_32x8(data: [*]const u8, len: u64) void;
const SINGLE_READ_SIZE = 256;

pub fn main() !void {
    var cache_sizes: [64]u64 = undefined;
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
    for (cache_sizes) |cache_size| {
        if (cache_size < 1 << 20)
            std.log.info("testing cache size: {d}KB", .{cache_size >> 10})
        else
            std.log.info("testing cache size: {d}MB", .{cache_size >> 20});
        const loop_counters: [2]u64 = .{
            (1 << 30) / cache_size,
            cache_size / SINGLE_READ_SIZE,
        };
        try testing.run(&[_]testing.Description{
            .{
                .function = read_32x8,
                .name = "read_32x8",
            },
        }, @ptrCast(&loop_counters));
    }
}
