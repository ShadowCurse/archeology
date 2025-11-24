const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_nop_3x1(data: [*]const u8, len: u64) void;
extern fn loop_nop_1x3(data: [*]const u8, len: u64) void;
extern fn loop_nop_1x4(data: [*]const u8, len: u64) void;
extern fn loop_nop_1x5(data: [*]const u8, len: u64) void;
extern fn loop_nop_1x9(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_nop_3x1, .name = "loop_nop_3x1" },
        .{ .function = loop_nop_1x3, .name = "loop_nop_1x3" },
        .{ .function = loop_nop_1x4, .name = "loop_nop_1x4" },
        .{ .function = loop_nop_1x5, .name = "loop_nop_1x5" },
        .{ .function = loop_nop_1x9, .name = "loop_nop_1x9" },
    });
}
