const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lpcg_random = b.addStaticLibrary(.{
        .name = "pcg_random",
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    var flags = std.ArrayList([]const u8).init(b.allocator);
    defer flags.deinit();
    try flags.appendSlice(&.{ "-std=c99", "-03" });

    const srcs = &.{
        "pcg-c/src/pcg-rngs-8.c",
        "pcg-c/src/pcg-rngs-16.c",
        "pcg-c/src/pcg-rngs-32.c",
        "pcg-c/src/pcg-rngs-64.c",
        "pcg-c/src/pcg-rngs-128.c",
        "pcg-c/src/pcg-output-8.c",
        "pcg-c/src/pcg-output-16.c",
        "pcg-c/src/pcg-output-32.c",
        "pcg-c/src/pcg-output-64.c",
        "pcg-c/src/pcg-output-128.c",
        "pcg-c/src/pcg-global-32.c",
        "pcg-c/src/pcg-global-64.c",
        "pcg-c/src/pcg-advance-8.c",
        "pcg-c/src/pcg-advance-16.c",
        "pcg-c/src/pcg-advance-32.c",
        "pcg-c/src/pcg-advance-64.c",
        "pcg-c/src/pcg-advance-128.c",
    };

    lpcg_random.addCSourceFiles(.{
        .files = srcs,
        .flags = &.{ "-std=c99", "-O3" },
    });
    lpcg_random.linkLibC();

    lpcg_random.addIncludePath(.{ .cwd_relative = "pcg-c/include" });

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lpcg_random);

    const targets_test_high = [_][]const u8{
        "check-pcg128i",
        "check-pcg128si",
        "check-pcg16i",
        "check-pcg16si",
        "check-pcg32",
        "check-pcg32f",
        "check-pcg32i",
        "check-pcg32s",
        "check-pcg32si",
        "check-pcg32u",
        "check-pcg64",
        "check-pcg64f",
        "check-pcg64i",
        "check-pcg64s",
        "check-pcg64si",
        "check-pcg64u",
        "check-pcg8i",
        "check-pcg8si",
        "check-pcg32-global",
        "check-pcg64-global",
    };

    const entropy_obj = b.addObject(.{
        .name = "entropy",
        .target = target,
        .optimize = optimize,
    });

    entropy_obj.addCSourceFiles(.{
        .files = &.{"pcg-c/extras/entropy.c"},
        .flags = &.{"-std=c99"},
    });
    entropy_obj.addIncludePath(.{ .cwd_relative = "pcg-c/include" });
    entropy_obj.addIncludePath(.{ .cwd_relative = "pcg-c/extras" });
    entropy_obj.linkLibC();

    // const c_flags = [_][]const u8{"-std=c99"};

    // TODO: refactor into a function
    inline for (targets_test_high) |target_name| {
        const exe = b.addExecutable(.{
            .name = target_name,
            .target = target,
            .optimize = optimize,
        });
        // exe.addLibraryPath(.{ .cwd_relative = "pcg-c/src/test-high" });
        // exe.addCSourceFile(.{
        //     .file = .{ .cwd_relative = "pcg-c/test-high/" ++ target_name ++ ".c" },
        //     .flags = &.{ "-std=c99", "-include", "pcg-c/test-high/check-base.c" },
        // });
        // exe.addCSourceFile(.{
        //     .file = .{ .cwd_relative = "pcg-c/test-high/check-base.c" },
        //     .flags = &c_flags,
        // });
        exe.addCSourceFiles(.{
            .root = .{ .cwd_relative = "pcg-c/test-high" },
            .files = &.{target_name ++ ".c"},
            .flags = &.{"-std=c99"},
        });

        exe.addIncludePath(.{ .cwd_relative = "pcg-c/include" });
        exe.addIncludePath(.{ .cwd_relative = "pcg-c/extras" });
        exe.addIncludePath(.{ .cwd_relative = "pcg-c/test-high" });
        exe.addObject(entropy_obj);
        exe.linkLibC();
        exe.linkLibrary(lpcg_random);
        // exe.addLibraryPath(.{ .cwd_relative = "pcg-c/src" });

        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());

        const run_step = b.step(target_name, "Run ");
        run_step.dependOn(&run_cmd.step);
    }

    const test_step = b.step("Test", "Run all tests");
    _ = test_step;

    // const exe = b.addExecutable(.{
    //     .name = "pcg-zig",
    //     .root_source_file = b.path("src/main.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });

    // const test_srcs = &.{
    //     "pcg-c/test-high/check-base.c",
    // };

    // _ = test_srcs;

    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    // b.installArtifact(exe);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    // const run_cmd = b.addRunArtifact(exe);

    // By making the run step depend on the install step, it will be run from the
    // installation directory rather than directly from within the cache directory.
    // This is not necessary, however, if the application depends on other installed
    // files, this ensures they will be present and in the expected location.
    // run_cmd.step.dependOn(b.getInstallStep());

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    // if (b.args) |args| {
    //     run_cmd.addArgs(args);
    // }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    // const run_step = b.step("run", "Run the app");
    // run_step.dependOn(&run_cmd.step);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    // const lib_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });

    // const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    // const exe_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/main.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });

    // const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // // Similar to creating the run step earlier, this exposes a `test` step to
    // // the `zig build --help` menu, providing a way for the user to request
    // // running the unit tests.
    // const test_step = b.step("test", "Run unit tests");
    // test_step.dependOn(&run_lib_unit_tests.step);
    // test_step.dependOn(&run_exe_unit_tests.step);
}

// fn addTests(
//     b: *std.Build,
//     optimize: std.builtin.OptimizeMode,
// ) !struct { *std.Build.Step, std.Build.LazyPath } {
//     for (targets) |target_name| {
//         const exe = b.addExecutable(.{
//             .name = target_name,
//             .target = target,
//             .optimize = optimize,
//         });
//     }
// }
