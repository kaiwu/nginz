const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_array_t = ngx.ngx_array_t;

const ngx_uint_t = core.ngx_uint_t;
const ngx_pool_t = core.ngx_pool_t;
const NGX_ALIGNMENT = core.NGX_ALIGNMENT;

pub fn ngx_array_next(comptime T: type, a: [*c]ngx_array_t, i: *core.ngx_uint_t) ?[*c]T {
    if (i.* < a.*.nelts) {
        if (core.castPtr(T, a.*.elts)) |p| {
            defer i.* += 1;
            return p + i.*;
        }
    }
    return null;
}

const ngx_array_create = ngx.ngx_array_create;
const ngx_array_destroy = ngx.ngx_array_destroy;
const ngx_array_push = ngx.ngx_array_push;

pub fn NArray(comptime T: type) type {
    if (@alignOf(T) != NGX_ALIGNMENT) {
        @compileError("NArray invalid element");
    }

    const Iterator = struct {
        const Self = @This();

        pa: [*c]ngx_array_t,
        offset: ngx_uint_t = 0,

        pub fn next(self: *Self) ?[*c]T {
            if (self.offset >= self.pa.*.nelts) {
                return null;
            }
            if (core.castPtr(T, self.pa.*.elts)) |p0| {
                defer self.offset += 1;
                return p0 + self.offset;
            }
            return null;
        }
    };

    return extern struct {
        const Self = @This();
        pa: [*c]ngx_array_t = undefined,

        pub fn init(p: [*c]ngx_pool_t, n: ngx_uint_t) !Self {
            if (core.nonNullPtr(ngx_array_t, ngx_array_create(p, n, @sizeOf(T)))) |p0| {
                return Self{ .pa = p0 };
            }
            return core.NError.OOM;
        }

        pub fn inited(self: *Self) bool {
            return self.pa != undefined and self.pa != core.nullptr(ngx_array_t);
        }

        pub fn size(self: *Self) ngx_uint_t {
            return self.pa.*.nelts;
        }

        pub fn iterator(self: *Self) Iterator {
            return Iterator{ .pa = self.pa };
        }

        pub fn at(self: *Self, i: ngx_uint_t) ?[*c]T {
            if (i < self.pa.*.nelts) {
                if (core.castPtr(T, self.pa.*.elts)) |p0| {
                    return p0 + i;
                }
            }
            return null;
        }

        pub fn slice(self: *Self) []T {
            if (core.castPtr(T, self.pa.*.elts)) |p0| {
                return core.slicify(T, p0, self.pa.*.nelts);
            }
            unreachable;
        }

        pub fn deinit(self: *Self) void {
            ngx_array_destroy(self.pa);
        }

        pub fn append(self: *Self) ![*c]T {
            if (core.castPtr(T, ngx_array_push(self.pa))) |p0| {
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
test "array" {
    try expectEqual(@sizeOf(ngx_array_t), 40);
    const log = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    var ns = try NArray(ngx_uint_t).init(pool, 10);
    defer ns.deinit();

    try expectEqual(ns.pa.*.size, @sizeOf(ngx_uint_t));
    try expectEqual(ns.size(), 0);
    try expectEqual(ns.pa.*.nalloc, 10);

    for (0..20) |i| {
        const p = try ns.append();
        p.* = i;
    }
    try expectEqual(ns.at(10).?.*, 10);
    try expectEqual(ns.at(20), null);
    try expectEqual(ns.size(), 20);
}
