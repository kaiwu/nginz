const std = @import("std");

pub const QUICKJS_C_FLAGS = [_][]const u8{
    "-std=gnu11",
    "-D_GNU_SOURCE",
    "-fvisibility=hidden",
    "-Wall",
    "-Werror",
    "-Wextra",
    "-Wformat=2",
    "-Wno-implicit-fallthrough",
    "-Wno-sign-compare",
    "-Wno-missing-field-initializers",
    "-Wno-unused-parameter",
    "-Wno-unused-but-set-variable",
    "-Wno-unused-result",
    //"-Wno-stringop-truncation",
    "-Wno-array-bounds",
    "-funsigned-char",
};

const files = [_][]const u8{
    "submodules/quickjs-ng/cutils.c",
    "submodules/quickjs-ng/libbf.c",
    "submodules/quickjs-ng/libregexp.c",
    "submodules/quickjs-ng/libunicode.c",
    "submodules/quickjs-ng/quickjs.c",
    "submodules/quickjs-ng/quickjs-libc.c",
};

pub fn build_quickjs(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) *std.Build.Step.Compile {
    const quickjs = b.addStaticLibrary(.{
        .name = "quickjs",
        .target = target,
        .optimize = optimize,
    });

    quickjs.linkLibC();
    quickjs.linkSystemLibrary("m");
    quickjs.linkSystemLibrary("dl");
    quickjs.addCSourceFiles(.{
        .files = &files,
        .flags = &QUICKJS_C_FLAGS,
    });

    b.installArtifact(quickjs);
    return quickjs;
}
