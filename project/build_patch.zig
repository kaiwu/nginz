const std = @import("std");
const Build = std.Build;
const Step = std.Build.Step;

const Error = error{
    ConfigError,
    CopyError,
    PatchError,
};

fn configOp(step: *Step, _: std.Progress.Node) anyerror!void {
    const b = step.owner;
    const result = try std.process.Child.run(.{
        .allocator = b.allocator,
        .argv = &[_][]const u8{ "./auto/configure", "--with-http_ssl_module", "--with-debug" },
        .cwd = "./submodules/nginx",
    });

    defer {
        b.allocator.free(result.stdout);
        b.allocator.free(result.stderr);
    }

    if (result.term.Exited != 0) {
        std.debug.print("Configure failed with exit code {}:\n", .{result.term.Exited});
        std.debug.print("STDOUT: {s}\n", .{result.stdout});
        std.debug.print("STDERR: {s}\n", .{result.stderr});
        return Error.ConfigError;
    }
}

fn copyOp(step: *Step, _: std.Progress.Node) anyerror!void {
    const b = step.owner;
    const result = try std.process.Child.run(.{
        .allocator = b.allocator,
        .argv = &[_][]const u8{ "cp", "./submodules/nginx/src/core/nginx.c", "./submodules/nginx/objs/nginz.c" },
    });

    defer {
        b.allocator.free(result.stdout);
        b.allocator.free(result.stderr);
    }

    if (result.term.Exited != 0) {
        std.debug.print("Copy failed with exit code {}:\n", .{result.term.Exited});
        std.debug.print("STDOUT: {s}\n", .{result.stdout});
        std.debug.print("STDERR: {s}\n", .{result.stderr});
        return Error.CopyError;
    }
}

fn patchOp(step: *Step, _: std.Progress.Node) anyerror!void {
    const b = step.owner;
    const result = try std.process.Child.run(.{
        .allocator = b.allocator,
        .argv = &[_][]const u8{ "patch", "./submodules/nginx/objs/nginz.c", "project/nginz.patch" },
    });

    defer {
        b.allocator.free(result.stdout);
        b.allocator.free(result.stderr);
    }

    if (result.term.Exited != 0) {
        std.debug.print("Patch failed with exit code {}:\n", .{result.term.Exited});
        std.debug.print("STDOUT: {s}\n", .{result.stdout});
        std.debug.print("STDERR: {s}\n", .{result.stderr});
        return Error.PatchError;
    }

    std.debug.print("Patch applied successfully: {s}\n", .{result.stdout});
}

pub fn patchStep(b: *Build) *Step {
    const config = b.step("config", "configure nginx");
    config.makeFn = configOp;

    const copy = b.step("copy", "copy nginz");
    copy.makeFn = copyOp;
    // copy.dependOn(config);

    const patch = b.step("patch", "patch nginz");
    patch.makeFn = patchOp;
    patch.dependOn(copy);

    return patch;
}
