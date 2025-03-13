const std = @import("std");
const pq = @import("pq.zig");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const string = @import("ngx_string.zig");
const expectEqual = std.testing.expectEqual;

const ngx_str_t = string.ngx_str_t;

const PQconninfoOption = pq.PQconninfoOption;

pub const pq_conn_status = enum(pq.ConnStatusType) {
    CONNECTION_OK = pq.CONNECTION_OK,
    CONNECTION_BAD = pq.CONNECTION_BAD,
    CONNECTION_STARTED = pq.CONNECTION_STARTED,
    CONNECTION_MADE = pq.CONNECTION_MADE,
    CONNECTION_AWAITING_RESPONSE = pq.CONNECTION_AWAITING_RESPONSE,
    CONNECTION_AUTH_OK = pq.CONNECTION_AUTH_OK,
    CONNECTION_SETENV = pq.CONNECTION_SETENV,
    CONNECTION_SSL_STARTUP = pq.CONNECTION_SSL_STARTUP,
    CONNECTION_NEEDED = pq.CONNECTION_NEEDED,
    CONNECTION_CHECK_WRITABLE = pq.CONNECTION_CHECK_WRITABLE,
    CONNECTION_CONSUME = pq.CONNECTION_CONSUME,
    CONNECTION_GSS_STARTUP = pq.CONNECTION_GSS_STARTUP,
    CONNECTION_CHECK_TARGET = pq.CONNECTION_CHECK_TARGET,
    CONNECTION_CHECK_STANDBY = pq.CONNECTION_CHECK_STANDBY,
    CONNECTION_ALLOCATED = pq.CONNECTION_ALLOCATED,
    CONNECTION_AUTHENTICATING = pq.CONNECTION_AUTHENTICATING,
};

pub const pq_polling_status = enum(pq.PostgresPollingStatusType) {
    PGRES_POLLING_FAILED = pq.PGRES_POLLING_FAILED,
    PGRES_POLLING_READING = pq.PGRES_POLLING_READING,
    PGRES_POLLING_WRITING = pq.PGRES_POLLING_WRITING,
    PGRES_POLLING_OK = pq.PGRES_POLLING_OK,
    PGRES_POLLING_ACTIVE = pq.PGRES_POLLING_ACTIVE,
};

const PQfinish = pq.PQfinish;
const PQsocket = pq.PQsocket;
const PQstatus = pq.PQstatus;
const PQfreemem = pq.PQfreemem;
const PQconnectPoll = pq.PQconnectPoll;
const PQconndefaults = pq.PQconndefaults;
const PQconninfoFree = pq.PQconninfoFree;
const PQconninfoParse = pq.PQconninfoParse;

pub fn is_valid_pq_conn(con: ngx_str_t, err: [*c]u8) bool {
    var str: [256]u8 = std.mem.zeroes([256]u8);
    core.ngz_memcpy(&str, con.data, con.len);
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
