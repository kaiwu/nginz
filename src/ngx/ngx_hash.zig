const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const string = @import("ngx_string.zig");
const expectEqual = std.testing.expectEqual;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_pool_t = core.ngx_pool_t;

pub const ngx_hash_t = ngx.ngx_hash_t;
pub const ngx_table_elt_t = ngx.ngx_table_elt_t;
pub const NGX_HASH_SMALL = ngx.NGX_HASH_SMALL;
pub const NGX_HASH_LARGE = ngx.NGX_HASH_LARGE;
pub const NGX_HASH_READONLY_KEY = ngx.NGX_HASH_READONLY_KEY;
pub const NGX_HASH_WILDCARD_KEY = ngx.NGX_HASH_WILDCARD_KEY;

pub inline fn ngx_hash(key: ngx_uint_t, c: u8) ngx_uint_t {
    return key * 31 + @as(ngx_uint_t, @intCast(c));
}

const NGX_CACHELINE_SIZE = core.NGX_CACHELINE_SIZE;
const ngx_hash_key_t = ngx.ngx_hash_key_t;
const ngx_hash_init_t = ngx.ngx_hash_init_t;
const ngx_hash_key_pt = ngx.ngx_hash_key_pt;
const ngx_hash_keys_array_t = ngx.ngx_hash_keys_arrays_t;

pub const ngx_hash_type = enum(ngx_uint_t) {
    hash_small = NGX_HASH_SMALL,
    hash_large = NGX_HASH_LARGE,
};

pub const ngx_hash_key = ngx.ngx_hash_key;
pub const ngx_hash_init = ngx.ngx_hash_init;
pub const ngx_hash_find = ngx.ngx_hash_find;
pub const ngx_hash_add_key = ngx.ngx_hash_add_key;
pub const ngx_hash_keys_array_init = ngx.ngx_hash_keys_array_init;

pub fn NHash(comptime K: type, comptime V: type, comptime M: ngx_uint_t) type {
    const MAX_SIZE = M;
    const BUCKET_SIZE = core.ngx_align(64, NGX_CACHELINE_SIZE);

    const Ctx = extern struct {
        name: [*c]u8,
        type: ngx_hash_type,
        key: *const fn ([*c]u8, usize) callconv(.C) ngx_uint_t,
        data: *const fn (k: [*c]K) callconv(.C) [*c]u8,
        len: *const fn (k: [*c]K) callconv(.C) usize,
        pool: [*c]ngx_pool_t,
        temp_pool: [*c]ngx_pool_t,
    };

    const KV = extern struct {
        key_ptr: [*c]K,
        value_ptr: [*c]V,
    };

    return extern struct {
        const Self = @This();
        pub const HashCtx = Ctx;
        pub const HashKV = KV;

        ctx: [*c]Ctx,
        hash: ngx_hash_t = undefined,
        ready: ngx.ngx_flag_t = 0,

        // [*c]Ctx and []KV must retain
        pub fn init(ctx: [*c]Ctx, kv: []KV) !Self {
            var h = Self{ .ctx = ctx, .ready = 0 };

            var keys: ngx_hash_keys_array_t = undefined;
            keys.temp_pool = ctx.*.temp_pool;
            keys.pool = ctx.*.pool;

            if (ngx_hash_keys_array_init(&keys, @intCast(@intFromEnum(ctx.*.type))) != core.NGX_OK) {
                return core.NError.HASH_ERROR;
            }

            for (kv) |*kv0| {
                const str = ngx_str_t{ .len = ctx.*.len(kv0.key_ptr), .data = ctx.*.data(kv0.key_ptr) };
                if (ngx_hash_add_key(&keys, @constCast(&str), @alignCast(@ptrCast(kv0)), NGX_HASH_READONLY_KEY) != core.NGX_OK) {
                    return core.NError.HASH_ERROR;
                }
            }

            var hash_init = ngx_hash_init_t{
                .name = ctx.*.name,
                .max_size = MAX_SIZE,
                .bucket_size = BUCKET_SIZE,
                .pool = ctx.*.pool,
                .temp_pool = ctx.*.temp_pool,
                .key = ctx.*.key,
                .hash = &h.hash,
            };
            if (core.castPtr(ngx_hash_key_t, keys.keys.elts)) |ks| {
                if (ngx_hash_init(&hash_init, ks, keys.keys.nelts) == core.NGX_OK) {
                    h.ready = 1;
                    return h;
                }
            }

            return core.NError.HASH_ERROR;
        }

        pub fn inited(self: *Self) bool {
            return self.ready == 1;
        }

        pub fn getPtr(self: *Self, k: [*c]K) ?[*c]KV {
            const name = self.ctx.*.data(k);
            const len = self.ctx.*.len(k);
            const k0 = self.ctx.*.key(name, len);
            if (core.castPtr(KV, ngx_hash_find(&self.hash, k0, name, len))) |kv| {
                return kv;
            }
            return null;
        }
    };
}

