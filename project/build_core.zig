const std = @import("std");
const common = @import("build_common.zig");

const lib_files = .{
    "./submodules/nginx/objs/ngx_modules.c",
    "./submodules/nginx/objs/nginz.c",
};

const os_files = .{
    "./submodule/nginx/src/os/unix/ngx_time.c",
    "./submodule/nginx/src/os/unix/ngx_recv.c",
    "./submodule/nginx/src/os/unix/ngx_send.c",
    "./submodule/nginx/src/os/unix/ngx_user.c",
    "./submodule/nginx/src/os/unix/ngx_errno.c",
    "./submodule/nginx/src/os/unix/ngx_alloc.c",
    "./submodule/nginx/src/os/unix/ngx_files.c",
    "./submodule/nginx/src/os/unix/ngx_shmem.c",
    "./submodule/nginx/src/os/unix/ngx_socket.c",
    "./submodule/nginx/src/os/unix/ngx_daemon.c",
    "./submodule/nginx/src/os/unix/ngx_dlopen.c",
    "./submodule/nginx/src/os/unix/ngx_channel.c",
    "./submodule/nginx/src/os/unix/ngx_process.c",
    "./submodule/nginx/src/os/unix/ngx_udp_recv.c",
    "./submodule/nginx/src/os/unix/ngx_udp_send.c",
    "./submodule/nginx/src/os/unix/ngx_posix_init.c",
    "./submodule/nginx/src/os/unix/ngx_linux_init.c",
    "./submodule/nginx/src/os/unix/ngx_readv_chain.c",
    "./submodule/nginx/src/os/unix/ngx_setaffinity.c",
    "./submodule/nginx/src/os/unix/ngx_writev_chain.c",
    "./submodule/nginx/src/os/unix/ngx_setproctitle.c",
    "./submodule/nginx/src/os/unix/ngx_process_cycle.c",
    "./submodule/nginx/src/os/unix/ngx_udp_sendmsg_chain.c",
    "./submodule/nginx/src/os/unix/ngx_linux_sendfile_chain.c",
};

const event_files = .{
    "./submodules/nginx/src/event/ngx_event.c",
    "./submodules/nginx/src/event/ngx_event_udp.c",
    "./submodules/nginx/src/event/ngx_event_pipe.c",
    "./submodules/nginx/src/event/ngx_event_timer.c",
    "./submodules/nginx/src/event/ngx_event_posted.c",
    "./submodules/nginx/src/event/ngx_event_accept.c",
    "./submodules/nginx/src/event/ngx_event_connect.c",
    "./submodules/nginx/src/event/ngx_event_openssl.c",
    "./submodules/nginx/src/event/ngx_event_openssl_cache.c",
    "./submodules/nginx/src/event/modules/ngx_epoll_module.c",
    "./submodules/nginx/src/event/ngx_event_openssl_stapling.c",
};

fn append(files: *std.ArrayList([]u8), src: []const []const u8) !void {
    for (src) |f| {
        try files.append(f);
    }
}

pub fn build_core(
    b: *std.Build,
    target: std.zig.CrossTarget,
    optimize: std.builtin.OptimizeMode,
) !*std.Build.Step.Compile {
    const core = b.addStaticLibrary(.{
        .name = "ngx_core",
        .target = target,
        .optimize = optimize,
    });

    var files = std.ArrayList([]u8).init(b.allocator);
    defer files.deinit();
    try common.list("./submodules/nginx/src/core", 0, &common.BUILD_BUFFER, &files);

    try append(&files, &lib_files);
    try append(&files, &os_files);
    try append(&files, &event_files);

    for (common.NGX_INCLUDE_PATH) |p| {
        core.addIncludePath(b.path(p));
    }
    core.addCSourceFiles(.{
        .files = &files,
        .flags = &common.C_FLAGS,
    });

    b.installArtifact(core);
    return core;
}
