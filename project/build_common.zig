const std = @import("std");
const fs = std.fs;
const OOM = std.mem.Allocator.Error.OutOfMemory;

pub var BUILD_BUFFER: [4096 * 10]u8 = undefined;
pub const C_FLAGS = .{ "-pipe", "-O", "-Wall", "-Wpointer-arith", "-Wno-unused-parameter", "-Werror", "-g" };
pub const NGX_INCLUDE_PATH = .{
    "./submodules/nginx/objs",
    "./submodules/nginx/src/core",
    "./submodules/nginx/src/event",
    "./submodules/nginx/src/event/modules",
    "./submodules/nginx/src/os/unix",
    "./submodules/nginx/src/http",
    "./submodules/nginx/src/http/modules",
};

const EXCLUDES = .{
    "nginx.c",
    "perl",
    "v2",
    "v3",
};

pub fn list(d: []const u8, ii: usize, mem: []u8, files: *std.ArrayList([]u8)) !usize {
    var dir = fs.cwd().openDir(d, .{ .iterate = true }) catch {
        return ii;
    };
    defer dir.close();

    var it = dir.iterate();
    var i = ii;
    out: while (true) {
        const e = try it.next();
        if (e) |entry| {
            if (entry.kind != .file and entry.kind != .directory) {
                continue;
            }
            for (EXCLUDES) |ex| {
                if (std.mem.eql(entry.name, ex)) {
                    continue :out;
                }
            }

            const len = d.len + entry.name.len + 1;
            if (i + len > mem.len) {
                return OOM;
            } else {
                @memcpy(mem[i .. i + d.len], d);
                mem[i + d.len] = '/';
                @memcpy(mem[i + d.len + 1 .. i + d.len + 1 + entry.name.len], entry.name);
            }

            if (entry.kind == .file) {
                try files.append(mem[i .. i + len]);
                i += len;
            }
            if (entry.kind == .directory) {
                i = try list(mem[i .. i + len], i + len, mem, files);
            }
        } else {
            break;
        }
    }
    return i;
}
