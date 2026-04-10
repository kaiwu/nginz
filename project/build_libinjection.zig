const std = @import("std");

pub const LIBINJECTION_C_FLAGS = [_][]const u8{
    "-std=gnu11",
    "-Wall",
    "-Wextra",
    "-Wno-unused-parameter",
    "-Wno-sign-compare",
    "-fno-sanitize=all",
    "-DLIBINJECTION_VERSION=\"4.0.0-nginz\"",
};

const files = [_][]const u8{
    "src/c/libinjection/libinjection_sqli.c",
    "src/c/libinjection/libinjection_xss.c",
    "src/c/libinjection/libinjection_html5.c",
};

pub fn build_libinjection(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) *std.Build.Step.Compile {
    const libinjection = b.addLibrary(.{
        .name = "libinjection",
        .root_module = b.createModule(.{
            .pic = true,
            .target = target,
            .optimize = optimize,
        }),
    });

    libinjection.linkLibC();
    libinjection.addIncludePath(b.path("src/c/libinjection"));
    libinjection.addCSourceFiles(.{
        .files = &files,
        .flags = &LIBINJECTION_C_FLAGS,
    });

    b.installArtifact(libinjection);
    return libinjection;
}
