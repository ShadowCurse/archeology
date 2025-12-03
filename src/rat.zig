const std = @import("std");
const testing = @import("testing.zig");

extern fn rat_add(data: [*]const u8, len: u64) void;
extern fn rat_mov_add(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = rat_add, .name = "rat_add", .input_type = .not_used },
    .{ .function = rat_mov_add, .name = "rat_mov_add", .input_type = .not_used },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
