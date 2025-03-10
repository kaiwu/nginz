const std = @import("std");
const pq = @import("pq.zig");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const string = @import("ngx_string.zig");
const expectEqual = std.testing.expectEqual;

const PQconninfoOption = pq.PQconninfoOption;

const PQconndefaults = pq.PQconndefaults;
const PQconninfoFree = pq.PQconninfoFree;
const PQconninfoParse = pq.PQconninfoParse;

const ngx_log_init = ngx.ngx_log_init;
const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;

fn is_option(p: [*c]PQconninfoOption) bool {
    return p.*.keyword != core.nullptr(u8);
}

fn pq_option(con: []const u8) void {
    var str: [256]u8 = std.mem.zeroes([256]u8);
    var err: [*c]u8 = core.nullptr(u8);
    @memcpy(str[0..con.len], con);
    const parsed = PQconninfoParse(&str, &err);
    const os = core.make_slice(PQconninfoOption, parsed, is_option);

    if (err != core.nullptr(u8)) {
        std.debug.print("error: {s}\n", .{err});
    } else {
        for (os) |o| {
            const v: [*c]u8 = if (o.val == core.nullptr(u8)) @constCast("null") else o.val;
            const c: [*c]u8 = if (o.compiled == core.nullptr(u8)) @constCast("null") else o.compiled;
            const e: [*c]u8 = if (o.envvar == core.nullptr(u8)) @constCast("null") else o.envvar;
            std.debug.print("{s}: {s} ENV({s}) DEF({s})\n", .{ o.keyword, v, e, c });
        }
        std.debug.print("\n", .{});
    }
    PQconninfoFree(parsed);
}

test "pq" {
    const cons: []const u8 =
        \\postgresql://
        \\postgresql://localhost
        \\postgresql://localhost:5433
        \\postgresql://localhost/mydb
        \\postgresql://user@localhost
        \\postgresql://user:secret@localhost
        \\postgresql://other@localhost/otherdb?connect_timeout=10&application_name=myapp
        \\postgresql://host1:123,host2:456/somedb?target_session_attrs=any&application_name=myapp
        \\
    ;

    var i: usize = 0;
    var j: usize = i;
    while (i < cons.len) : (i += 1) {
        if (cons[i] == '\n') {
            pq_option(cons[j..i]);
            j = i + 1;
        }
    }
}
