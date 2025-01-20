const std = @import("std");
const ngx = @import("nginx");

const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NULL = core.NULL;
const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_msec_t = core.ngx_msec_t;
const ngx_pool_t = core.ngx_pool_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_event_t = core.ngx_event_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_array_t = ngx.array.ngx_array_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NChain = ngx.buf.NChain;
const NArray = ngx.array.NArray;
const NTimer = ngx.event.NTimer;
const NSubrequest = http.NSubrequest;

const echoz_command_type = enum(ngx_int_t) {
    echoz,
    echozn,
    echoz_duplicate,
    echoz_flush,
    echoz_sleep,
    echoz_location,
    echoz_location_async,
};

const echoz_parameter = extern struct {
    raw: ngx_str_t,
    variables: ngx_uint_t,
    lengths: [*c]ngx_array_t,
    values: [*c]ngx_array_t,
};

const echoz_command = extern struct {
    type: echoz_command_type,
    params: NArray(echoz_parameter),
};

const ZError = error{
    COMMAND_ERROR,
    SCRIPT_ERROR,
    HEADER_ERROR,
    BODY_ERROR,
    TIMER_EVENT,
    SUBREQ_EVENT,
    DECLINE,
};

const loc_conf = extern struct {
    cmds: NArray(echoz_command),
};

const echoz_context = extern struct {
    ready: ngx_flag_t,
    iterator: NArray(echoz_command).IteratorType,
    chain: NChain,
    space_str: ngx_str_t,
    newline_str: ngx_str_t,
    header_sent: ngx_flag_t,
    timer: NTimer,
    subrequest: NSubrequest,
};

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    _ = cf;
    return NGX_OK;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (core.ngz_pcalloc_c(loc_conf, cf.*.pool)) |p| {
        return p;
    }
    return null;
}

fn parse_uri(r: [*c]ngx_http_request_t, ps: *const NArray(ngx_str_t)) ![2]ngx_str_t {
    var s2 = [2]ngx_str_t{ ps.at(0).?.*, ngx.string.ngx_null_str };
    var flags: ngx_uint_t = 0;
    if (http.ngx_http_parse_unsafe_uri(r, &s2[0], &s2[1], &flags) != core.NGX_OK) {
        return ZError.COMMAND_ERROR;
    }
    if (ps.size() > 1) {
        s2[1] = ps.at(1).?.*;
    }
    return s2;
}

fn atof(s: ngx_str_t, precision: ngx_uint_t) ngx_msec_t {
    var t2 = [2]ngx_uint_t{ 0, 0 };
    var i: usize = 0;
    var p: ngx_uint_t = 0;
    for (core.slicify(u8, s.data, s.len)) |c| {
        if (p > @min(precision, 3)) {
            break;
        }
        if (c >= '0' and c <= '9') {
            t2[i] = t2[i] * 10 + c - '0';
        }
        if (c == '.' and i == 0) {
            i += 1;
        }
        if (i > 0) {
            p += 1;
        }
    }
    for (0..4 - p) |_| {
        t2[1] *= 10;
    }
    return t2[0] * 1000 + t2[1];
}

fn atoz(s: [*c]ngx_str_t) ZError!ngx_uint_t {
    var x: ngx_uint_t = 0;
    for (core.slicify(u8, s.*.data, s.*.len)) |c| {
        switch (c) {
            '_' => continue,
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' => x = x * 10 + c - '0',
            else => return ZError.COMMAND_ERROR,
        }
    }
    return x;
}

fn send_header(r: [*c]ngx_http_request_t, ctx: [*c]echoz_context) ZError!void {
    r.*.headers_out.status = http.NGX_HTTP_OK;
    http.ngx_http_clear_content_length(r);
    http.ngx_http_clear_accept_ranges(r);

    if (http.ngx_http_send_header(r) != NGX_OK) {
        return ZError.HEADER_ERROR;
    }
    ctx.*.header_sent = 1;
}

fn send_body(r: [*c]ngx_http_request_t, chain: [*c]ngx_chain_t) ZError!void {
    if (chain != core.nullptr(ngx_chain_t)) {
        if (http.ngx_http_output_filter(r, chain) != NGX_OK) {
            return ZError.BODY_ERROR;
        }
    } else {
        if (http.ngx_http_send_special(r, http.NGX_HTTP_LAST) != NGX_OK) {
            return ZError.BODY_ERROR;
        }
    }
}

