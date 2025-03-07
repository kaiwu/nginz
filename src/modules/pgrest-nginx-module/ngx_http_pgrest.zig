const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const file = ngx.file;

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
const ngx_table_elt_t = ngx.hash.ngx_table_elt_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NList = ngx.list.NList;
const NChain = ngx.buf.NChain;
const NArray = ngx.array.NArray;

export const ngx_http_pgrest_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = null,
    .merge_loc_conf = null,
};

export const ngx_http_pgrest_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("pgrest_server"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_1MORE,
        .set = conf.ngx_conf_set_str_slot,
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