pub fn ngx_str_data(k: [*c]ngx_str_t) callconv(.C) [*c]u8 {
    return k.*.data;
}

pub fn ngx_str_len(k: [*c]ngx_str_t) callconv(.C) usize {
    return k.*.len;
}

extern var ngx_cacheline_size: ngx_uint_t;

const ngx_log_init = ngx.ngx_log_init;
const ngx_time_init = ngx.ngx_time_init;
const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;
test "hash" {
    try expectEqual(@sizeOf(ngx_hash_t), 16);
    const log = ngx_log_init(core.c_str(""), core.c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    const temp_pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(temp_pool);

    ngx_cacheline_size = NGX_CACHELINE_SIZE;
    const Hash = NHash(ngx_str_t, ngx_int_t, 100);
    const KV = Hash.HashKV;
    const Ctx = Hash.HashCtx;

    const ctx = Ctx{
        .name = @constCast("test"),
        .type = .hash_small,
        .pool = pool,
        .temp_pool = temp_pool,
        .data = ngx_str_data,
        .len = ngx_str_len,
        .key = ngx_hash_key,
    };

    var ks = [_]ngx_str_t{
        string.ngx_string("a"),
        string.ngx_string("b"),
        string.ngx_string("c"),
    };
    var vs = [_]ngx_int_t{ 1, 2, 3 };

    var kv = [_]KV{
        KV{ .key_ptr = &ks[0], .value_ptr = &vs[0] },
        KV{ .key_ptr = &ks[1], .value_ptr = &vs[1] },
        KV{ .key_ptr = &ks[2], .value_ptr = &vs[2] },
    };

    var h = try Hash.init(@constCast(&ctx), &kv);
    if (h.getPtr(kv[2].key_ptr)) |d| {
        try expectEqual(d.*.key_ptr, kv[2].key_ptr);
        try expectEqual(d.*.value_ptr.*, 3);
    }
}

pub fn ZHash(comptime K: type, comptime V: type, comptime Ctx: type, comptime M: ngx_uint_t) type {
    const PAGE_SIZE = 1024;
    const HashMapType = std.HashMap(K, V, Ctx, M);
    const IteratorType = HashMapType.Iterator;

    return extern struct {
        const Self = @This();
        pub const HashMap = HashMapType;
        pub const Iterator = IteratorType;

        hash: ?*anyopaque,
        fba: ?*anyopaque,
        ready: ngx.ngx_flag_t = 0,

        pub fn init(p: [*c]ngx_pool_t) !Self {
            if (core.ngz_pcalloc(HashMap, p)) |hash| {
                if (core.ngz_pcalloc(std.heap.FixedBufferAllocator, p)) |fba| {
                    if (core.castPtr(u8, core.ngx_pmemalign(p, PAGE_SIZE, core.NGX_ALIGNMENT))) |buf| {
                        fba.* = std.heap.FixedBufferAllocator.init(core.slicify(u8, buf, PAGE_SIZE));
                        const allocator = fba.allocator();
                        hash.* = HashMap.init(allocator);
                        return Self{
                            .hash = @alignCast(@ptrCast(hash)),
                            .fba = @alignCast(@ptrCast(fba)),
                            .ready = 1,
                        };
                    }
                }
            }
            return core.NError.OOM;
        }

        pub fn inited(self: *Self) bool {
            return self.ready == 1;
        }

        pub fn put(self: *Self, k: K, v: V) !void {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            try h.put(k, v);
        }

        pub fn iterator(self: *Self) Iterator {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            return h.iterator();
        }

        pub fn getPtr(self: *Self, k: K) ?*V {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            return h.getPtr(k);
        }

        pub fn size(self: *Self) ngx_uint_t {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            return h.count();
        }

        pub fn deinit(self: *Self) void {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            h.deinit();
        }
    };
}

pub const ngx_str_hash_ctx = struct {
    pub fn hash(_: @This(), s: ngx_str_t) u64 {
        return ngx_hash_key(s.data, s.len);
    }
    pub fn eql(_: @This(), s0: ngx_str_t, s1: ngx_str_t) bool {
        if (s0.len != s1.len) {
            return false;
        }
        return std.mem.eql(u8, core.slicify(u8, s0.data, s0.len), core.slicify(u8, s1.data, s1.len));
    }
};

test "zhash" {
    const log = ngx_log_init(core.c_str(""), core.c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(4096, log);
    defer ngx_destroy_pool(pool);

    ngx_cacheline_size = NGX_CACHELINE_SIZE;
    const Hash = ZHash(ngx_str_t, ngx_int_t, ngx_str_hash_ctx, 80);

    var m = try Hash.init(pool);
    defer m.deinit();

    try m.put(string.ngx_string("abc"), 1);
    try m.put(string.ngx_string("xyz"), 2);
    try expectEqual(m.size(), 2);
    try expectEqual(m.getPtr(string.ngx_string("abc")).?.*, 1);
}
