const std = @import("std");
const testing = @import("testing.zig");

extern fn conditional_nop(data: [*]const u8, len: u64) void;

pub fn main() !void {
    try testing.run(&[_]testing.Description{
        .{
            .function = conditional_nop,
            .name = "conditional_nop_random",
            .input_type = .random,
        },
        .{
            .function = conditional_nop,
            .name = "conditional_nop_pattern_all_0",
            .input_type = .pattern_all_0,
        },
        .{
            .function = conditional_nop,
            .name = "conditional_nop_pattern_all_1",
            .input_type = .pattern_all_1,
        },
        .{
            .function = conditional_nop,
            .name = "conditional_nop_pattern_every_2",
            .input_type = .pattern_every_2,
        },
        .{
            .function = conditional_nop,
            .name = "conditional_nop_pattern_every_3",
            .input_type = .pattern_every_3,
        },
        .{
            .function = conditional_nop,
            .name = "conditional_nop_pattern_every_4",
            .input_type = .pattern_every_4,
        },
    });
}
