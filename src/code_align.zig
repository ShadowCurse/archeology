const std = @import("std");
const testing = @import("testing.zig");

extern fn align_64(data: [*]const u8, len: u64) void;
extern fn align_1(data: [*]const u8, len: u64) void;
extern fn align_15(data: [*]const u8, len: u64) void;
extern fn align_31(data: [*]const u8, len: u64) void;
extern fn align_63(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = align_64, .name = "align_64", .input_type = .not_used },
    .{ .function = align_1, .name = "align_1", .input_type = .not_used },
    .{ .function = align_15, .name = "align_15", .input_type = .not_used },
    .{ .function = align_31, .name = "align_31", .input_type = .not_used },
    .{ .function = align_63, .name = "align_63", .input_type = .not_used },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
