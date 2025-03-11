const std = @import("std");
const pq = @import("pq.zig");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const string = @import("ngx_string.zig");
const expectEqual = std.testing.expectEqual;

const ngx_str_t = string.ngx_str_t;

const PQconninfoOption = pq.PQconninfoOption;

const PQfreemem = pq.PQfreemem;
const PQconndefaults = pq.PQconndefaults;
const PQconninfoFree = pq.PQconninfoFree;
const PQconninfoParse = pq.PQconninfoParse;

pub fn is_valid_pq_conn(con: ngx_str_t, err: [*c]u8) bool {
    var str: [256]u8 = std.mem.zeroes([256]u8);
    @memcpy(str[0..con.len], core.slicify(u8, con.data, con.len));
    const info = PQconninfoParse(&str, @constCast(&err));
    if (info != core.nullptr(PQconninfoOption) and
        err == core.nullptr(u8))
    {
        defer PQconninfoFree(info);
        return true;
    }
    return false;
}

const ngx_log_init = ngx.ngx_log_init;
const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;

test "pq" {}