fn write_buf(it: *NArray(ngx_str_t).IteratorType, b: [*c]ngx_buf_t) void {
    while (it.next()) |s| {
        core.ngz_memcpy(b.*.last, s.*.data, s.*.len);
        b.*.last += s.*.len;
    }
}

fn with_newline(cmd: [*c]echoz_command) bool {
    return cmd.*.type == .echoz;
}

fn set_type(offset: ngx_int_t) echoz_command_type {
    return @enumFromInt(@intFromEnum(echoz_command_type.echoz) + offset);
}

fn map(
    ps: NArray(echoz_parameter),
    r: [*c]ngx_http_request_t,
    ctx: [*c]echoz_context,
    total_length: *ngx_uint_t,
) !NArray(ngx_str_t) {
    var ss = try NArray(ngx_str_t).init(r.*.pool, ps.size());
    var i: ngx_uint_t = 0;
    while (i < ps.size()) : (i += 1) {
        if (ps.at(i)) |p0| {
            const s0 = try ss.append();
            if (p0.*.variables == 0) {
                s0.* = p0.*.raw;
            }
            if (p0.*.variables > 0 and http.ngx_http_script_run(
                r,
                s0,
                p0.*.lengths.*.elts,
                0,
                p0.*.values.*.elts,
            ) == core.nullptr(core.u_char)) {
                return ZError.SCRIPT_ERROR;
            }
            total_length.* += s0.*.len;
            if (i + 1 < ps.size()) {
                const space = try ss.append();
                space.* = ctx.*.space_str;
                total_length.* += 1;
            }
        }
    }
    return ss;
}

fn echoz_exec_command(cmd: [*c]echoz_command, ctx: [*c]echoz_context, r: [*c]ngx_http_request_t, c: [*c]ngx_chain_t) !void {
    var total_length: ngx_uint_t = 0;
    const parameters = try map(cmd.*.params, r, ctx, &total_length);
    switch (cmd.*.type) {
        .echoz => {
            const last = try ctx.*.chain.allocNStr(parameters, c);
            _ = try ctx.*.chain.allocStr(ctx.*.newline_str, last);
        },
        .echozn => _ = try ctx.*.chain.allocNStr(parameters, c),
        .echoz_duplicate => {
            var it = parameters.iterator();
            if (it.next()) |first| {
                const n = try atoz(first);
                const len = total_length - first.*.len - 1;
                const cl = try ctx.*.chain.alloc(n * len, c);
                _ = it.next(); //skip the space
                for (0..n) |_| {
                    write_buf(&it, cl.*.buf);
                    it.resetN(2);
                }
            }
        },
        .echoz_flush => {
            if (http.ngx_http_send_special(r, http.NGX_HTTP_FLUSH) != NGX_OK) {
                return ZError.BODY_ERROR;
            }
        },
        .echoz_sleep => {
            var it = parameters.iterator();
            if (it.next()) |delay| {
                try ctx.*.timer.activate(atof(delay.*, 3));
                return ZError.TIMER_EVENT;
            }
        },
        .echoz_location => {
            var s2 = try parse_uri(r, &parameters);
            _ = try ctx.*.subrequest.create(&s2[0], &s2[1], ngx_http_echoz_subrequest_post_handler);
            return ZError.SUBREQ_EVENT;
        },
        .echoz_location_async => {
            var s2 = try parse_uri(r, &parameters);
            _ = try ctx.*.subrequest.create(&s2[0], &s2[1], null);
        },
        // else => return ZError.COMMAND_ERROR,
    }
}

fn echoz_handle(r: [*c]ngx_http_request_t) !void {
    if (core.castPtr(loc_conf, conf.ngx_http_get_module_loc_conf(r, &ngx_http_echoz_module))) |lccf| {
        if (!lccf.*.cmds.inited() or lccf.*.cmds.size() == 0) {
            return ZError.DECLINE;
        }
        const ctx = try http.ngz_http_get_module_ctx(echoz_context, r, &ngx_http_echoz_module);

        if (ctx.*.ready == 0) {
            ctx.*.iterator = lccf.*.cmds.iterator();
            ctx.*.chain = NChain.init(r.*.pool);
            ctx.*.space_str = ngx_string(" ");
            ctx.*.newline_str = ngx_string("\n");
            ctx.*.header_sent = 0;
            ctx.*.timer = NTimer.init(r, ngx_http_echoz_handler);
            ctx.*.subrequest = NSubrequest.init(r);
            ctx.*.ready = 1;
        }

        if (!r.*.flags1.header_sent and ctx.*.header_sent == 0) {
            try send_header(r, ctx);
        }
        var out = buf.ngx_chain_t{
            .buf = core.nullptr(ngx_buf_t),
            .next = core.nullptr(ngx_chain_t),
        };
        while (ctx.*.iterator.next()) |cmd| {
            try echoz_exec_command(cmd, ctx, r, &out);
            if (out.next != core.nullptr(ngx_chain_t)) {
                try send_body(r, out.next);
                out.next = core.nullptr(ngx_chain_t);
            }
        }
        try send_body(r, out.next);
    }
}

