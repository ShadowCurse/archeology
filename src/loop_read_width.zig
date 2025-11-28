const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_read_4x2(data: [*]const u8, len: u64) void;
extern fn loop_read_8x2(data: [*]const u8, len: u64) void;
extern fn loop_read_16x2(data: [*]const u8, len: u64) void;
extern fn loop_read_32x2(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_read_4x2, .name = "loop_read_4x2" },
        .{ .function = loop_read_8x2, .name = "loop_read_8x2" },
        .{ .function = loop_read_16x2, .name = "loop_read_16x2" },
        .{ .function = loop_read_32x2, .name = "loop_read_32x2" },
    });
}
