const std = @import("std");
const ngx = @import("ngx.zig");
const nginx = @import("nginx.zig");

const log = nginx.log;
const core = nginx.core;
const conf = nginx.conf;
const array = nginx.array;
const string = nginx.string;
const module = nginx.module;
const expectEqual = std.testing.expectEqual;

pub const ngx_http_file_cache_node_t = ngx.ngx_http_file_cache_node_t;
pub const ngx_http_cache_t = ngx.ngx_http_cache_t;
pub const ngx_http_listen_opt_t = ngx.ngx_http_listen_opt_t;
pub const ngx_http_core_srv_conf_t = ngx.ngx_http_core_srv_conf_t;
pub const ngx_http_addr_conf_t = ngx.ngx_http_addr_conf_t;
pub const ngx_http_conf_addr_t = ngx.ngx_http_conf_addr_t;
pub const ngx_http_core_loc_conf_t = ngx.ngx_http_core_loc_conf_t;
pub const ngx_http_header_out_t = ngx.ngx_http_header_out_t;
pub const ngx_http_headers_in_t = ngx.ngx_http_headers_in_t;
pub const ngx_http_request_body_t = ngx.ngx_http_request_body_t;
pub const ngx_http_connection_t = ngx.ngx_http_connection_t;
pub const ngx_http_request_t = ngx.ngx_http_request_t;
pub const ngx_http_script_engine_t = ngx.ngx_http_script_engine_t;
pub const ngx_http_script_compile_t = ngx.ngx_http_script_compile_t;
pub const ngx_http_script_regex_code_t = ngx.ngx_http_script_regex_code_t;
pub const ngx_http_script_regex_end_code_t = ngx.ngx_http_script_regex_end_code_t;
pub const ngx_http_compile_complex_value_t = ngx.ngx_http_compile_complex_value_t;
pub const ngx_http_upstream_server_t = ngx.ngx_http_upstream_server_t;
pub const ngx_http_upstream_conf_t = ngx.ngx_http_upstream_conf_t;
pub const ngx_http_upstream_headers_in_t = ngx.ngx_http_upstream_headers_in_t;
pub const ngx_http_upstream_t = ngx.ngx_http_upstream_t;
pub const ngx_http_upstream_rr_peer_t = ngx.ngx_http_upstream_rr_peer_t;
pub const ngx_http_upstream_rr_peers_t = ngx.ngx_http_upstream_rr_peers_t;
pub const ngx_ssl_connection_t = ngx.ngx_ssl_connection_t;
pub const ngx_ssl_ticket_key_t = ngx.ngx_ssl_ticket_key_t;
pub const ngx_http_module_t = ngx.ngx_http_module_t;

pub const ngx_http_script_run = ngx.ngx_http_script_run;

const NError = core.NError;
const NGX_OK = core.NGX_OK;

const ngx_str_t = core.ngx_str_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_array_t = array.ngx_array_t;
const ngx_module_t = module.ngx_module_t;

pub inline fn ngz_http_get_module_ctx(
    comptime T: type,
    r: [*c]ngx_http_request_t,
    m: [*c]ngx_module_t,
) ![*c]T {
    if (core.castPtr(T, r.*.ctx[m.*.ctx_index])) |ctx| {
        return ctx;
    }
    if (core.ngz_pcalloc_c(T, r.*.pool)) |ctx| {
        r.*.ctx[m.*.ctx_index] = ctx;
        return ctx;
    }
    return core.NError.OOM;
}

pub const NGX_HTTP_OK = ngx.NGX_HTTP_OK;
pub const NGX_HTTP_INTERNAL_SERVER_ERROR = ngx.NGX_HTTP_INTERNAL_SERVER_ERROR;

pub const ngx_http_send_header = ngx.ngx_http_send_header;
pub const ngx_create_temp_buf = ngx.ngx_create_temp_buf;
pub const ngx_http_output_filter = ngx.ngx_http_output_filter;

test "http" {
    try expectEqual(@sizeOf(ngx_http_file_cache_node_t), 120);
    try expectEqual(@sizeOf(ngx_http_cache_t), 608);
    try expectEqual(@sizeOf(ngx_http_listen_opt_t), 72);
    try expectEqual(@sizeOf(ngx_http_core_srv_conf_t), 168);
    try expectEqual(@sizeOf(ngx_http_addr_conf_t), 24);
    try expectEqual(@sizeOf(ngx_http_conf_addr_t), 176);
    try expectEqual(@sizeOf(ngx_http_core_loc_conf_t), 704);
    try expectEqual(@sizeOf(ngx_http_headers_in_t), 312);
    try expectEqual(@sizeOf(ngx_http_request_body_t), 80);
    try expectEqual(@sizeOf(ngx_http_connection_t), 64);
    try expectEqual(@sizeOf(ngx_http_header_out_t), 24);

    try expectEqual(@sizeOf(ngx_http_request_t), 1320);
    try expectEqual(@offsetOf(ngx_http_request_t, "connection"), 8);
    try expectEqual(@offsetOf(ngx_http_request_t, "cleanup"), 1112);
    try expectEqual(@offsetOf(ngx_http_request_t, "flags0"), 1120);
    try expectEqual(@offsetOf(ngx_http_request_t, "flags1"), 1128);
    try expectEqual(@offsetOf(ngx_http_request_t, "state"), 1136);
    try expectEqual(@offsetOf(ngx_http_request_t, "host_end"), 1304);
    try expectEqual(@offsetOf(ngx_http_request_t, "flags2"), 1312);

    try expectEqual(@sizeOf(ngx_http_script_engine_t), 88);
    try expectEqual(@sizeOf(ngx_http_script_compile_t), 88);
    try expectEqual(@sizeOf(ngx_http_compile_complex_value_t), 32);
    try expectEqual(@sizeOf(ngx_http_script_regex_code_t), 72);
    try expectEqual(@sizeOf(ngx_http_script_regex_end_code_t), 16);

    try expectEqual(@sizeOf(ngx_http_upstream_server_t), 120);
    try expectEqual(@sizeOf(ngx_http_upstream_conf_t), 520);
    try expectEqual(@sizeOf(ngx_http_upstream_headers_in_t), 312);
    try expectEqual(@sizeOf(ngx_http_upstream_t), 1024);
    try expectEqual(@sizeOf(ngx_http_upstream_rr_peer_t), 200);
    try expectEqual(@sizeOf(ngx_http_upstream_rr_peers_t), 96);

    try expectEqual(@sizeOf(ngx_ssl_connection_t), 96);
    try expectEqual(@sizeOf(ngx_ssl_ticket_key_t), 96);
    try expectEqual(@sizeOf(ngx_http_module_t), 64);
}
