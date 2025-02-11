const std = @import("std");

pub const CJSON_C_FLAGS = [_][]const u8{
    "-std=c89",
    "-pedantic",
    "-Wall",
    "-Wextra",
    "-Werror",
    "-Wstrict-prototypes",
    "-Wwrite-strings",
    "-Wshadow",
    "-Winit-self",
    "-Wcast-align",
    "-Wformat=2",
    "-Wmissing-prototypes",
    "-Wstrict-overflow=2",
    "-Wcast-qual",
    "-Wundef",
    "-Wswitch-default",
    "-Wconversion",
    "-Wc++-compat",
    "-fstack-protector-strong",
    "-Wcomma",
    "-Wdouble-promotion",
    "-Wparentheses",
    "-Wformat-overflow",
    "-Wunused-macros",
    "-Wmissing-variable-declarations",
    //"-Wused-but-marked-unused",
    "-Wswitch-enum",
    "-fno-sanitize=all",
};

const files = [_][]const u8{
    "src/c/cJSON.c",
};

pub fn build_cjson(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) *std.Build.Step.Compile {
    const cjson = b.addStaticLibrary(.{
        .pic = true,
        .name = "cjson",
        .target = target,
        .optimize = optimize,
    });

    cjson.linkLibC();
    cjson.addCSourceFiles(.{
        .files = &files,
        .flags = &CJSON_C_FLAGS,
    });

    b.installArtifact(cjson);
    return cjson;
}
