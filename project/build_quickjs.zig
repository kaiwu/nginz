const std = @import("std");

pub const QUICKJS_C_FLAGS = [_][]const u8{
    "-std=gnu11",
    "-D_GNU_SOURCE",
    "-DCONFIG_VERSION=\"2024-02-14\"",
    "-DCONFIG_BIGNUM",
    "-DHAVE_CLOSEFROM",
    "-Wall",
    "-Wextra",
    "-Wno-sign-compare",
    "-Wno-missing-field-initializers",
    "-Wno-cast-function-type-mismatch",
    "-Wundef",
    "-Wuninitialized",
    "-Wunused",
    "-Wno-unused-parameter",
    "-Wwrite-strings",
    "-Wchar-subscripts",
    "-funsigned-char",
    "-fwrapv",
};

const files = [_][]const u8{
    "submodules/quickjs/dtoa.c",
    "submodules/quickjs/cutils.c",
    "submodules/quickjs/libregexp.c",
    "submodules/quickjs/libunicode.c",
    "submodules/quickjs/quickjs.c",
    "submodules/quickjs/quickjs-libc.c",
};

pub fn build_quickjs(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) *std.Build.Step.Compile {
    const quickjs = b.addLibrary(.{
        .name = "quickjs",
        .root_module = b.createModule(.{
            .pic = true,
            .target = target,
            .optimize = optimize,
        }),
    });

    quickjs.linkLibC();
    quickjs.addCSourceFiles(.{
        .files = &files,
        .flags = &QUICKJS_C_FLAGS,
    });

    b.installArtifact(quickjs);
    return quickjs;
}
