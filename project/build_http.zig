const std = @import("std");
const common = @import("build_common.zig");

pub fn build_http(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) !*std.Build.Step.Compile {
    const http = b.addStaticLibrary(.{
        .pic = true,
        .name = "ngx_http",
        .target = target,
        .optimize = optimize,
    });

    var files = std.ArrayList([]const u8).init(b.allocator);
    defer files.deinit();
    _ = try common.list("./submodules/nginx/src/http", 0, &common.BUILD_BUFFER, &files);

    for (common.NGX_INCLUDE_PATH) |p| {
        http.addIncludePath(b.path(p));
    }
    http.linkLibC();
    http.addCSourceFiles(.{
        .files = files.items[0..],
        .flags = &common.C_FLAGS,
    });

    // b.installArtifact(http);
    return http;
}
