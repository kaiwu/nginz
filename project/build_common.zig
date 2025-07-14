const std = @import("std");
const fs = std.fs;
const OOM = std.mem.Allocator.Error.OutOfMemory;

pub var BUILD_BUFFER: [4096 * 10]u8 = undefined;
pub const C_FLAGS = [_][]const u8{
    "-std=gnu11",
    "-Wall",
    "-Wextra",
    "-Wno-unused-function",
    "-Wno-unused-parameter",
    "-fno-sanitize=all",
    "-DNJS_HAVE_QUICKJS",
};
pub const NGX_INCLUDE_PATH = [_][]const u8{
    "submodules/nginx/objs",
    "submodules/nginx/src/core",
    "submodules/nginx/src/http",
    "submodules/nginx/src/event",
    "submodules/nginx/src/os/unix",
    "submodules/nginx/src/http/v2",
    "submodules/nginx/src/http/v3",
    "submodules/nginx/src/event/quic",
    "submodules/nginx/src/http/modules",
    "submodules/nginx/src/event/modules",
};

const EXCLUDES = [_][]const u8{
    "bpf",
    "perl",
    "test",
    "nginx.c",
    "modules",
    "njs_shell.c",
    "njs_regex.c",
    "njs_lvlhsh.c",
    "njs_addr2line.c",
    "njs_lexer_keyword.c",
    "ngx_http_geoip_module.c",
    "ngx_http_stub_status_module.c",
    "ngx_http_degradation_module.c",
};

pub fn append(files: *std.ArrayList([]const u8), src: []const []const u8) !void {
    for (src) |f| {
        try files.append(f);
    }
}

pub fn list(d: []const u8, ii: usize, mem: []u8, files: *std.ArrayList([]const u8)) !usize {
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
            if (entry.kind == .file and entry.name[entry.name.len - 1] != 'c') {
                continue;
            }
            for (EXCLUDES) |ex| {
                if (std.mem.eql(u8, entry.name, ex)) {
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
