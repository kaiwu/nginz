const std = @import("std");
const common = @import("build_common.zig");

const quickjs_version = std.mem.trim(u8, @embedFile("../submodules/quickjs/VERSION"), &std.ascii.whitespace);

pub const QUICKJS_C_FLAGS = [_][]const u8{
    "-std=gnu11",
    "-D_GNU_SOURCE",
    std.fmt.comptimePrint("-DCONFIG_VERSION=\"{s}\"", .{quickjs_version}),
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
            .optimize = common.c_optimize(optimize),
            .link_libc = true,
        }),
    });

    quickjs.root_module.addCSourceFiles(.{
        .files = &files,
        .flags = &QUICKJS_C_FLAGS,
    });

    b.installArtifact(quickjs);
    return quickjs;
}
