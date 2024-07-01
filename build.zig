const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lpcg_random = b.addStaticLibrary(.{
        .name = "pcg_random",
        .root_source_file = null,
        .target = target,
        .optimize = .ReleaseFast,
    });

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

    inline for (targets_test_high) |target_name| {
        const exe = b.addExecutable(.{
            .name = target_name,
            .target = target,
            .optimize = optimize,
        });

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

        b.installArtifact(exe);
    }

    // test-low
    const targets_test_low = [_][]const u8{
        "check-mcg-128-rxs-m-64",
        "check-mcg-128-xsh-rr-64",
        "check-mcg-128-xsh-rs-64",
        "check-mcg-128-xsl-rr-64",
        "check-mcg-16-rxs-m-8",
        "check-mcg-16-xsh-rr-8",
        "check-mcg-16-xsh-rs-8",
        "check-mcg-32-rxs-m-16",
        "check-mcg-32-xsh-rr-16",
        "check-mcg-32-xsh-rs-16",
        "check-mcg-64-rxs-m-32",
        "check-mcg-64-xsh-rr-32",
        "check-mcg-64-xsh-rs-32",
        "check-mcg-64-xsl-rr-32",
        "check-oneseq-128-rxs-m-64",
        "check-oneseq-128-rxs-m-xs-128",
        "check-oneseq-128-xsh-rr-64",
        "check-oneseq-128-xsh-rs-64",
        "check-oneseq-128-xsl-rr-64",
        "check-oneseq-128-xsl-rr-rr-128",
        "check-oneseq-16-rxs-m-8",
        "check-oneseq-16-rxs-m-xs-16",
        "check-oneseq-16-xsh-rr-8",
        "check-oneseq-16-xsh-rs-8",
        "check-oneseq-32-rxs-m-16",
        "check-oneseq-32-rxs-m-xs-32",
        "check-oneseq-32-xsh-rr-16",
        "check-oneseq-32-xsh-rs-16",
        "check-oneseq-64-rxs-m-32",
        "check-oneseq-64-rxs-m-xs-64",
        "check-oneseq-64-xsh-rr-32",
        "check-oneseq-64-xsh-rs-32",
        "check-oneseq-64-xsl-rr-32",
        "check-oneseq-64-xsl-rr-rr-64",
        "check-oneseq-8-rxs-m-xs-8",
        "check-setseq-128-rxs-m-64",
        "check-setseq-128-rxs-m-xs-128",
        "check-setseq-128-xsh-rr-64",
        "check-setseq-128-xsh-rs-64",
        "check-setseq-128-xsl-rr-64",
        "check-setseq-128-xsl-rr-rr-128",
        "check-setseq-16-rxs-m-8",
        "check-setseq-16-rxs-m-xs-16",
        "check-setseq-16-xsh-rr-8",
        "check-setseq-16-xsh-rs-8",
        "check-setseq-32-rxs-m-16",
        "check-setseq-32-rxs-m-xs-32",
        "check-setseq-32-xsh-rr-16",
        "check-setseq-32-xsh-rs-16",
        "check-setseq-64-rxs-m-32",
        "check-setseq-64-rxs-m-xs-64",
        "check-setseq-64-xsh-rr-32",
        "check-setseq-64-xsh-rs-32",
        "check-setseq-64-xsl-rr-32",
        "check-setseq-64-xsl-rr-rr-64",
        "check-setseq-8-rxs-m-xs-8",
        "check-unique-128-rxs-m-64",
        "check-unique-128-rxs-m-xs-128",
        "check-unique-128-xsh-rr-64",
        "check-unique-128-xsh-rs-64",
        "check-unique-128-xsl-rr-64",
        "check-unique-128-xsl-rr-rr-128",
        "check-unique-16-rxs-m-8",
        "check-unique-16-rxs-m-xs-16",
        "check-unique-16-xsh-rr-8",
        "check-unique-16-xsh-rs-8",
        "check-unique-32-rxs-m-16",
        "check-unique-32-rxs-m-xs-32",
        "check-unique-32-xsh-rr-16",
        "check-unique-32-xsh-rs-16",
        "check-unique-64-rxs-m-32",
        "check-unique-64-rxs-m-xs-64",
        "check-unique-64-xsh-rr-32",
        "check-unique-64-xsh-rs-32",
        "check-unique-64-xsl-rr-32",
        "check-unique-64-xsl-rr-rr-64",
    };

    inline for (targets_test_low) |target_name| {
        const exe = b.addExecutable(.{
            .name = target_name,
            .target = target,
            .optimize = optimize,
        });

        exe.addCSourceFiles(.{
            .root = .{ .cwd_relative = "pcg-c/test-low" },
            .files = &.{target_name ++ ".c"},
            .flags = &.{"-std=c99"},
        });

        exe.addIncludePath(.{ .cwd_relative = "pcg-c/include" });
        exe.addIncludePath(.{ .cwd_relative = "pcg-c/extras" });
        exe.addIncludePath(.{ .cwd_relative = "pcg-c/test-low" });
        //exe.addLibraryPath(.{ .cwd_relative = "pcg-c/src" });
        exe.addObject(entropy_obj);
        exe.linkLibC();
        exe.linkLibrary(lpcg_random);

        b.installArtifact(exe);
    }

    // sample
    const targets_sample = [_][]const u8{
        "pcg32-demo",
        "pcg32-global-demo",
        "pcg32x2-demo",
        "pcg64-demo",
    };

    inline for (targets_sample) |target_name| {
        const exe = b.addExecutable(.{
            .name = target_name,
            .target = target,
            .optimize = optimize,
        });

        exe.addCSourceFiles(.{
            .root = .{ .cwd_relative = "pcg-c/sample" },
            .files = &.{target_name ++ ".c"},
            .flags = &.{"-std=c99"},
        });

        exe.addIncludePath(.{ .cwd_relative = "pcg-c/include" });
        exe.addIncludePath(.{ .cwd_relative = "pcg-c/extras" });
        exe.addObject(entropy_obj);
        exe.linkLibC();
        exe.linkLibrary(lpcg_random);

        b.installArtifact(exe);
    }
}
