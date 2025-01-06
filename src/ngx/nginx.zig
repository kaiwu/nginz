const std = @import("std");
const ngx = @import("ngx.zig");
const expectEqual = std.testing.expectEqual;

pub const nginx_version = @as(ngx_uint_t, 1027003);
pub const ngx_stdin = std.posix.STDIN_FILENO;
pub const ngx_stdout = std.posix.STDOUT_FILENO;
pub const ngx_stderr = std.posix.STDERR_FILENO;

pub const NGX_OK = @as(c_int, 0);
pub const NGX_ERROR = @as(c_int, -1);
pub const NGX_AGAIN = @as(c_int, -2);
pub const NGX_BUSY = @as(c_int, -3);
pub const NGX_DONE = @as(c_int, -4);
pub const NGX_DECLINED = @as(c_int, -5);
pub const NGX_ABORT = @as(c_int, -6);

pub fn sizeof(comptime s: []const u8) usize {
    return s.len;
}

pub const NGX_INT32_LEN = sizeof("-2147483648");
pub const NGX_INT64_LEN = sizeof("-9223372036854775808");
pub const NGX_ALIGNMENT = std.zig.c_translation.sizeof(c_ulong);
pub const NGX_MAX_INT_T_VALUE = @as(c_long, 9223372036854775807);
pub const NGX_INVALID_ARRAY_INDEX = @as(c_uint, 0x80000000);
pub const NGX_MAXHOSTNAMELEN = @as(c_int, 256);
pub const NGX_MAX_UINT32_VALUE = @as(c_uint, 0xffffffff);
pub const NGX_MAX_INT32_VALUE = @as(c_int, 0x7fffffff);
pub const NGX_PTR_SIZE = @as(c_int, 8);
pub const NGX_SIG_ATOMIC_T_SIZE = @as(c_int, 4);
pub const NGX_TIME_T_SIZE = @as(c_int, 8);

pub inline fn ngx_align(d: ngx_uint_t, comptime a: ngx_uint_t) ngx_uint_t {
    if (a < 1) {
        @compileError("cannot align to 0");
    }
    return (d + (a - 1)) & ~(a - 1);
}

pub inline fn slicify(comptime T: type, p: [*c]T, len: usize) []T {
    return p[0..len];
}

pub inline fn make_slice(p: [*c]u8, len: usize) []u8 {
    return slicify(u8, p, len);
}

pub inline fn castPtr(comptime T: type, p: ?*anyopaque) ?[*c]T {
    if (p) |p0| {
        return @as([*c]T, @ptrCast(p0));
    }
    return null;
}

test "core" {
    try expectEqual(sizeof("-2147483648"), 11);
    try expectEqual(sizeof("-9223372036854775808"), 20);
    try expectEqual(NGX_MAX_INT_T_VALUE, std.math.maxInt(c_long));
    try expectEqual(NGX_MAX_UINT32_VALUE, std.math.maxInt(c_uint));
    try expectEqual(NGX_MAX_INT32_VALUE, std.math.maxInt(c_int));
    try expectEqual(NGX_ALIGNMENT, 8);
    try expectEqual(ngx_align(5, 1), 5);
    try expectEqual(ngx_align(5, 4), 8);
    try expectEqual(ngx_align(6, 4), 8);
    try expectEqual(ngx_align(8, 8), 8);
    try expectEqual(ngx_align(10, 8), 16);
}

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
pub const ngx_slab_pool_t = ngx.ngx_slab_pool_t;
pub const ngx_variable_value_t = ngx.ngx_variable_value_t;
pub const ngx_syslog_peer_t = ngx.ngx_syslog_peer_t;
pub const ngx_event_t = ngx.ngx_event_t;
pub const ngx_peer_connection_t = ngx.ngx_peer_connection_t;
pub const ngx_event_pipe_t = ngx.ngx_event_pipe_t;
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
pub const ngx_http_conf_ctx_t = ngx.ngx_http_conf_ctx_t;
pub const ngx_ssl_connection_t = ngx.ngx_ssl_connection_t;
pub const ngx_ssl_ticket_key_t = ngx.ngx_ssl_ticket_key_t;

