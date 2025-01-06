const std = @import("std");

const ngx_module = struct {
    source: []const u8,
    module: ?*std.Build.Module = null,
};

var ngx = [_]ngx_module{
    .{ .source = "src/ngx/nginx.zig" },
};

fn module_name(path: []const u8) []const u8 {
    var b: usize = 0;
    var e: usize = 0;
    for (path, 0..) |c, i| {
        if (c == '/') {
            b = i;
        }
        if (c == '.') {
            e = i;
        }
    }
    return path[b + 1 .. e];
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const test_step = b.step("test", "Run unit tests");

    const nginx = b.addModule("nginx", .{ .root_source_file = b.path("src/ngx/nginx.zig"), .target = target, .optimize = optimize });

    for (ngx) |m| {
        const t = b.addTest(.{
            .root_source_file = b.path(m.source),
            .target = target,
            .optimize = optimize,
        });

        t.linkLibC();
        t.linkSystemLibrary("z");
        t.linkSystemLibrary("m");
        t.linkSystemLibrary("ssl");
        t.linkSystemLibrary("dl");
        t.linkSystemLibrary("crypt");
        t.linkSystemLibrary("pcre2-8");
        t.addObjectFile(b.path("libs/libngx_core.a"));
        t.addObjectFile(b.path("libs/libngx_http.a"));
        t.addIncludePath(b.path("src/ngx/"));
        t.root_module.addImport("nginx", nginx);

        const core_unit_tests = b.addRunArtifact(t);
        test_step.dependOn(&core_unit_tests.step);
    }
}
