const std = @import("std");
const fs = std.fs;
const OOM = std.mem.Allocator.Error.OutOfMemory;

pub fn list(d: []const u8, ii: usize, m: usize, mem: []u8, files: *std.ArrayList([]u8)) !usize {
    var dir = fs.cwd().openDir(d, .{ .iterate = true }) catch {
        return ii;
    };
    defer dir.close();

    var it = dir.iterate();
    var i = ii;
    while (true) {
        const e = try it.next();
        if (e) |entry| {
            if (entry.kind != .file and entry.kind != .directory) {
                continue;
            }

            const len = d.len + entry.name.len + 1;
            if (i + len > m) {
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
                i = try list(mem[i .. i + len], i + len, m, mem, files);
            }
        } else {
            break;
        }
    }
    return i;
}