pub const off_t = ngx.off_t;
pub const u_char = ngx.u_char;
pub const ngx_dir_t = ngx.ngx_dir_t;
pub const ngx_process_t = ngx.ngx_process_t;

pub const ngx_err_t = ngx.ngx_err_t;
pub const ngx_str_t = ngx.ngx_str_t;
pub const ngx_log_t = ngx.ngx_log_t;
pub const ngx_int_t = ngx.ngx_int_t;
pub const ngx_uint_t = ngx.ngx_uint_t;
pub const ngx_msec_t = ngx.ngx_msec_t;
pub const ngx_pool_t = ngx.ngx_pool_t;
pub const ngx_hash_t = ngx.ngx_hash_t;
pub const ngx_list_t = ngx.ngx_list_t;
pub const ngx_conf_t = ngx.ngx_conf_t;
pub const ngx_cycle_t = ngx.ngx_cycle_t;
pub const ngx_queue_t = ngx.ngx_queue_t;
pub const ngx_array_t = ngx.ngx_array_t;
pub const ngx_rbtree_t = ngx.ngx_rbtree_t;
pub const ngx_rbtree_node_t = ngx.ngx_rbtree_node_t;
pub const ngx_module_t = ngx.ngx_module_t;
pub const ngx_command_t = ngx.ngx_command_t;
pub const ngx_chain_t = ngx.ngx_chain_t;

pub const NULL = ngx.NULL;
pub const ngx_pallc = ngx.ngx_palloc;
pub const ngx_palloc = ngx.ngx_palloc;
pub const ngx_pcalloc = ngx.ngx_pcalloc;
pub const ngx_log_error_core = ngx.ngx_log_error_core;
pub const ngx_log_init = ngx.ngx_log_init;
pub const ngx_time_init = ngx.ngx_time_init;
pub const ngx_rbtree_insert_pt = ngx.ngx_rbtree_insert_pt;

test "ngx data types" {
    try expectEqual(@sizeOf(ngx_buf_t), 80);
    try expectEqual(@sizeOf(ngx_output_chain_ctx_t), 104);
    try expectEqual(@sizeOf(ngx_listening_t), 296);
    try expectEqual(@sizeOf(ngx_connection_t), 232);
    try expectEqual(@sizeOf(ngx_file_t), 200);
    try expectEqual(@sizeOf(ngx_temp_file_t), 248);
    try expectEqual(@sizeOf(ngx_ext_rename_file_t), 40);
    try expectEqual(@sizeOf(ngx_url_t), 224);
    try expectEqual(@sizeOf(ngx_open_file_info_t), 104);
    try expectEqual(@sizeOf(ngx_cached_open_file_t), 144);
    try expectEqual(@sizeOf(ngx_resolver_node_t), 184);
    try expectEqual(@sizeOf(ngx_resolver_t), 512);
    try expectEqual(@sizeOf(ngx_resolver_ctx_t), 224);
    try expectEqual(@sizeOf(ngx_slab_pool_t), 200);
    try expectEqual(@sizeOf(ngx_variable_value_t), 16);
    try expectEqual(@sizeOf(ngx_syslog_peer_t), 400);
    try expectEqual(@sizeOf(ngx_event_t), 96);
    try expectEqual(@sizeOf(ngx_peer_connection_t), 128);
    try expectEqual(@sizeOf(ngx_event_pipe_t), 280);
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

    try expectEqual(@sizeOf(c_uint), 4);
    try expectEqual(@sizeOf([4]c_uint), 16);
    try expectEqual(@sizeOf(ngx_dir_t), 168);
    try expectEqual(@sizeOf(ngx_process_t), 48);

    try expectEqual(@sizeOf(ngx_str_t), 16);
    try expectEqual(@sizeOf(ngx_log_t), 80);
    try expectEqual(@sizeOf(ngx_int_t), 8);
    try expectEqual(@sizeOf(ngx_uint_t), 8);
    try expectEqual(@sizeOf(ngx_msec_t), 8);
    try expectEqual(@sizeOf(ngx_pool_t), 80);
    try expectEqual(@sizeOf(ngx_hash_t), 16);
    try expectEqual(@sizeOf(ngx_list_t), 56);
    try expectEqual(@sizeOf(ngx_conf_t), 96);
    try expectEqual(@sizeOf(ngx_cycle_t), 648);
    try expectEqual(@sizeOf(ngx_queue_t), 16);
    try expectEqual(@sizeOf(ngx_array_t), 40);
    try expectEqual(@sizeOf(ngx_rbtree_t), 24);
    try expectEqual(@sizeOf(ngx_module_t), 200);
    try expectEqual(@sizeOf(ngx_command_t), 56);
}

