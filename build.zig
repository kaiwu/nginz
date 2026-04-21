const std = @import("std");
const builtin = @import("builtin");
const exe = @import("project//build_exe.zig");
const njs = @import("project//build_njs.zig");
const core = @import("project/build_core.zig");
const http = @import("project/build_http.zig");
const cjson = @import("project/build_cjson.zig");
const libinjection = @import("project/build_libinjection.zig");
const patch = @import("project/build_patch.zig");
const quickjs = @import("project//build_quickjs.zig");
const http_modules = @import("project/build_modules.zig");
const package = @import("project/build_package.zig");
const check_layout = @import("project/build_check_layout.zig");

const NGINX = "src/ngx/nginx.zig";
const required_zig_version = std.SemanticVersion{ .major = 0, .minor = 16, .patch = 0 };

var modules = [_][]const u8{
    // Core modules
    "src/modules/hello-nginx-module/ngx_http_hello.zig",
    "src/modules/echoz-nginx-module/ngx_http_echoz.zig",
    "src/modules/wechatpay-nginx-module/ngx_http_wechatpay.zig",

    // Data Storage & Upstream Modules
    "src/modules/pgrest-nginx-module/ngx_http_pgrest.zig",
    "src/modules/redis-nginx-module/ngx_http_redis.zig",
    "src/modules/consul-nginx-module/ngx_http_consul.zig",

    // Security & Auth Modules
    "src/modules/jwt-nginx-module/ngx_http_jwt.zig",
    "src/modules/oidc-nginx-module/ngx_http_oidc.zig",
    "src/modules/waf-nginx-module/ngx_http_waf.zig",
    "src/modules/acme-nginx-module/ngx_http_acme.zig",
    "src/modules/jsonschema-nginx-module/ngx_http_jsonschema.zig",

    // Traffic Management Modules
    "src/modules/healthcheck-nginx-module/ngx_http_healthcheck.zig",
    "src/modules/canary-nginx-module/ngx_http_canary.zig",
    "src/modules/ratelimit-nginx-module/ngx_http_ratelimit.zig",
    "src/modules/requestid-nginx-module/ngx_http_requestid.zig",
    "src/modules/circuit-breaker-nginx-module/ngx_http_circuit_breaker.zig",

    // Advanced Processing Modules
    "src/modules/graphql-nginx-module/ngx_http_graphql.zig",
    "src/modules/transform-nginx-module/ngx_http_transform.zig",
    "src/modules/cache-tags-nginx-module/ngx_http_cache_tags.zig",
    "src/modules/prometheus-nginx-module/ngx_http_prometheus.zig",

    // Security & Network Modules
    "src/modules/nftset-nginx-module/ngx_http_nftset.zig",
};

