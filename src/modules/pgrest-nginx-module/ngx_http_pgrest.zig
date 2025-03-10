const std = @import("std");
const ngx = @import("ngx");

const pq = ngx.pq;
const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const file = ngx.file;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;

const NGX_CONF_OK = conf.NGX_CONF_OK;
const NGX_CONF_ERROR = conf.NGX_CONF_ERROR;

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
const ngx_table_elt_t = ngx.hash.ngx_table_elt_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NList = ngx.list.NList;
const NChain = ngx.buf.NChain;
const NArray = ngx.array.NArray;

extern var ngx_http_upstream_module: ngx_module_t;

const ngx_pgrest_upstream_srv_t = extern struct {
    conn: ngx_str_t,
};

const ngx_pgrest_srv_conf_t = extern struct {
    servers: NArray(ngx_pgrest_upstream_srv_t),
};

const ngx_pgrest_loc_conf_t = extern struct {};

fn pgrest_create_srv_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (core.ngz_pcalloc_c(ngx_pgrest_srv_conf_t, cf.*.pool)) |srv| {
        return srv;
    }
    return null;
}

fn pgrest_create_loc_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (core.ngz_pcalloc_c(ngx_pgrest_loc_conf_t, cf.*.pool)) |loc| {
        return loc;
    }
    return null;
}

fn ngx_conf_set_server(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.C) [*c]u8 {
    _ = cmd;
    if (core.castPtr(ngx_pgrest_srv_conf_t, loc)) |srv| {
        if (srv.*.servers.ready == 0) {
            srv.*.servers = NArray(ngx_pgrest_upstream_srv_t).init(
                cf.*.pool,
                4,
            ) catch return NGX_CONF_ERROR;
            if (core.castPtr(
                http.ngx_http_upstream_srv_conf_t,
                conf.ngx_http_conf_get_module_srv_conf(cf, &ngx_http_upstream_module),
            )) |uscf| {
                uscf.*.servers = srv.*.servers.pa;
            }
        }
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const pgs = srv.*.servers.append() catch return NGX_CONF_ERROR;
            pgs.*.conn = arg.*;
            const err: [*c]u8 = core.nullptr(u8);
            if (!pq.is_valid_pq_conn(pgs.*.conn, err)) {
                return err;
            }
            return NGX_CONF_OK;
        }
    }
    return NGX_CONF_ERROR;
}

export const ngx_http_pgrest_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = pgrest_create_srv_conf,
    .merge_srv_conf = null,
    .create_loc_conf = pgrest_create_loc_conf,
    .merge_loc_conf = null,
};

export const ngx_http_pgrest_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("pgrest_server"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_server,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("pgrest_keepalive"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_1MORE,
        .set = conf.ngx_conf_set_num_slot,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },

    conf.ngx_null_command,
};

export var ngx_http_pgrest_module = ngx.module.make_module(
    @constCast(&ngx_http_pgrest_commands),
    @constCast(&ngx_http_pgrest_module_ctx),
);

const expectEqual = std.testing.expectEqual;
test "pgrest module" {}
