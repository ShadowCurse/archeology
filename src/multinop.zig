const std = @import("std");
const testing = @import("testing.zig");

extern fn nop_3x1(data: [*]const u8, len: u64) void;
extern fn nop_1x3(data: [*]const u8, len: u64) void;
extern fn nop_1x4(data: [*]const u8, len: u64) void;
extern fn nop_1x5(data: [*]const u8, len: u64) void;
extern fn nop_1x9(data: [*]const u8, len: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = nop_3x1, .name = "nop_3x1", .input_type = .not_used },
    .{ .function = nop_1x3, .name = "nop_1x3", .input_type = .not_used },
    .{ .function = nop_1x4, .name = "nop_1x4", .input_type = .not_used },
    .{ .function = nop_1x5, .name = "nop_1x5", .input_type = .not_used },
    .{ .function = nop_1x9, .name = "nop_1x9", .input_type = .not_used },
};

pub fn main() !void {
    const results = try testing.run(&TESTS, &.{}, &.{});
    testing.print_header(&.{});
    testing.print_results(&TESTS, &results, &.{});
}