var tests = [_][]const u8{
    "src/ngx/ngx_pq.zig",
    "src/ngx/ngx_buf.zig",
    "src/ngx/ngx_ssl.zig",
    "src/ngx/ngx_log.zig",
    "src/ngx/ngx_conf.zig",
    "src/ngx/ngx_core.zig",
    "src/ngx/ngx_file.zig",
    "src/ngx/ngx_hash.zig",
    "src/ngx/ngx_http.zig",
    "src/ngx/ngx_list.zig",
    "src/ngx/ngx_cjson.zig",
    "src/ngx/ngx_event.zig",
    "src/ngx/ngx_queue.zig",
    "src/ngx/ngx_array.zig",
    "src/ngx/ngx_module.zig",
    "src/ngx/ngx_rbtree.zig",
    "src/ngx/ngx_string.zig",

    // Add all module test files
    "src/modules/hello-nginx-module/ngx_http_hello.zig",
    "src/modules/echoz-nginx-module/ngx_http_echoz.zig",
    "src/modules/wechatpay-nginx-module/ngx_http_wechatpay.zig",
    "src/modules/pgrest-nginx-module/ngx_http_pgrest.zig",
    "src/modules/redis-nginx-module/ngx_http_redis.zig",
    "src/modules/consul-nginx-module/ngx_http_consul.zig",
    "src/modules/jwt-nginx-module/ngx_http_jwt.zig",
    "src/modules/oidc-nginx-module/ngx_http_oidc.zig",
    "src/modules/waf-nginx-module/ngx_http_waf.zig",
    "src/modules/acme-nginx-module/ngx_http_acme.zig",
    "src/modules/jsonschema-nginx-module/ngx_http_jsonschema.zig",
    "src/modules/healthcheck-nginx-module/ngx_http_healthcheck.zig",
    "src/modules/canary-nginx-module/ngx_http_canary.zig",
    "src/modules/ratelimit-nginx-module/ngx_http_ratelimit.zig",
    "src/modules/requestid-nginx-module/ngx_http_requestid.zig",
    "src/modules/circuit-breaker-nginx-module/ngx_http_circuit_breaker.zig",
    "src/modules/graphql-nginx-module/ngx_http_graphql.zig",
    "src/modules/transform-nginx-module/ngx_http_transform.zig",
    "src/modules/cache-tags-nginx-module/ngx_http_cache_tags.zig",
    "src/modules/prometheus-nginx-module/ngx_http_prometheus.zig",

    // Security & Network Modules
    "src/modules/nftset-nginx-module/ngx_http_nftset.zig",
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
    comptime {
        if (builtin.zig_version.order(required_zig_version) != .eq) {
            @compileError(std.fmt.comptimePrint(
                "nginz requires Zig {f}; found Zig {f}.",
                .{ required_zig_version, builtin.zig_version },
            ));
        }
    }

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const docker = b.option(bool, "docker", "configure with docker primitives") orelse false;

    const nginx = b.addModule("ngx", .{
        .root_source_file = b.path(NGINX),
        .target = target,
        .optimize = optimize,
    });

    const ngx_libinjection = b.createModule(.{
        .root_source_file = b.path("src/ngx/ngx_libinjection.zig"),
        .target = target,
        .optimize = optimize,
    });

    const patch_step = patch.patchStep(b, docker);
    const nginz = exe.build_exe(b, target, optimize) catch unreachable;
    nginz.step.dependOn(patch_step);

    const ngz_modules = b.addObject(.{
        .name = "ngz_modules",
        .root_module = b.createModule(.{
            .pic = true,
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/ngz_modules.zig"),
            .link_libc = true,
        }),
    });
    nginz.root_module.addObject(ngz_modules);

    for (modules) |m| {
        const pn = module_path(m);
        const o = b.addObject(.{
            .name = pn.n,
            .root_module = b.createModule(.{
                .pic = true,
                .root_source_file = b.path(m),
                .target = target,
                .optimize = optimize,
                .link_libc = true,
            }),
        });
        o.root_module.addIncludePath(b.path(pn.p));
        o.root_module.addImport("ngx", nginx);
        o.root_module.addImport("ngx_libinjection", ngx_libinjection);
        o.bundle_compiler_rt = true;
        nginz.root_module.addObject(o);
        const install_object = b.addInstallFile(o.getEmittedBin(), obj(pn.n));
        b.getInstallStep().dependOn(&install_object.step);
    }

    const cjsonlib = cjson.build_cjson(b, target, optimize);
    const libinjectionlib = libinjection.build_libinjection(b, target, optimize);
    const quickjslib = quickjs.build_quickjs(b, target, optimize);
    quickjslib.step.dependOn(patch_step);

    const njs_http_module = njs.build_njs(b, target, optimize, quickjslib) catch unreachable;
    nginz.root_module.addObject(njs_http_module);

    const corelib = core.build_core(b, target, optimize) catch unreachable;
    corelib.step.dependOn(patch_step);

    const httplib = http.build_http(b, target, optimize) catch unreachable;
    httplib.step.dependOn(&corelib.step);
    httplib.root_module.linkLibrary(corelib);

    const moduleslib = http_modules.build_modules(b, target, optimize) catch unreachable;
    moduleslib.step.dependOn(&httplib.step);
    moduleslib.root_module.linkLibrary(corelib);
    moduleslib.root_module.linkLibrary(httplib);

    nginz.root_module.link_libc = true;
    nginz.root_module.linkSystemLibrary("z", .{});
    nginz.root_module.linkSystemLibrary("pq", .{});
    nginz.root_module.linkSystemLibrary("ssl", .{});
    nginz.root_module.linkSystemLibrary("xml2", .{});
    nginz.root_module.linkSystemLibrary("xslt", .{});
    nginz.root_module.linkSystemLibrary("exslt", .{});
    nginz.root_module.linkSystemLibrary("crypt", .{});
    nginz.root_module.linkSystemLibrary("crypto", .{});
    nginz.root_module.linkSystemLibrary("pcre2-8", .{});
    nginz.root_module.linkLibrary(corelib);
    nginz.root_module.linkLibrary(httplib);
    nginz.root_module.linkLibrary(moduleslib);
    nginz.root_module.linkLibrary(cjsonlib);
    nginz.root_module.linkLibrary(libinjectionlib);
    b.installArtifact(nginz);

    const test_step = b.step("test", "Run unit tests");

    const test_moduleslib = http_modules.build_test_modules(b, target, optimize) catch unreachable;
    test_moduleslib.step.dependOn(&httplib.step);
    test_moduleslib.root_module.linkLibrary(corelib);
    test_moduleslib.root_module.linkLibrary(httplib);
    test_step.dependOn(&test_moduleslib.step);

    for (tests) |case| {
        const t = b.addTest(.{
            .root_module = b.createModule(.{
                .root_source_file = b.path(case),
                .target = target,
                .optimize = optimize,
                .link_libc = true,
            }),
        });

        t.root_module.linkSystemLibrary("z", .{});
        t.root_module.linkSystemLibrary("pq", .{});
        t.root_module.linkSystemLibrary("ssl", .{});
        t.root_module.linkSystemLibrary("xml2", .{});
        t.root_module.linkSystemLibrary("xslt", .{});
        t.root_module.linkSystemLibrary("exslt", .{});
        t.root_module.linkSystemLibrary("crypt", .{});
        t.root_module.linkSystemLibrary("crypto", .{});
        t.root_module.linkSystemLibrary("pcre2-8", .{});
        t.root_module.linkLibrary(corelib);
        t.root_module.linkLibrary(httplib);
        t.root_module.linkLibrary(cjsonlib);
        t.root_module.linkLibrary(libinjectionlib);
        t.root_module.linkLibrary(test_moduleslib);
        t.root_module.addIncludePath(b.path("src/ngx/"));
        t.root_module.addImport("ngx", nginx);
        t.root_module.addImport("ngx_libinjection", ngx_libinjection);

        const core_unit_tests = b.addRunArtifact(t);
        test_step.dependOn(&core_unit_tests.step);
    }

    // Package step - creates nginx module packages with config files
    _ = package.createPackageSteps(b, target, optimize, nginx, cjsonlib, libinjectionlib) catch unreachable;

    // Check layout step - compare C struct sizes against Zig bindings
    const check_layout_step = b.step("check-layout", "Check C vs Zig struct layout compatibility");
    check_layout_step.dependOn(check_layout.addCheckLayoutSteps(b, target, optimize, nginx, patch_step));
}
