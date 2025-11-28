const std = @import("std");
const testing = @import("testing.zig");

extern fn rat_add(data: [*]const u8, len: u64) void;
extern fn rat_mov_add(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = rat_add, .name = "rat_add" },
        .{ .function = rat_mov_add, .name = "rat_mov_add" },
    },&.{});
}
