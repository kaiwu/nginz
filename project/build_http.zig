const std = @import("std");
const common = @import("build_common.zig");

pub fn build_http(
    b: *std.Build,
    target: std.zig.CrossTarget,
    optimize: std.builtin.OptimizeMode,
) *std.Build.Step.Compile {
    const http = b.addStaticLibrary(.{
        .name = "ngx_http",
        .target = target,
        .optimize = optimize,
    });

    var files = std.ArrayList([]u8).init(b.allocator);
    defer files.deinit();
    try common.list("./submodules/nginx/src/http", 0, &common.BUILD_BUFFER, &files);

    for (common.NGX_INCLUDE_PATH) |p| {
        http.addIncludePath(b.path(p));
    }
    http.addCSourceFiles(.{
        .files = &files,
        .flags = &common.C_FLAGS,
    });

    b.installArtifact(http);
    return http;
}
