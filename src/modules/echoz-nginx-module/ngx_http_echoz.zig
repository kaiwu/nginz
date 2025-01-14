const std = @import("std");
const ngx = @import("nginx");
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NULL = core.NULL;
const NGX_OK = core.NGX_OK;

const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_str_t = ngx.core.ngx_str_t;
const ngx_int_t = ngx.core.ngx_int_t;
const ngx_uint_t = ngx.core.ngx_uint_t;
const ngx_flag_t = ngx.core.ngx_flag_t;
const ngx_conf_t = ngx.conf.ngx_conf_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_array_t = ngx.array.ngx_array_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_command_t = ngx.conf.ngx_command_t;
const ngx_http_module_t = ngx.http.ngx_http_module_t;
const ngx_http_request_t = ngx.http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NArray = ngx.array.NArray;

const echoz_command_type = enum(ngx_int_t) {
    echoz,
    echozn,
};

const echoz_parameter = extern struct {
    plain: ngx_str_t,
    lengths: [*c]ngx_array_t,
    values: [*c]ngx_array_t,
};

const echoz_command = extern struct {
    type: echoz_command_type,
    params: NArray(echoz_parameter),
};

const loc_conf = extern struct {
    cmds: NArray(echoz_command),
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

export fn ngx_http_echoz_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    const response = ngx_string("echoz");
    r.*.headers_out.status = http.NGX_HTTP_OK;
    r.*.headers_out.content_length_n = response.len;
    _ = http.ngx_http_send_header(r);

    // Send the response body
    const b: [*c]ngx_buf_t = http.ngx_create_temp_buf(r.*.pool, response.len);
    var out = ngx_chain_t{
        .buf = b,
        .next = core.nullptr(ngx_chain_t),
    };

    // ngx_memcpy(b->pos, response.data, response.len);
    // b->last = b->pos + response.len;
    // b->last_buf = 1;  // Mark as the last buffer

    return http.ngx_http_output_filter(r, &out);
}

fn ngx_conf_set_echoz(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, loc: ?*anyopaque) callconv(.C) [*c]u8 {
    _ = cmd;
    if (core.castPtr(loc_conf, loc)) |lccf| {
        if (!lccf.*.cmds.inited()) {
            lccf.*.cmds = NArray(echoz_command).init(cf.*.pool, 1) catch return conf.NGX_CONF_ERROR;
            http.ngz_http_loc_set_handler(cf, ngx_http_echoz_handler);
        }

        const echoz = lccf.*.cmds.append() catch return conf.NGX_CONF_ERROR;
        echoz.*.type = .echoz;
        echoz.*.params = NArray(echoz_parameter).init(cf.*.pool, 1) catch return conf.NGX_CONF_ERROR;
        var i: ngx_uint_t = 1;
        while (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            ngx.log.ngx_http_conf_debug(cf, "%V", .{arg});
            const param = echoz.*.params.append() catch return conf.NGX_CONF_ERROR;
            param.*.plain = arg.*;
            http.ngz_http_conf_variables_parse(cf, arg, &param.*.lengths, &param.*.values) catch return conf.NGX_CONF_ERROR;
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
