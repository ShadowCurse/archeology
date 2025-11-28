const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    compile_and_link_asm(b, target, optimize, "nop");
    compile_and_link_asm(b, target, optimize, "multinop");
    compile_and_link_asm(b, target, optimize, "conditional_nop");
    compile_and_link_asm(b, target, optimize, "align");
    compile_and_link_asm(b, target, optimize, "rat");
    compile_and_link_asm(b, target, optimize, "read");
    compile_and_link_asm(b, target, optimize, "write");
    compile_and_link_asm(b, target, optimize, "read_width");
    compile_and_link_asm(b, target, optimize, "cache_size");
}

fn compile_and_link_asm(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    name: []const u8,
) void {
    const path_src = std.fmt.allocPrint(b.allocator, "src/{s}.zig", .{name}) catch unreachable;
    const path_asm = std.fmt.allocPrint(
        b.allocator,
        "src/asm/{s}.{t}.asm",
        .{ name, builtin.cpu.arch },
    ) catch unreachable;
    const path_obj = std.fmt.allocPrint(
        b.allocator,
        "src/asm/{s}.{t}.o",
        .{ name, builtin.cpu.arch },
    ) catch unreachable;

    const exe_mod = b.createModule(.{
        .root_source_file = b.path(path_src),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = name,
        .root_module = exe_mod,
    });

    const command = b.addSystemCommand(&.{
        "nasm",
        "-f",
        "elf64",
        path_asm,
    });
    exe.step.dependOn(&command.step);
    exe.root_module.addObjectFile(b.path(path_obj));

    b.installArtifact(exe);

    const run_step = b.step(name, "");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
}
