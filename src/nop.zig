const std = @import("std");
const testing = @import("testing.zig");

extern fn test_mov(data: [*]const u8, len: u64) void;
extern fn test_nop(data: [*]const u8, len: u64) void;
extern fn test_cmp(data: [*]const u8, len: u64) void;
extern fn test_dec(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = test_mov, .name = "test_mov", .input_type = .not_used },
    .{ .function = test_nop, .name = "test_nop", .input_type = .not_used },
    .{ .function = test_cmp, .name = "test_cmp", .input_type = .not_used },
    .{ .function = test_dec, .name = "test_dec", .input_type = .not_used },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
