const std = @import("std");
const testing = @import("testing.zig");

extern fn test_mov(data: [*]const u8, len: u64) void;
extern fn test_nop(data: [*]const u8, len: u64) void;
extern fn test_cmp(data: [*]const u8, len: u64) void;
extern fn test_dec(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = test_mov, .name = "test_mov" },
        .{ .function = test_nop, .name = "test_nop" },
        .{ .function = test_cmp, .name = "test_cmp" },
        .{ .function = test_dec, .name = "test_dec" },
    },&.{});
}
