const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_buf_t = ngx.ngx_buf_t;
pub const ngx_chain_t = ngx.ngx_chain_t;

const off_t = core.off_t;
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

pub inline fn ngx_alloc_buf(pool: [*c]ngx_pool_t) [*c]ngx_buf_t {
    if (core.ngx_palloc(pool, @sizeOf(ngx_buf_t))) |p| {
        return @as([*c]ngx_buf_t, @ptrCast(p));
    } else {
        return core.NULL;
    }
}

pub inline fn ngx_calloc_buf(pool: [*c]ngx_pool_t) [*c]ngx_buf_t {
    if (core.ngx_pcalloc(pool, @sizeOf(ngx_buf_t))) |p| {
        return @as([*c]ngx_buf_t, @ptrCast(p));
    } else {
        return core.NULL;
    }
}

pub inline fn ngx_free_chain(pool: [*c]ngx_pool_t, cl: [*c]ngx_chain_t) void {
    cl.*.next = pool.*.chain;
    pool.*.chain = cl;
}

test "buf" {
    try expectEqual(@sizeOf(ngx_buf_t), 80);
}
