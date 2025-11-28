const std = @import("std");
const testing = @import("testing.zig");

extern fn nop_3x1(data: [*]const u8, len: u64) void;
extern fn nop_1x3(data: [*]const u8, len: u64) void;
extern fn nop_1x4(data: [*]const u8, len: u64) void;
extern fn nop_1x5(data: [*]const u8, len: u64) void;
extern fn nop_1x9(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = nop_3x1, .name = "nop_3x1" },
        .{ .function = nop_1x3, .name = "nop_1x3" },
        .{ .function = nop_1x4, .name = "nop_1x4" },
        .{ .function = nop_1x5, .name = "nop_1x5" },
        .{ .function = nop_1x9, .name = "nop_1x9" },
    },&.{});
}
