const std = @import("std");
const ngx = @import("ngx.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_buf_t = ngx.ngx_buf_t;
pub const ngx_output_chain_ctx_t = ngx.ngx_output_chain_ctx_t;
pub const ngx_listening_t = ngx.ngx_listening_t;
pub const ngx_connection_t = ngx.ngx_connection_t;
pub const ngx_file_t = ngx.ngx_file_t;
pub const ngx_temp_file_t = ngx.ngx_temp_file_t;
pub const ngx_ext_rename_file_t = ngx.ngx_ext_rename_file_t;
pub const ngx_url_t = ngx.ngx_url_t;
pub const ngx_open_file_info_t = ngx.ngx_open_file_info_t;
pub const ngx_cached_open_file_t = ngx.ngx_cached_open_file_t;
pub const ngx_resolver_node_t = ngx.ngx_resolver_node_t;
pub const ngx_resolver_t = ngx.ngx_resolver_t;
pub const ngx_resolver_ctx_t = ngx.ngx_resolver_ctx_t;

pub const ngx_array_t = ngx.ngx_array_t;

test "ngx data types" {
    try expectEqual(@sizeOf(ngx_buf_t), 80);
    try expectEqual(@sizeOf(ngx_output_chain_ctx_t), 104);
    try expectEqual(@sizeOf(ngx_listening_t), 296);
    try expectEqual(@sizeOf(ngx_connection_t), 224);
    try expectEqual(@sizeOf(ngx_file_t), 200);
    try expectEqual(@sizeOf(ngx_temp_file_t), 248);
    try expectEqual(@sizeOf(ngx_ext_rename_file_t), 40);
    try expectEqual(@sizeOf(ngx_url_t), 224);
    try expectEqual(@sizeOf(ngx_open_file_info_t), 104);
    try expectEqual(@sizeOf(ngx_cached_open_file_t), 144);
    try expectEqual(@sizeOf(ngx_resolver_node_t), 184);
    try expectEqual(@sizeOf(ngx_resolver_t), 512);
    try expectEqual(@sizeOf(ngx_resolver_ctx_t), 224);
}
