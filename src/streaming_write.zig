const std = @import("std");
const testing = @import("testing.zig");

extern fn standard_write(data: [*]const u8, _: u64, additional_data: [*]const u8, _: u64) void;
extern fn streaming_write(data: [*]const u8, _: u64, additional_data: [*]const u8, _: u64) void;

const TESTS = [_]testing.Description{
    .{ .function = standard_write, .name = "standard_write" },
    .{ .function = streaming_write, .name = "streaming_write" },
};

const SINGLE_READ_SIZE = 256;
const SOURCE_SIZE = 1 << 20;
const DEST_SIZE = 1 << 30;
const NUMBER_OF_TESTS = 128;

pub fn main() !void {
    var results: [NUMBER_OF_TESTS][2]testing.Result = undefined;
    const source = try testing.create_input(SOURCE_SIZE, .pattern_all_0);
    var inner_loop_count: u64 = 1;
    var i: u64 = 0;
    while (inner_loop_count * SINGLE_READ_SIZE < SOURCE_SIZE and i < NUMBER_OF_TESTS) : ({
        inner_loop_count *= 2;
        i += 1;
    }) {
        const outer_loop_count = DEST_SIZE / (inner_loop_count * SINGLE_READ_SIZE);
        const additional_data = [_]u64{
            outer_loop_count,
            inner_loop_count,
            @intFromPtr(source.ptr),
        };
        results[i] = try testing.run(
            &[_]testing.Description{
                .{ .function = standard_write, .name = "standard_write" },
                .{ .function = streaming_write, .name = "streaming_write" },
            },
            @ptrCast(&additional_data),
            &.{.{ .name = "write_size", .value = inner_loop_count * SINGLE_READ_SIZE }},
        );
    }
    testing.print_header(&.{.{ .name = "write_size" }});
    inner_loop_count = 1;
    i = 0;
    while (inner_loop_count * SINGLE_READ_SIZE < SOURCE_SIZE and i < NUMBER_OF_TESTS) : ({
        inner_loop_count *= 2;
        i += 1;
    })
        testing.print_results(
            &TESTS,
            &results[i],
            &.{.{ .value = inner_loop_count * SINGLE_READ_SIZE }},
        );
}
