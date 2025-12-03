const std = @import("std");
const testing = @import("testing.zig");

extern fn read_4x2(data: [*]const u8, len: u64) void;
extern fn read_8x2(data: [*]const u8, len: u64) void;
extern fn read_16x2(data: [*]const u8, len: u64) void;
extern fn read_32x2(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = read_4x2, .name = "read_4x2" },
    .{ .function = read_8x2, .name = "read_8x2" },
    .{ .function = read_16x2, .name = "read_16x2" },
    .{ .function = read_32x2, .name = "read_32x2" },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
