const std = @import("std");
const testing = @import("testing.zig");

extern fn read_strided_32x2(data: [*]const u8, u64, additional_input: [*]const u8, u64) void;

const TESTS = [_]testing.Description{
    .{
        .function = read_strided_32x2,
        .name = "read_strided_32x2",
        .input_size = TOTAL_BYTES,
    },
};

const CACHE_LINE_SIZE: u64 = 64;
const OUTER_LOOP_COUNT: u64 = 256;
const INNER_LOOP_COUNT: u64 = 256;
const STRIDES: u64 = 128;
const TOTAL_BYTES = CACHE_LINE_SIZE * INNER_LOOP_COUNT * STRIDES;

pub fn main() !void {
    var results: [STRIDES][1]testing.Result = undefined;
    for (&results, 0..STRIDES) |*result, i| {
        const stride = CACHE_LINE_SIZE * i;
        std.log.info("testing cache stride: {d}", .{stride});
        const additional_input = [_]u64{ OUTER_LOOP_COUNT, INNER_LOOP_COUNT, stride };
        result.* = try testing.run(
            &TESTS,
            @ptrCast(&additional_input),
            &.{.{ .name = "cache_stride", .value = stride }},
        );
    }

    testing.print_header(&.{.{ .name = "cache_stride" }});
    for (&results, 0..STRIDES) |*result, i| {
        const stride = CACHE_LINE_SIZE * i;
        testing.print_results(&TESTS, result, &.{.{ .value = stride }});
    }
}
