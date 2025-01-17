const std = @import("std");

const NGINX = "src/ngx/nginx.zig";

var modules = [_][]const u8{
    "src/modules/echoz-nginx-module/ngx_http_echoz.zig",
};

var tests = [_][]const u8{
    "src/ngx/ngx_buf.zig",
    "src/ngx/ngx_log.zig",
    "src/ngx/ngx_conf.zig",
    "src/ngx/ngx_core.zig",
    "src/ngx/ngx_hash.zig",
    "src/ngx/ngx_http.zig",
    "src/ngx/ngx_list.zig",
    "src/ngx/ngx_event.zig",
    "src/ngx/ngx_queue.zig",
    "src/ngx/ngx_array.zig",
    "src/ngx/ngx_module.zig",
    "src/ngx/ngx_rbtree.zig",
    "src/ngx/ngx_string.zig",

    "src/modules/echoz-nginx-module/ngx_http_echoz.zig",
};

const PN = struct {
    p: []const u8,
    n: []const u8,
};

fn obj(f: []const u8) []const u8 {
    const file = struct {
        var buf: [256]u8 = undefined;
    };
    @memcpy(file.buf[0..f.len], f);
    @memcpy(file.buf[f.len .. f.len + 9], "_module.o");
    return file.buf[0 .. f.len + 9];
}

fn module_path(f: []const u8) PN {
    var l: usize = 0;
    var d: usize = 0;
    for (f, 0..) |c, i| {
        if (c == '/') {
            l = i;
        }
        if (c == '.') {
            d = i;
        }
    }
    return PN{ .p = f[0..l], .n = f[l + 1 .. d] };
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const nginx = b.addModule("nginx", .{
        .root_source_file = b.path(NGINX),
        .target = target,
        .optimize = optimize,
    });

    for (modules) |m| {
        const pn = module_path(m);
        const o = b.addObject(.{
            .name = pn.n,
            .root_source_file = b.path(m),
            .target = target,
            .optimize = optimize,
        });
        o.addIncludePath(b.path(pn.p));
        o.root_module.addImport("nginx", nginx);
        o.pie = true;
        o.bundle_compiler_rt = true;
        const install_object = b.addInstallFile(o.getEmittedBin(), obj(pn.n));
        b.getInstallStep().dependOn(&install_object.step);
    }

    const test_step = b.step("test", "Run unit tests");
    for (tests) |case| {
        const t = b.addTest(.{
            .root_source_file = b.path(case),
            .target = target,
            .optimize = optimize,
        });

        t.linkLibC();
        t.linkSystemLibrary("z");
        t.linkSystemLibrary("ssl");
        t.linkSystemLibrary("crypto");
        t.linkSystemLibrary("pcre2-8");
        t.addObjectFile(b.path("libs/libngx_core.a"));
        t.addObjectFile(b.path("libs/libngx_http.a"));
        t.addIncludePath(b.path("src/ngx/"));
        t.root_module.addImport("nginx", nginx);

        const core_unit_tests = b.addRunArtifact(t);
        test_step.dependOn(&core_unit_tests.step);
    }
}
