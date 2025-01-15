const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_list_t = ngx.ngx_list_t;

const ngx_uint_t = core.ngx_uint_t;
const ngx_list_part_t = ngx.ngx_list_part_t;
const ngx_list_create = ngx.ngx_list_create;
const ngx_list_push = ngx.ngx_list_push;

pub fn NList(comptime T: type) type {
    if (@alignOf(T) != core.NGX_ALIGNMENT) {
        @compileError("NList invalid element");
    }

    const Iterator = struct {
        const Self = @This();

        pl: [*c]ngx_list_t,
        last: [*c]ngx_list_part_t,
        offset: core.ngx_uint_t = 0,

        pub fn next(self: *Self) ?[*c]T {
            if (self.offset >= self.last.*.nelts) {
                return null;
            }
            if (core.castPtr(T, self.last.*.elts)) |p0| {
                const pt = p0 + self.offset;
                self.offset += 1;
                if (self.offset >= self.last.*.nelts and self.last != self.pl.*.last) {
                    self.last = self.last.*.next;
                    self.offset = 0;
                }
                return pt;
            }
            return null;
        }

        pub fn nextSlice(self: *Self) ?[]T {
            if (self.last == self.pl.*.last and self.offset == self.last.*.nelts) {
                return null;
            }
            if (core.castPtr(T, self.last.*.elts)) |p0| {
                const s = core.slicify(T, p0, self.last.*.nelts);
                if (self.last != self.pl.*.last) {
                    self.last = self.last.*.next;
                } else {
                    self.offset = self.last.*.nelts;
                }
                return s;
            }
            return null;
        }
    };

    return extern struct {
        const Self = @This();
        pl: [*c]ngx_list_t = undefined,
        len: core.ngx_uint_t = 0,
        ready: ngx.ngx_flag_t = 0,

        pub fn init(p: [*c]core.ngx_pool_t, n: core.ngx_uint_t) !Self {
            if (core.nonNullPtr(ngx_list_t, ngx_list_create(p, n, @sizeOf(T)))) |p0| {
                return Self{ .pl = p0, .ready = 1 };
            }
            return core.NError.OOM;
        }

        pub fn inited(self: *Self) bool {
            return self.ready == 1;
        }

        pub fn size(self: *Self) core.ngx_uint_t {
            return self.len;
        }

        pub fn at(self: *Self, i: core.ngx_uint_t) ?[*c]T {
            if (i < self.len) {
                const n = i / self.pl.*.nalloc;
                const m = i % self.pl.*.nalloc;
                var part: [*c]ngx_list_part_t = &self.pl.*.part;
                for (0..n) |_| {
                    part = part.*.next;
                }
                if (core.castPtr(T, part.*.elts)) |p0| {
                    return p0 + m;
                }
            }
            return null;
        }

        pub fn iterator(self: *Self) Iterator {
            return Iterator{ .pl = self.pl, .last = &self.pl.*.part };
        }

        pub fn append(self: *Self) ![*c]T {
            if (core.castPtr(T, ngx_list_push(self.pl))) |p0| {
                defer self.len += 1;
                return p0;
            } else {
                return core.NError.OOM;
            }
        }
    };
}

const ngx_log_init = ngx.ngx_log_init;
const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;
test "list" {
    try expectEqual(@sizeOf(ngx_list_t), 56);
    const log = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    var ns = try NList(ngx_uint_t).init(pool, 6);

    try expectEqual(ns.pl.*.size, @sizeOf(ngx_uint_t));
    try expectEqual(ns.size(), 0);
    try expectEqual(ns.pl.*.nalloc, 6);

    for (0..20) |i| {
        const p = try ns.append();
        p.* = i;
    }
    try expectEqual(ns.at(10).?.*, 10);
    try expectEqual(ns.at(20), null);
    try expectEqual(ns.size(), 20);
}