pub inline fn ngx_buf_in_memory(b: [*c]ngx_buf_t) bool {
    return b.*.flags.temporary or b.*.flags.memory or b.*.flags.mmap;
}

pub inline fn ngx_buf_in_memory_only(b: [*c]ngx_buf_t) bool {
    return ngx_buf_in_memory(b) and !b.*.flags.in_file;
}

pub inline fn ngx_buf_special(b: [*c]ngx_buf_t) bool {
    return (b.*.flags.flush or b.*.flags.last_buf or b.*.flags.sync) and !ngx_buf_in_memory(b) and !b.*.flags.in_file;
}

pub inline fn ngx_buf_sync_only(b: [*c]ngx_buf_t) bool {
    return b.*.flags.sync and !ngx_buf_in_memory(b) and !b.*.flags.in_file and !b.*.flags.flush and !b.*.flags.last_buf;
}

pub inline fn ngx_buf_size(b: [*c]ngx_buf_t) off_t {
    return if (ngx_buf_in_memory(b)) @as(off_t, @intCast(b.*.last - b.*.pos)) else b.*.file_last - b.*.file_pos;
}

pub inline fn ngx_alloc_buf(pool: [*c]ngx_pool_t) [*c]ngx_buf_t {
    if (ngx_palloc(pool, @sizeOf(ngx_buf_t))) |p| {
        return @as([*c]ngx_buf_t, @ptrCast(p));
    } else {
        return NULL;
    }
}

pub inline fn ngx_calloc_buf(pool: [*c]ngx_pool_t) [*c]ngx_buf_t {
    if (ngx_pcalloc(pool, @sizeOf(ngx_buf_t))) |p| {
        return @as([*c]ngx_buf_t, @ptrCast(p));
    } else {
        return NULL;
    }
}

pub inline fn ngx_free_chain(pool: [*c]ngx_pool_t, cl: [*c]ngx_chain_t) void {
    cl.*.next = pool.*.chain;
    pool.*.chain = cl;
}

pub inline fn ngx_string(str: []const u8) ngx_str_t {
    return ngx_str_t{ .len = str.len, .data = str.ptr };
}

pub const ngx_null_str = ngx_str_t{ .len = 0, .data = NULL };

pub inline fn ngx_str_set(str: [*c]ngx_str_t, text: []const u8) void {
    str.*.len = text.len;
    str.*.data = text.ptr;
}

pub inline fn ngx_str_null(str: [*c]ngx_str_t) void {
    str.*.len = 0;
    str.*.data = NULL;
}

pub inline fn ngx_tolower(c: u8) u8 {
    return if (c >= 'A' and c <= 'Z') c | 0x20 else c;
}

pub inline fn ngx_toupper(c: u8) u8 {
    return if (c >= 'a' and c <= 'a') c & ~0x20 else c;
}

