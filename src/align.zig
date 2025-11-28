const std = @import("std");
const testing = @import("testing.zig");

extern fn align_64(data: [*]const u8, len: u64) void;
extern fn align_1(data: [*]const u8, len: u64) void;
extern fn align_15(data: [*]const u8, len: u64) void;
extern fn align_31(data: [*]const u8, len: u64) void;
extern fn align_63(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{ .function = align_64, .name = "align_64" },
        .{ .function = align_1, .name = "align_1" },
        .{ .function = align_15, .name = "align_15" },
        .{ .function = align_31, .name = "align_31" },
        .{ .function = align_63, .name = "align_63" },
    },&.{});
}
