const std = @import("std");
const common = @import("build_common.zig");
const libxml2 = std.Build.LazyPath{ .cwd_relative = "/usr/include/libxml2" };
const ArrayList = std.array_list.Managed;

pub fn build_modules(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) !*std.Build.Step.Compile {
    const modules = b.addLibrary(.{
        .name = "ngx_modules",
        .root_module = b.createModule(.{
            .pic = true,
            .target = target,
            .optimize = optimize,
        }),
    });

    var files = ArrayList([]const u8).init(b.allocator);
    defer files.deinit();
    _ = try common.list("submodules/nginx/src/http/modules", 0, &common.BUILD_BUFFER, &files);

    for (common.NGX_INCLUDE_PATH) |p| {
        modules.addIncludePath(b.path(p));
    }
    modules.addSystemIncludePath(libxml2);
    modules.linkLibC();
    modules.addCSourceFiles(.{
        .files = files.items[0..],
        .flags = &common.C_FLAGS,
    });

    // b.installArtifact(modules);
    return modules;
}

// for test only
pub fn build_test_modules(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) !*std.Build.Step.Compile {
    const modules = b.addLibrary(.{
        .name = "ngx_test_modules",
        .root_module = b.createModule(.{
            .pic = true,
            .target = target,
            .optimize = optimize,
        }),
    });

    var files = ArrayList([]const u8).init(b.allocator);
    defer files.deinit();
    _ = try common.list("submodules/nginx/src/http/modules", 0, &common.BUILD_BUFFER, &files);
    try files.append("submodules/nginx/objs/ngx_modules.c");

    for (common.NGX_INCLUDE_PATH) |p| {
        modules.addIncludePath(b.path(p));
    }
    modules.addSystemIncludePath(libxml2);
    modules.linkLibC();
    modules.addCSourceFiles(.{
        .files = files.items[0..],
        .flags = &common.C_FLAGS,
    });

    // b.installArtifact(modules);
    return modules;
}