pub inline fn ngx_strlchr(p: [*c]u_char, last: [*c]u_char, c: u_char) [*c]u_char {
    var vp: [*c]u_char = p;
    while (vp < last) : (vp += 1) {
        if (vp.* == c) {
            return vp;
        }
    }
    return NULL;
}
pub const ngx_null_command = ngx_command_t{ .name = ngx_null_str, .type = 0, .set = NULL, .conf = 0, .offset = 0, .post = NULL };

pub inline fn ngx_base64_encoded_length(len: usize) usize {
    return ((len + 2) / 3) * 4;
}

pub inline fn ngx_base64_decoded_length(len: usize) usize {
    return ((len + 3) / 4) * 3;
}

pub const NGX_ESCAPE_URI = @as(c_int, 0);
pub const NGX_ESCAPE_ARGS = @as(c_int, 1);
pub const NGX_ESCAPE_URI_COMPONENT = @as(c_int, 2);
pub const NGX_ESCAPE_HTML = @as(c_int, 3);
pub const NGX_ESCAPE_REFRESH = @as(c_int, 4);
pub const NGX_ESCAPE_MEMCACHED = @as(c_int, 5);
pub const NGX_ESCAPE_MAIL_AUTH = @as(c_int, 6);

pub const NGX_UNESCAPE_URI = @as(c_int, 1);
pub const NGX_UNESCAPE_REDIRECT = @as(c_int, 2);

pub const NGX_HASH_SMALL = @as(c_int, 1);
pub const NGX_HASH_LARGE = @as(c_int, 2);
pub const NGX_HASH_LARGE_ASIZE = @as(c_int, 16384);
pub const NGX_HASH_LARGE_HSIZE = @as(c_int, 10007);
pub const NGX_HASH_WILDCARD_KEY = @as(c_int, 1);
pub const NGX_HASH_READONLY_KEY = @as(c_int, 2);

pub inline fn ngx_hash(key: ngx_uint_t, c: u8) ngx_uint_t {
    return key * 31 + @as(ngx_uint_t, @intCast(c));
}

pub const NGX_HTTP_MODULE = @as(c_uint, 0x50545448);
pub const NGX_HTTP_MAIN_CONF = @as(c_uint, 0x02000000);
pub const NGX_HTTP_SRV_CONF = @as(c_uint, 0x04000000);
pub const NGX_HTTP_LOC_CONF = @as(c_uint, 0x08000000);
pub const NGX_HTTP_UPS_CONF = @as(c_uint, 0x10000000);
pub const NGX_HTTP_SIF_CONF = @as(c_uint, 0x20000000);
pub const NGX_HTTP_LIF_CONF = @as(c_uint, 0x40000000);
pub const NGX_HTTP_LMT_CONF = @as(c_uint, 0x80000000);

pub const NGX_HTTP_POST_READ_PHASE: c_int = 0;
pub const NGX_HTTP_SERVER_REWRITE_PHASE: c_int = 1;
pub const NGX_HTTP_FIND_CONFIG_PHASE: c_int = 2;
pub const NGX_HTTP_REWRITE_PHASE: c_int = 3;
pub const NGX_HTTP_POST_REWRITE_PHASE: c_int = 4;
pub const NGX_HTTP_PREACCESS_PHASE: c_int = 5;
pub const NGX_HTTP_ACCESS_PHASE: c_int = 6;
pub const NGX_HTTP_POST_ACCESS_PHASE: c_int = 7;
pub const NGX_HTTP_PRECONTENT_PHASE: c_int = 8;
pub const NGX_HTTP_CONTENT_PHASE: c_int = 9;
pub const NGX_HTTP_LOG_PHASE: c_int = 10;
pub const ngx_http_phases = c_uint;

pub const NGX_HTTP_MAIN_CONF_OFFSET = @offsetOf(ngx_http_conf_ctx_t, "main_conf");
pub const NGX_HTTP_SRV_CONF_OFFSET = @offsetOf(ngx_http_conf_ctx_t, "srv_conf");
pub const NGX_HTTP_LOC_CONF_OFFSET = @offsetOf(ngx_http_conf_ctx_t, "loc_conf");

