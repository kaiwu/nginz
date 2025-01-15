const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_buf_t = ngx.ngx_buf_t;
pub const ngx_chain_t = ngx.ngx_chain_t;

const off_t = core.off_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_pool_t = core.ngx_pool_t;

pub inline fn ngx_buf_in_memory(b: [*c]ngx_buf_t) bool {
    return b.*.flags.temporary or b.*.flags.memory or b.*.flags.mmap;
}

pub inline fn ngx_buf_in_memory_only(b: [*c]ngx_buf_t) bool {
    return ngx_buf_in_memory(b) and !b.*.flags.in_file;
}

pub inline fn ngx_buf_special(b: [*c]ngx_buf_t) bool {
    return (b.*.flags.flush or b.*.flags.last_buf or b.*.flags.sync) and !ngx_buf_in_memory(b) and !b.*.flags.in_file;
}

pub inline fn ngx_buf_sync_only(b: [*c]ngx_buf_t) bool {
    return b.*.flags.sync and !ngx_buf_in_memory(b) and !b.*.flags.in_file and !b.*.flags.flush and !b.*.flags.last_buf;
}

pub inline fn ngx_buf_size(b: [*c]ngx_buf_t) off_t {
    return if (ngx_buf_in_memory(b)) @as(off_t, @intCast(b.*.last - b.*.pos)) else b.*.file_last - b.*.file_pos;
}

pub inline fn ngx_alloc_buf(pool: [*c]ngx_pool_t) ?[*c]ngx_buf_t {
    return core.ngz_pcalloc_c(ngx_buf_t, pool);
}

pub inline fn ngx_free_chain(pool: [*c]ngx_pool_t, cl: [*c]ngx_chain_t) void {
    cl.*.next = pool.*.chain;
    pool.*.chain = cl;
}

const ngx_create_temp_buf = ngx.ngx_create_temp_buf;

pub inline fn ngz_chain_length(cl: [*c]ngx_chain_t) ngx_uint_t {
    var total: ngx_uint_t = 0;
    var n: [*c]ngx_chain_t = cl;
    while (n != core.nullptr(ngx_chain_t)) {
        total += n.*.buf.*.last - n.*.buf.*.pos;
        n = n.*.next;
    }
    return total;
}

pub const NChain = extern struct {
    const Self = @This();
    pool: [*c]ngx_pool_t,

    pub fn init(p: [*c]ngx_pool_t) Self {
        return Self{ .pool = p };
    }

    pub fn alloc(
        self: *Self,
        size: ngx_uint_t,
        prev: ?[*c]ngx_chain_t,
    ) ![*c]ngx_chain_t {
        const nc = core.nullptr(ngx_chain_t);
        var cl: [*c]ngx_chain_t = self.pool.*.chain;
        var last: [*c]ngx_chain_t = cl;
        while (cl != nc) {
            if (cl.*.buf.*.end - cl.*.buf.*.start >= size) {
                last.*.next = cl.*.next;
                break;
            }
            last = cl;
            cl = cl.*.next;
        }
        if (cl != nc) {
            cl.*.buf.*.last = cl.*.buf.*.pos;
            cl.*.next = nc;
            if (prev) |pcl| {
                pcl.*.next = cl;
            }
            return cl;
        }

        if (core.ngz_pcalloc_c(ngx_chain_t, self.pool)) |cl0| {
            const b = ngx_create_temp_buf(self.pool, size);
            if (b != core.nullptr(ngx_buf_t)) {
                cl0.*.buf = b;
                cl0.*.next = nc;
                if (prev) |pcl| {
                    pcl.*.next = cl0;
                }
                return cl0;
            }
        }
        return core.NError.OOM;
    }

    // [last->next .. last]
    pub fn allocN(
        self: *Self,
        size: ngx_uint_t,
        n: ngx_uint_t,
        last: [*c]ngx_chain_t,
    ) ![*c]ngx_chain_t {
        if (n > 0) {
            const cl: [*c]ngx_chain_t = try alloc(self, size, last);
            return allocN(self, size, n - 1, cl);
        }
        return last;
    }

    pub fn free(self: *Self, cl: [*c]ngx_chain_t) void {
        cl.*.buf.*.last = cl.*.buf.*.pos;
        ngx_free_chain(self.pool, cl);
    }

    pub fn freeN(self: *Self, cl: [*c]ngx_chain_t) void {
        var last: [*c]ngx_chain_t = cl;
        while (last.*.next != core.nullptr(ngx_chain_t)) {
            last.*.buf.*.last = last.*.buf.*.pos;
            last = last.*.next;
        }
        last.*.next = self.pool.*.chain;
        self.pool.*.chain = cl;
    }
};

pub const NRingBuffer = extern struct {
    const Self = @This();

    buf: [*c]ngx_buf_t,
    size: ngx_uint_t,
    head: ngx_uint_t,
    tail: ngx_uint_t,
};

test "buf" {
    try expectEqual(@sizeOf(ngx_buf_t), 80);
}
