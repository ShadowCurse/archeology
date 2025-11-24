const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_align_64(data: [*]const u8, len: u64) void;
extern fn loop_align_1(data: [*]const u8, len: u64) void;
extern fn loop_align_15(data: [*]const u8, len: u64) void;
extern fn loop_align_31(data: [*]const u8, len: u64) void;
extern fn loop_align_63(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_align_64, .name = "loop_align_64" },
        .{ .function = loop_align_1, .name = "loop_align_1" },
        .{ .function = loop_align_15, .name = "loop_align_15" },
        .{ .function = loop_align_31, .name = "loop_align_31" },
        .{ .function = loop_align_63, .name = "loop_align_63" },
    });
}