pub inline fn ngx_http_get_module_main_conf(r: [*c]ngx_http_request_t, m: ngx_module_t) ?*anyopaque {
    return r.*.main_conf[m.ctx_index];
}

pub inline fn ngx_http_get_module_srv_conf(r: [*c]ngx_http_request_t, m: ngx_module_t) ?*anyopaque {
    return r.*.srv_conf[m.ctx_index];
}

pub inline fn ngx_http_get_module_loc_conf(r: [*c]ngx_http_request_t, m: ngx_module_t) ?*anyopaque {
    return r.*.loc_conf[m.ctx_index];
}

pub inline fn ngx_http_conf_get_module_main_conf(cf: [*c]ngx_conf_t, m: ngx_module_t) ?*anyopaque {
    if (castPtr(ngx_http_conf_ctx_t, cf.*.ctx)) |p| {
        return p.*.main_conf[m.ctx_index];
    }
    return null;
}

pub inline fn ngx_http_conf_get_module_srv_conf(cf: [*c]ngx_conf_t, m: ngx_module_t) ?*anyopaque {
    if (castPtr(ngx_http_conf_ctx_t, cf.*.ctx)) |p| {
        return p.*.srv_conf[m.ctx_index];
    }
    return null;
}

pub inline fn ngx_http_conf_get_module_loc_conf(cf: [*c]ngx_conf_t, m: ngx_module_t) ?*anyopaque {
    if (castPtr(ngx_http_conf_ctx_t, cf.*.ctx)) |p| {
        return p.*.loc_conf[m.ctx_index];
    }
    return null;
}

pub const NGX_LOG_STDERR = @as(c_int, 0);
pub const NGX_LOG_EMERG = @as(c_int, 1);
pub const NGX_LOG_ALERT = @as(c_int, 2);
pub const NGX_LOG_CRIT = @as(c_int, 3);
pub const NGX_LOG_ERR = @as(c_int, 4);
pub const NGX_LOG_WARN = @as(c_int, 5);
pub const NGX_LOG_NOTICE = @as(c_int, 6);
pub const NGX_LOG_INFO = @as(c_int, 7);
pub const NGX_LOG_DEBUG = @as(c_int, 8);

pub const NGX_LOG_DEBUG_CORE = @as(c_int, 0x010);
pub const NGX_LOG_DEBUG_ALLOC = @as(c_int, 0x020);
pub const NGX_LOG_DEBUG_MUTEX = @as(c_int, 0x040);
pub const NGX_LOG_DEBUG_EVENT = @as(c_int, 0x080);
pub const NGX_LOG_DEBUG_HTTP = @as(c_int, 0x100);
pub const NGX_LOG_DEBUG_MAIL = @as(c_int, 0x200);
pub const NGX_LOG_DEBUG_STREAM = @as(c_int, 0x400);
pub const NGX_LOG_DEBUG_FIRST = NGX_LOG_DEBUG_CORE;
pub const NGX_LOG_DEBUG_LAST = NGX_LOG_DEBUG_STREAM;
pub const NGX_LOG_DEBUG_CONNECTION = @as(c_uint, 0x80000000);

pub const NGX_LOG_DEBUG_ALL = @as(c_int, 0x7ffffff0);
pub const NGX_MAX_ERROR_STR = @as(c_int, 2048);

pub fn ngz_log_error(level: ngx_uint_t, log: [*c]ngx_log_t, err: ngx_err_t, fmt: [*c]const u8, args: anytype) void {
    const ArgsType = @TypeOf(args);
    const info = @typeInfo(ArgsType);
    if (info != .Struct) {
        @compileError("expected tuple or struct argument, found " ++ @typeName(ArgsType));
    }
    if (info.Struct.fields.len > 8) {
        @compileError("too many args");
    }
    if (log.*.log_level >= level) {
        switch (info.Struct.fields.len) {
            0 => ngx_log_error_core(level, log, err, fmt),
            1 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0])),
            2 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1])),
            3 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2])),
            4 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3])),
            5 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4])),
            6 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4]), @as(info.Struct.fields[5].type, args[5])),
            7 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4]), @as(info.Struct.fields[5].type, args[5]), @as(info.Struct.fields[6].type, args[6])),
            8 => ngx_log_error_core(level, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4]), @as(info.Struct.fields[5].type, args[5]), @as(info.Struct.fields[6].type, args[6]), @as(info.Struct.fields[7].type, args[7])),
            else => unreachable,
        }
    }
}

