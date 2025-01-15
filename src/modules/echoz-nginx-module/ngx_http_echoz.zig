const std = @import("std");
const ngx = @import("nginx");
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
const ngx_pool_t = core.ngx_pool_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_array_t = ngx.array.ngx_array_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NArray = ngx.array.NArray;

const echoz_command_type = enum(ngx_int_t) {
    echoz,
    echozn,
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

fn map(ps: NArray(echoz_parameter), p: [*c]ngx_pool_t, r: [*c]ngx_http_request_t) !NArray(ngx_str_t) {
    var ss = try NArray(ngx_str_t).init(p, ps.size());
    for (NArray(echoz_parameter).slice(@constCast(&ps)), ss.slice()) |p0, *s0| {
        if (p0.variables == 0) {
            s0.* = p0.raw;
            continue;
        }
        if (http.ngx_http_script_run(
            r,
            s0,
            p0.lengths.*.elts,
            0,
            p0.values.*.elts,
        ) == core.nullptr(core.u_char)) {
            return core.NError.REQUEST_ERROR;
        }
    }
    return ss;
}

const loc_conf = extern struct {
    cmds: NArray(echoz_command),
};

const echoz_context = extern struct {
    ready: ngx_flag_t,
    iterator: NArray(echoz_command).IteratorType,
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

fn echoz_exec_command(
    cmd: [*c]echoz_command,
    ctx: [*c]echoz_context,
    r: [*c]ngx_http_request_t,
) ngx_int_t {
    _ = ctx;
    const parameters = map(cmd.*.params, r.*.pool, r) catch return NGX_ERROR;
    _ = parameters;
    return NGX_OK;
}

export fn ngx_http_echoz_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(loc_conf, conf.ngx_http_get_module_loc_conf(r, &ngx_http_echoz_module))) |lccf| {
        if (!lccf.*.cmds.inited() or lccf.*.cmds.size() == 0) {
            return NGX_DECLINED;
        }
        const ctx = http.ngz_http_get_module_ctx(
            echoz_context,
            r,
            &ngx_http_echoz_module,
        ) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

        if (ctx.*.ready == 0) {
            ctx.*.iterator = lccf.*.cmds.iterator();
            ctx.*.ready = 1;
        }
        while (ctx.*.iterator.next()) |cmd| {
            const res = echoz_exec_command(cmd, ctx, r);
            if (res != NGX_OK) {
                return res;
            }
        }
    }
    return NGX_OK;
}

fn ngx_conf_set_echoz(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, loc: ?*anyopaque) callconv(.C) [*c]u8 {
    _ = cmd;
    if (core.castPtr(loc_conf, loc)) |lccf| {
        if (!lccf.*.cmds.inited()) {
            lccf.*.cmds = NArray(echoz_command).init(cf.*.pool, 1) catch return conf.NGX_CONF_ERROR;
            if (conf.ngx_http_conf_get_core_module_loc_conf(cf)) |cocf| {
                cocf.*.handler = ngx_http_echoz_handler;
            }
        }

        const echoz = lccf.*.cmds.append() catch return conf.NGX_CONF_ERROR;
        echoz.*.type = .echoz;
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
}
