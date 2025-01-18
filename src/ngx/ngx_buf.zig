const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const array = @import("ngx_array.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_buf_t = ngx.ngx_buf_t;
pub const ngx_chain_t = ngx.ngx_chain_t;

const off_t = core.off_t;
const u_char = core.u_char;
const ngx_str_t = core.ngx_str_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_pool_t = core.ngx_pool_t;
const NArray = array.NArray;

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

const ngx_alloc_chain_link = ngx.ngx_alloc_chain_link;
const ngx_create_temp_buf = ngx.ngx_create_temp_buf;

pub inline fn ngz_chain_length(cl: [*c]ngx_chain_t) ngx_uint_t {
    var total: ngx_uint_t = 0;
    var n: [*c]ngx_chain_t = cl;
    while (n != NChain.NP) {
        total += @intFromPtr(n.*.buf.*.last) - @intFromPtr(n.*.buf.*.pos);
        n = n.*.next;
    }
    return total;
}

pub const NChain = extern struct {
    const Self = @This();
    const NP = core.nullptr(ngx_chain_t);

    pool: [*c]ngx_pool_t,

    pub fn init(p: [*c]ngx_pool_t) Self {
        return Self{ .pool = p };
    }

    pub fn create(self: *Self) ![*c]ngx_chain_t {
        const cl = ngx_alloc_chain_link(self.pool);
        if (cl != NP) {
            return cl;
        }
        return core.NError.OOM;
    }

    pub fn allocBuf(self: *Self, last: [*c]ngx_chain_t) ![*c]ngx_chain_t {
        if (core.nonNullPtr(ngx_chain_t, ngx_alloc_chain_link(self.pool))) |cl| {
            if (core.ngz_pcalloc_c(ngx_buf_t, self.pool)) |b| {
                b.*.flags.memory = true;
                cl.*.buf = b;
                cl.*.next = NP;
                last.*.next = cl;
                return cl;
            }
        }
        return core.NError.OOM;
    }

    pub fn allocStr(
        self: *Self,
        str: ngx_str_t,
        last: [*c]ngx_chain_t,
    ) ![*c]ngx_chain_t {
        if (core.ngz_pcalloc_c(ngx_chain_t, self.pool)) |cl| {
            if (core.ngz_pcalloc_c(ngx_buf_t, self.pool)) |b| {
                b.*.start = str.data;
                b.*.pos = str.data;
                b.*.end = str.data + str.len;
                b.*.last = str.data + str.len;
                b.*.flags.memory = true;

                cl.*.buf = b;
                cl.*.next = NP;
                last.*.next = cl;
                return cl;
            }
        }
        return core.NError.OOM;
    }

    // [last->next, last]
    pub fn allocNStr(
        self: *Self,
        as: NArray(ngx_str_t),
        last: [*c]ngx_chain_t,
    ) ![*c]ngx_chain_t {
        var cl: [*c]ngx_chain_t = last;
        var it = as.iterator();
        while (it.next()) |s| {
            cl = try self.allocStr(s.*, cl);
        }
        return cl;
    }

    pub fn alloc(
        self: *Self,
        size: ngx_uint_t,
        last: [*c]ngx_chain_t,
    ) ![*c]ngx_chain_t {
        var cl: [*c]ngx_chain_t = self.pool.*.chain;
        var ll: [*c]ngx_chain_t = cl;
        while (cl != NP) {
            if (@intFromPtr(cl.*.buf.*.end) - @intFromPtr(cl.*.buf.*.start) >= size) {
                ll.*.next = cl.*.next;
                break;
            }
            ll = cl;
            cl = cl.*.next;
        }
        if (cl != NP) {
            cl.*.buf.*.last = cl.*.buf.*.pos;
            cl.*.next = NP;
            last.*.next = cl;
            return cl;
        }

        if (core.ngz_pcalloc_c(ngx_chain_t, self.pool)) |cl0| {
            const b = ngx_create_temp_buf(self.pool, size);
            if (b != core.nullptr(ngx_buf_t)) {
                cl0.*.buf = b;
                cl0.*.next = NP;
                last.*.next = cl0;
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
        while (last.*.next != NP) {
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
    //buf->pos is read pointer
    //buf->last is write pointer

    pub fn init(b: [*c]ngx_buf_t) Self {
        return Self{ .buf = b };
    }

    pub fn empty(self: *Self) bool {
        return self.buf.*.last == self.buf.*.pos;
    }

    pub fn size(self: *Self) ngx_uint_t {
        if (self.buf.*.last >= self.buf.*.pos) {
            return @intFromPtr(self.buf.*.last) - @intFromPtr(self.buf.*.pos);
        }
        const s0 = @intFromPtr(self.buf.*.end) - @intFromPtr(self.buf.*.pos);
        const s1 = @intFromPtr(self.buf.*.last) - @intFromPtr(self.buf.*.start);
        return s0 + s1;
    }

    pub fn full(self: *Self) bool {
        const s = @intFromPtr(self.buf.*.end) - @intFromPtr(self.buf.*.start);
        return size(self) == s;
    }

    pub fn space(self: *Self) ngx_uint_t {
        const s = @intFromPtr(self.buf.*.end) - @intFromPtr(self.buf.*.start);
        const s0 = size(self);
        return if (s > s0) s - s0 else 0;
    }

    pub fn write(self: *Self, p: [*c]u_char, len: ngx_uint_t) !void {
        if (len > space(self)) {
            return core.NError.OOM;
        }
        if (self.buf.*.last + len <= self.buf.*.end) {
            core.ngz_memcpy(self.buf.*.last, p, len);
            self.buf.*.last += len;
        } else {
            const part = @intFromPtr(self.buf.*.end) - @intFromPtr(self.buf.*.last);
            core.ngz_memcpy(self.buf.*.last, p, part);
            core.ngz_memcpy(self.buf.*.start, p + part, len - part);
            self.buf.*.last = self.buf.*.start + (len - part);
        }
    }

    pub fn read(self: *Self, p: [*c]u_char, len: ngx_uint_t) !void {
        if (len > size(self)) {
            return core.NError.OOM;
        }
        if (self.buf.*.pos + len <= self.buf.*.end) {
            core.ngz_memcpy(p, self.buf.*.pos, len);
            self.buf.*.pos += len;
        } else {
            const part = @intFromPtr(self.buf.*.end) - @intFromPtr(self.buf.*.pos);
            core.ngz_memcpy(p, self.buf.*.pos, part);
            core.ngz_memcpy(p + part, self.buf.*.start, len - part);
            self.buf.*.pos = self.buf.*.start + len - part;
        }
    }
};

test "buf" {
    try expectEqual(@sizeOf(ngx_buf_t), 80);
}