pub fn ngz_log_debug(level: ngx_uint_t, log: [*c]ngx_log_t, err: ngx_err_t, fmt: [*c]const u8, args: anytype) void {
    const ArgsType = @TypeOf(args);
    const info = @typeInfo(ArgsType);
    if (info != .Struct) {
        @compileError("expected tuple or struct argument, found " ++ @typeName(ArgsType));
    }
    if (info.Struct.fields.len > 8) {
        @compileError("too many args");
    }
    if (log.*.log_level & level > 0) {
        switch (info.Struct.fields.len) {
            0 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt),
            1 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0])),
            2 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1])),
            3 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2])),
            4 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3])),
            5 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4])),
            6 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4]), @as(info.Struct.fields[5].type, args[5])),
            7 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4]), @as(info.Struct.fields[5].type, args[5]), @as(info.Struct.fields[6].type, args[6])),
            8 => ngx_log_error_core(NGX_LOG_DEBUG, log, err, fmt, @as(info.Struct.fields[0].type, args[0]), @as(info.Struct.fields[1].type, args[1]), @as(info.Struct.fields[2].type, args[2]), @as(info.Struct.fields[3].type, args[3]), @as(info.Struct.fields[4].type, args[4]), @as(info.Struct.fields[5].type, args[5]), @as(info.Struct.fields[6].type, args[6]), @as(info.Struct.fields[7].type, args[7])),
            else => unreachable,
        }
    }
}

test "log" {
    const log = ngx_log_init(@as([*c]u_char, @constCast("")), @as([*c]u_char, @constCast("")));
    try expectEqual(log.*.log_level, NGX_LOG_NOTICE);

    log.*.log_level |= NGX_LOG_DEBUG_CORE;
    ngx_time_init();
    ngz_log_debug(NGX_LOG_DEBUG_HTTP, log, 0, "this never shows", .{});
}

