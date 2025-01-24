const std = @import("std");
const Build = std.Build;
const Step = std.Build.Step;

const Error = error{
    PatchError,
};

fn patchOp(step: *Step, _: std.Progress.Node) anyerror!void {
    const b = step.owner;
    const result = try std.process.Child.run(.{
        .allocator = b.allocator,
        .argv = &[_][]const u8{ "make", "-f", "project/nginz.makefile" },
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

    // std.debug.print("Patch applied successfully: {s}\n", .{result.stdout});
}

pub fn patchStep(b: *Build) *Step {
    const patch = b.step("patch", "patch nginz");
    patch.makeFn = patchOp;

    return patch;
}
