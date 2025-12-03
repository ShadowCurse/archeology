const std = @import("std");
const testing = @import("testing.zig");

extern fn read_1(data: [*]const u8, len: u64) void;
extern fn read_2(data: [*]const u8, len: u64) void;
extern fn read_3(data: [*]const u8, len: u64) void;
extern fn read_4(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = read_1, .name = "read_1" },
    .{ .function = read_2, .name = "read_2" },
    .{ .function = read_3, .name = "read_3" },
    .{ .function = read_4, .name = "read_4" },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
