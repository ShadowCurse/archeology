const std = @import("std");
const testing = @import("testing.zig");

extern fn loop_mov(data: [*]const u8, len: u64) void;
extern fn loop_nop(data: [*]const u8, len: u64) void;
extern fn loop_cmp(data: [*]const u8, len: u64) void;
extern fn loop_dec(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = loop_mov, .name = "loop_mov" },
        .{ .function = loop_nop, .name = "loop_nop" },
        .{ .function = loop_cmp, .name = "loop_cmp" },
        .{ .function = loop_dec, .name = "loop_dec" },
    });
}