pub const NGX_MODULE_UNSET_INDEX = std.math.maxInt(ngx_uint_t);
pub const NGX_MODULE_SIGNATURE_0 = "8,4,8,";
pub const NGX_MODULE_SIGNATURE_1 = "0";
pub const NGX_MODULE_SIGNATURE_2 = "0";
pub const NGX_MODULE_SIGNATURE_3 = "0";
pub const NGX_MODULE_SIGNATURE_4 = "0";
pub const NGX_MODULE_SIGNATURE_5 = "1";
pub const NGX_MODULE_SIGNATURE_6 = "1";
pub const NGX_MODULE_SIGNATURE_7 = "1";
pub const NGX_MODULE_SIGNATURE_8 = "1";
pub const NGX_MODULE_SIGNATURE_9 = "1";
pub const NGX_MODULE_SIGNATURE_10 = "1";
pub const NGX_MODULE_SIGNATURE_11 = "0";
pub const NGX_MODULE_SIGNATURE_12 = "1";
pub const NGX_MODULE_SIGNATURE_13 = "0";
pub const NGX_MODULE_SIGNATURE_14 = "1";
pub const NGX_MODULE_SIGNATURE_15 = "1";
pub const NGX_MODULE_SIGNATURE_16 = "1";
pub const NGX_MODULE_SIGNATURE_17 = "0";
pub const NGX_MODULE_SIGNATURE_18 = "0";
pub const NGX_MODULE_SIGNATURE_19 = "1";
pub const NGX_MODULE_SIGNATURE_20 = "1";
pub const NGX_MODULE_SIGNATURE_21 = "1";
pub const NGX_MODULE_SIGNATURE_22 = "0";
pub const NGX_MODULE_SIGNATURE_23 = "1";
pub const NGX_MODULE_SIGNATURE_24 = "0";
pub const NGX_MODULE_SIGNATURE_25 = "1";
pub const NGX_MODULE_SIGNATURE_26 = "1";
pub const NGX_MODULE_SIGNATURE_27 = "1";
pub const NGX_MODULE_SIGNATURE_28 = "1";
pub const NGX_MODULE_SIGNATURE_29 = "0";
pub const NGX_MODULE_SIGNATURE_30 = "0";
pub const NGX_MODULE_SIGNATURE_31 = "0";
pub const NGX_MODULE_SIGNATURE_32 = "1";
pub const NGX_MODULE_SIGNATURE_33 = "1";
pub const NGX_MODULE_SIGNATURE_34 = "0";
pub const NGX_MODULE_SIGNATURE = NGX_MODULE_SIGNATURE_0 ++ NGX_MODULE_SIGNATURE_1 ++ NGX_MODULE_SIGNATURE_2 ++ NGX_MODULE_SIGNATURE_3 ++ NGX_MODULE_SIGNATURE_4 ++ NGX_MODULE_SIGNATURE_5 ++ NGX_MODULE_SIGNATURE_6 ++ NGX_MODULE_SIGNATURE_7 ++ NGX_MODULE_SIGNATURE_8 ++ NGX_MODULE_SIGNATURE_9 ++ NGX_MODULE_SIGNATURE_10 ++ NGX_MODULE_SIGNATURE_11 ++ NGX_MODULE_SIGNATURE_12 ++ NGX_MODULE_SIGNATURE_13 ++ NGX_MODULE_SIGNATURE_14 ++ NGX_MODULE_SIGNATURE_15 ++ NGX_MODULE_SIGNATURE_16 ++ NGX_MODULE_SIGNATURE_17 ++ NGX_MODULE_SIGNATURE_18 ++ NGX_MODULE_SIGNATURE_19 ++ NGX_MODULE_SIGNATURE_20 ++ NGX_MODULE_SIGNATURE_21 ++ NGX_MODULE_SIGNATURE_22 ++ NGX_MODULE_SIGNATURE_23 ++ NGX_MODULE_SIGNATURE_24 ++ NGX_MODULE_SIGNATURE_25 ++ NGX_MODULE_SIGNATURE_26 ++ NGX_MODULE_SIGNATURE_27 ++ NGX_MODULE_SIGNATURE_28 ++ NGX_MODULE_SIGNATURE_29 ++ NGX_MODULE_SIGNATURE_30 ++ NGX_MODULE_SIGNATURE_31 ++ NGX_MODULE_SIGNATURE_32 ++ NGX_MODULE_SIGNATURE_33 ++ NGX_MODULE_SIGNATURE_34;

pub inline fn make_module() ngx_module_t {
    var m = ngx_module_t{};
    m.ctx_index = NGX_MODULE_UNSET_INDEX;
    m.index = NGX_MODULE_UNSET_INDEX;
    m.version = nginx_version;
    m.signature = NGX_MODULE_SIGNATURE;

    return m;
}

test "module" {
    const m = make_module();
    try expectEqual(m.ctx_index, NGX_MODULE_UNSET_INDEX);

    const len = std.zig.c_translation.sizeof(NGX_MODULE_SIGNATURE) - 1;
    const slice = make_slice(@constCast(m.signature), len);
    try expectEqual(slice.len, 40);
}

pub inline fn ngx_queue_init(q: [*c]ngx_queue_t) void {
    q.*.prev = q;
    q.*.next = q;
}

pub inline fn ngx_queue_empty(q: [*c]ngx_queue_t) bool {
    return q == q.*.prev;
}