fn ngx_http_echoz_subrequest_post_handler(sr: [*c]ngx_http_request_t, ctx: ?*anyopaque, rc: ngx_int_t) callconv(.C) ngx_int_t {
    if (core.castPtr(NSubrequest, ctx)) |sub| {
        const pr = sub.*.parent;
        if (sr.*.out != core.nullptr(ngx_chain_t)) {
            send_body(pr, sr.*.out) catch {
                http.ngx_http_finalize_request(pr, http.NGX_HTTP_INTERNAL_SERVER_ERROR);
                return NGX_ERROR;
            };
        }
        http.ngx_http_finalize_request(pr, ngx_http_echoz_handler(pr));
    }
    return rc;
}

export fn ngx_http_echoz_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    echoz_handle(r) catch |e| {
        switch (e) {
            ZError.TIMER_EVENT, ZError.SUBREQ_EVENT => return core.NGX_DONE,
            else => return http.NGX_HTTP_INTERNAL_SERVER_ERROR,
        }
    };
    return NGX_OK;
}

fn ngx_conf_set_echoz(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, loc: ?*anyopaque) callconv(.C) [*c]u8 {
    if (core.castPtr(loc_conf, loc)) |lccf| {
        if (!lccf.*.cmds.inited()) {
            lccf.*.cmds = NArray(echoz_command).init(cf.*.pool, 1) catch return conf.NGX_CONF_ERROR;
            if (conf.ngx_http_conf_get_core_module_loc_conf(cf)) |cocf| {
                cocf.*.handler = ngx_http_echoz_handler;
            }
        }

        const echoz = lccf.*.cmds.append() catch return conf.NGX_CONF_ERROR;
        echoz.*.type = set_type(@intCast(cmd.*.offset));
        echoz.*.params = NArray(echoz_parameter).init(cf.*.pool, 1) catch return conf.NGX_CONF_ERROR;
        var i: ngx_uint_t = 1;
        while (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            ngx.log.ngx_http_conf_debug(cf, "%V", .{arg});
            const param = echoz.*.params.append() catch return conf.NGX_CONF_ERROR;
            param.*.raw = arg.*;
            param.*.variables = conf.ngz_http_conf_variables_parse(
                cf,
                arg,
                &param.*.lengths,
                &param.*.values,
            ) catch return conf.NGX_CONF_ERROR;
        }
    }
    return conf.NGX_CONF_OK;
}

export const ngx_http_echoz_module_ctx = ngx_http_module_t{
    .preconfiguration = @ptrCast(NULL),
    .postconfiguration = postconfiguration,
    .create_main_conf = @ptrCast(NULL),
    .init_main_conf = @ptrCast(NULL),
    .create_srv_conf = @ptrCast(NULL),
    .merge_srv_conf = @ptrCast(NULL),
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = @ptrCast(NULL),
};

export const ngx_http_echoz_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("echoz"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_ANY,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("echozn"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_ANY,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 1,
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("echoz_duplicate"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_2MORE,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 2,
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("echoz_flush"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 3,
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("echoz_sleep"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 4,
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("echoz_location"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE12,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 5,
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("echoz_location_async"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE12,
        .set = ngx_conf_set_echoz,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 6,
        .post = NULL,
    },
};

export var ngx_http_echoz_module = ngx.module.make_module(
    @constCast(&ngx_http_echoz_commands),
    @constCast(&ngx_http_echoz_module_ctx),
);

const expectEqual = std.testing.expectEqual;
test "module" {
    try expectEqual(ngx_http_echoz_module.version, 1027004);
    const len = core.sizeof(ngx.module.NGX_MODULE_SIGNATURE);
    const slice = core.make_slice(@constCast(ngx_http_echoz_module.signature), len);
    try expectEqual(slice.len, 40);

    try expectEqual(atof(ngx_string("2.181"), 2), 2180);
    try expectEqual(atof(ngx_string("2.1011"), 3), 2101);
    try expectEqual(atof(ngx_string("21"), 3), 21000);
}
