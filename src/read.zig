const std = @import("std");
const testing = @import("testing.zig");

extern fn read_1(data: [*]const u8, len: u64) void;
extern fn read_2(data: [*]const u8, len: u64) void;
extern fn read_3(data: [*]const u8, len: u64) void;
extern fn read_4(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = read_1, .name = "read_1" },
        .{ .function = read_2, .name = "read_2" },
        .{ .function = read_3, .name = "read_3" },
        .{ .function = read_4, .name = "read_4" },
    });
}
