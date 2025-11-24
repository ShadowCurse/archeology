const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_write_1(data: [*]const u8, len: u64) void;
extern fn loop_write_2(data: [*]const u8, len: u64) void;
extern fn loop_write_3(data: [*]const u8, len: u64) void;
extern fn loop_write_4(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_write_1, .name = "loop_write_1" },
        .{ .function = loop_write_2, .name = "loop_write_2" },
        .{ .function = loop_write_3, .name = "loop_write_3" },
        .{ .function = loop_write_4, .name = "loop_write_4" },
    });
}
