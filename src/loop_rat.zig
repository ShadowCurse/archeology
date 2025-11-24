const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_rat_add(data: [*]const u8, len: u64) void;
extern fn loop_rat_mov_add(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_rat_add, .name = "loop_rat_add" },
        .{ .function = loop_rat_mov_add, .name = "loop_rat_mov_add" },
    });
}