pub inline fn ngx_queue_head(h: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return h.*.next;
}

pub inline fn ngx_queue_next(q: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return q.*.next;
}

pub inline fn ngx_queue_last(h: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return h.*.prev;
}

pub inline fn ngx_queue_prev(q: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return q.*.prev;
}

pub inline fn ngx_queue_remove(x: [*c]ngx_queue_t) void {
    x.*.next.*.prev = x.*.prev;
    x.*.prev.*.next = x.*.next;
    x.*.prev = NULL;
    x.*.next = NULL;
}

pub inline fn ngx_queue_sentinel(q: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return q;
}

pub inline fn ngx_queue_insert_head(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
    x.*.next = h.*.next;
    x.*.next.*.prev = x;
    x.*.prev = h;
    h.*.next = x;
}

pub inline fn ngx_queue_insert_after(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
    ngx_queue_insert_head(h, x);
}

pub inline fn ngx_queue_insert_tail(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
    x.*.prev = h.*.prev;
    x.*.prev.*.next = x;
    x.*.next = h;
    h.*.prev = x;
}

pub inline fn ngx_queue_insert_before(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
    ngx_queue_insert_tail(h, x);
}

pub inline fn ngx_queue_split(h: [*c]ngx_queue_t, q: [*c]ngx_queue_t, n: [*c]ngx_queue_t) void {
    n.*.prev = h.*.prev;
    n.*.prev.*.next = n;
    n.*.next = q;
    h.*.prev = q.*.prev;
    h.*.prev.*.next = h;
    q.*.prev = n;
}

pub inline fn ngx_queue_add(h: [*c]ngx_queue_t, n: [*c]ngx_queue_t) void {
    h.*.prev.*.next = n.*.next;
    n.*.next.*.prev = h.*.prev;
    h.*.prev = n.*.prev;
    h.*.prev.*.next = h;
}

pub inline fn ngz_queue_data(comptime T: type, comptime field: []const u8, q: [*c]ngx_queue_t) [*c]T {
    return @as([*c]T, @ptrCast(@as([*c]u8, @ptrCast(q)) - @offsetOf(T, field)));
}

pub inline fn ngx_rbtree_init(tree: [*c]ngx_rbtree_t, s: [*c]ngx_rbtree_node_t, i: ngx_rbtree_insert_pt) void {
    ngx_rbtree_sentinel_init(s);
    tree.*.root = s;
    tree.*.sentinel = s;
    tree.*.insert = i;
}

pub inline fn ngz_rbtree_data(comptime T: type, comptime field: []const u8, n: [*c]ngx_rbtree_node_t) [*c]T {
    return @as([*c]T, @ptrCast(@as([*c]u8, @ptrCast(n)) - @offsetOf(T, field)));
}

pub inline fn ngx_rbt_red(node: [*c]ngx_rbtree_node_t) void {
    node.*.color = 1;
}

pub inline fn ngx_rbt_black(node: [*c]ngx_rbtree_node_t) void {
    node.*.color = 0;
}

pub inline fn ngx_rbt_is_red(node: [*c]ngx_rbtree_node_t) bool {
    return node.*.color == 1;
}

pub inline fn ngx_rbt_is_black(node: [*c]ngx_rbtree_node_t) bool {
    return node.*.color == 0;
}

pub inline fn ngx_rbt_copy_color(n1: [*c]ngx_rbtree_node_t, n2: [*c]ngx_rbtree_node_t) void {
    n1.*.color = n2.*.color;
}

pub inline fn ngx_rbtree_sentinel_init(node: [*c]ngx_rbtree_node_t) void {
    ngx_rbt_black(node);
}

pub inline fn ngx_rbtree_min(node: [*c]ngx_rbtree_node_t, sentinel: [*c]ngx_rbtree_node_t) [*c]ngx_rbtree_node_t {
    var n: [*c]ngx_rbtree_node_t = node;
    while (n.*.left != sentinel) {
        n = n.*.left;
    }
    return n;
}
