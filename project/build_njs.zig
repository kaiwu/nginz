const std = @import("std");
const common = @import("build_common.zig");

const NJS_C_FLAGS = [_][]const u8{
    "-fvisibility=hidden",
    "-Wall",
    "-Werror",
    "-Wextra",
    "-Wno-unused-parameter",
    "-Wwrite-strings",
    "-Wmissing-prototypes",
    "-fexcess-precision=standard",
    "-Wpointer-arith",
};

const NJS_INCLUDE_PATH = [_][]const u8{
    "submodules/quickjs",
    "submodules/njs/src",
    "submodules/njs/build",
    "submodules/njs/external",
};

const modules_files = .{
    "submodules/njs/build/njs_modules.c",
    "submodules/njs/build/qjs_modules.c",
};

const http_module_files = .{
    "submodules/njs/nginx/ngx_http_js_module.c",
    "submodules/njs/nginx/ngx_js.c",
    "submodules/njs/nginx/ngx_js_fetch.c",
    "submodules/njs/nginx/ngx_js_regex.c",
    "submodules/njs/nginx/ngx_js_shared_dict.c",
};

pub fn build_njs(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    quickjs: *std.Build.Step.Compile,
) !*std.Build.Step.Compile {
    const njs = b.addStaticLibrary(.{
        .pic = true,
        .name = "njs",
        .target = target,
        .optimize = optimize,
    });

    var files = std.ArrayList([]const u8).init(b.allocator);
    defer files.deinit();
    const n = try common.list("./submodules/njs/src", 0, &common.BUILD_BUFFER, &files);
    _ = try common.list("./submodules/njs/external", n, &common.BUILD_BUFFER, &files);

    try common.append(&files, &modules_files);

    for (NJS_INCLUDE_PATH) |p| {
        njs.addIncludePath(b.path(p));
    }
    njs.linkLibC();
    njs.linkSystemLibrary("z");
    njs.linkSystemLibrary("ssl");
    njs.addCSourceFiles(.{
        .files = files.items[0..],
        .flags = &NJS_C_FLAGS,
    });

    njs.step.dependOn(&quickjs.step);
    njs.linkLibrary(quickjs);

    // b.installArtifact(njs);

    const http_njs = b.addObject(.{
        .pic = true,
        .name = "ngx_http_js_module",
        .target = target,
        .optimize = optimize,
    });

    http_njs.linkLibC();
    http_njs.step.dependOn(&njs.step);
    http_njs.linkLibrary(njs);
    http_njs.linkLibrary(quickjs);
    http_njs.addIncludePath(b.path("submodules/njs/nginx"));
    for (common.NGX_INCLUDE_PATH) |p| {
        http_njs.addIncludePath(b.path(p));
    }
    for (NJS_INCLUDE_PATH) |p| {
        http_njs.addIncludePath(b.path(p));
    }

    http_njs.addCSourceFiles(.{
        .files = &http_module_files,
        .flags = &common.C_FLAGS,
    });
    const install_object = b.addInstallFile(http_njs.getEmittedBin(), "ngx_http_js_module.o");
    b.getInstallStep().dependOn(&install_object.step);

    return http_njs;
}
