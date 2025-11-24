const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_read_1(data: [*]const u8, len: u64) void;
extern fn loop_read_2(data: [*]const u8, len: u64) void;
extern fn loop_read_3(data: [*]const u8, len: u64) void;
extern fn loop_read_4(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_read_1, .name = "loop_read_1" },
        .{ .function = loop_read_2, .name = "loop_read_2" },
        .{ .function = loop_read_3, .name = "loop_read_3" },
        .{ .function = loop_read_4, .name = "loop_read_4" },
    });
}
