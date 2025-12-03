const std = @import("std");
const testing = @import("testing.zig");

extern fn standard_write(data: [*]const u8, _: u64, additional_data: [*]const u8, _: u64) void;
extern fn streaming_write(data: [*]const u8, _: u64, additional_data: [*]const u8, _: u64) void;
const SINGLE_READ_SIZE = 256;
const SOURCE_SIZE = 1 << 20;
const DEST_SIZE = 1 << 30;

pub fn main() !void {
    const source = try testing.create_input(SOURCE_SIZE, .pattern_all_0);
    var inner_loop_count: u64 = 1;
    while (inner_loop_count * SINGLE_READ_SIZE < SOURCE_SIZE) : (inner_loop_count += 1) {
        const outer_loop_count = DEST_SIZE / (inner_loop_count * SINGLE_READ_SIZE);
        const additional_data = [_]u64{
            outer_loop_count,
            inner_loop_count,
            @intFromPtr(source.ptr),
        };
        std.log.info("testing write {d}B * {d} iter = {d}B", .{
            inner_loop_count * SINGLE_READ_SIZE,
            outer_loop_count,
            inner_loop_count * SINGLE_READ_SIZE * outer_loop_count,
        });
        try testing.run(&[_]testing.Description{
            .{ .function = standard_write, .name = "standard_write" },
            .{ .function = streaming_write, .name = "streaming_write" },
        }, @ptrCast(&additional_data));
    }
}
