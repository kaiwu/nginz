const std = @import("std");
const exe = @import("project//build_exe.zig");
const core = @import("project/build_core.zig");
const http = @import("project/build_http.zig");
const patch = @import("project/build_patch.zig");
const http_modules = @import("project/build_modules.zig");

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

    const patch_step = patch.patchStep(b);
    const nginz = exe.build_exe(b, target, optimize) catch unreachable;
    nginz.step.dependOn(patch_step);

    const ngz_modules = b.addObject(.{
        .name = "ngz_modules",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/ngz_modules.zig"),
    });
    ngz_modules.pie = true;
    ngz_modules.linkLibC();
    nginz.addObject(ngz_modules);

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
        o.linkLibC();
        nginz.addObject(o);
        const install_object = b.addInstallFile(o.getEmittedBin(), obj(pn.n));
        b.getInstallStep().dependOn(&install_object.step);
    }

    const corelib = core.build_core(b, target, optimize) catch unreachable;
    corelib.step.dependOn(patch_step);

    const httplib = http.build_http(b, target, optimize) catch unreachable;
    httplib.step.dependOn(&corelib.step);
    httplib.linkLibrary(corelib);

    const moduleslib = http_modules.build_modules(b, target, optimize) catch unreachable;
    moduleslib.step.dependOn(&httplib.step);
    moduleslib.linkLibrary(corelib);
    moduleslib.linkLibrary(httplib);

    nginz.linkLibC();
    nginz.linkSystemLibrary("z");
    nginz.linkSystemLibrary("ssl");
    nginz.linkSystemLibrary("crypto");
    nginz.linkSystemLibrary("pcre2-8");
    nginz.linkLibrary(corelib);
    nginz.linkLibrary(httplib);
    nginz.linkLibrary(moduleslib);
    b.installArtifact(nginz);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&moduleslib.step);

    for (tests) |case| {
        const t = b.addTest(.{
            .root_source_file = b.path(case),
            .target = target,
            .optimize = optimize,
        });

        t.linkLibC();
        t.addObject(ngz_modules);
        t.linkSystemLibrary("z");
        t.linkSystemLibrary("ssl");
        t.linkSystemLibrary("crypto");
        t.linkSystemLibrary("pcre2-8");
        t.linkLibrary(corelib);
        t.linkLibrary(httplib);
        t.linkLibrary(moduleslib);
        t.addIncludePath(b.path("src/ngx/"));
        t.root_module.addImport("nginx", nginx);

        const core_unit_tests = b.addRunArtifact(t);
        test_step.dependOn(&core_unit_tests.step);
    }
}
