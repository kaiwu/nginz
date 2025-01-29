const std = @import("std");
const ngx = @import("ngx");

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

const expectEqual = std.testing.expectEqual;
test "wechatpay module" {}
