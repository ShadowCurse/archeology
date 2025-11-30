const std = @import("std");
const testing = @import("testing.zig");

extern fn read_strided_32x2(data: [*]const u8, u64, additional_input: [*]const u8, u64) void;

pub fn main() !void {
    const cache_line_size: u64 = 64;
    const outer_loop_count: u64 = 256;
    const inner_loop_count: u64 = 256;
    const strides: u64 = 128;
    const total_bytes = cache_line_size * inner_loop_count * strides;
    for (0..strides) |i| {
        const stride = cache_line_size * i;
        std.log.info("testing cache stride: {d}", .{stride});
        const additional_input = [_]u64{ outer_loop_count, inner_loop_count, stride };
        try testing.run(&[_]testing.Description{
            .{
                .function = read_strided_32x2,
                .name = "read_strided_32x2",
                .input_size = total_bytes,
            },
        }, @ptrCast(&additional_input));
    }
}
