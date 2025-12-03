const std = @import("std");
const testing = @import("testing.zig");

extern fn write_1(data: [*]const u8, len: u64) void;
extern fn write_2(data: [*]const u8, len: u64) void;
extern fn write_3(data: [*]const u8, len: u64) void;
extern fn write_4(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = write_1, .name = "write_1" },
    .{ .function = write_2, .name = "write_2" },
    .{ .function = write_3, .name = "write_3" },
    .{ .function = write_4, .name = "write_4" },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
