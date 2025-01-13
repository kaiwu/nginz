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
pub const ngx_http_module_t = ngx.ngx_http_module_t;

pub const off_t = ngx.off_t;
pub const u_char = ngx.u_char;
pub const ngx_dir_t = ngx.ngx_dir_t;
pub const ngx_process_t = ngx.ngx_process_t;

pub const ngx_err_t = ngx.ngx_err_t;
pub const ngx_str_t = ngx.ngx_str_t;
pub const ngx_log_t = ngx.ngx_log_t;
pub const ngx_int_t = ngx.ngx_int_t;
pub const ngx_flag_t = ngx.ngx_flag_t;
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
pub const ngx_rbtree_key_t = ngx.ngx_rbtree_key_t;
pub const ngx_rbtree_node_t = ngx.ngx_rbtree_node_t;
pub const ngx_module_t = ngx.ngx_module_t;
pub const ngx_command_t = ngx.ngx_command_t;
pub const ngx_chain_t = ngx.ngx_chain_t;

pub const NULL = ngx.NULL;
pub const ngx_palloc = ngx.ngx_palloc;
pub const ngx_pcalloc = ngx.ngx_pcalloc;
pub const ngx_pmemalign = ngx.ngx_pmemalign;
pub const ngx_pfree = ngx.ngx_pfree;
pub const ngx_log_error_core = ngx.ngx_log_error_core;
pub const ngx_log_init = ngx.ngx_log_init;
pub const ngx_time_init = ngx.ngx_time_init;
pub const ngx_rbtree_insert_pt = ngx.ngx_rbtree_insert_pt;

pub inline fn sizeof(comptime s: []const u8) usize {
    return s.len;
}

pub inline fn c_str(s: []const u8) [*c]u_char {
    return @constCast(s.ptr);
}

pub inline fn ngx_align(d: ngx_uint_t, comptime a: ngx_uint_t) ngx_uint_t {
    if (a < 1) {
        @compileError("cannot align to 0");
    }
    return (d + (a - 1)) & ~(a - 1);
}

pub inline fn nullptr(comptime T: type) [*c]T {
    return @as([*c]T, @alignCast(@ptrCast(NULL)));
}

pub inline fn slicify(comptime T: type, p: [*c]T, len: usize) []T {
    return p[0..len];
}

pub inline fn make_slice(p: [*c]u8, len: usize) []u8 {
    return slicify(u8, p, len);
}

pub inline fn nonNullPtr(comptime T: type, p: [*c]T) ?[*c]T {
    return if (p != @as([*c]T, @alignCast(@ptrCast(NULL)))) p else null;
}

pub inline fn castPtr(comptime T: type, p: ?*anyopaque) ?[*c]T {
    const p0 = @as([*c]T, @alignCast(@ptrCast(p)));
    if (nonNullPtr(T, p0)) |_| {
        return p0;
    }
    return null;
}

pub inline fn ngz_pcalloc_c(comptime T: type, p: [*c]ngx_pool_t) ?[*c]T {
    if (ngx_pcalloc(p, @sizeOf(T))) |p0| {
        return @alignCast(@ptrCast(p0));
    }
    return null;
}

pub inline fn ngz_pcalloc(comptime T: type, p: [*c]ngx_pool_t) ?*T {
    if (ngx_pcalloc(p, @sizeOf(T))) |p0| {
        return @alignCast(@ptrCast(p0));
    }
    return null;
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
    return ngx_str_t{ .len = str.len, .data = @constCast(str.ptr) };
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

// http{}
pub inline fn ngx_http_get_module_main_conf(r: [*c]ngx_http_request_t, m: *ngx_module_t) ?*anyopaque {
    return r.*.main_conf[m.ctx_index];
}

// server{}
pub inline fn ngx_http_get_module_srv_conf(r: [*c]ngx_http_request_t, m: *ngx_module_t) ?*anyopaque {
    return r.*.srv_conf[m.ctx_index];
}

// loc{}
pub inline fn ngx_http_get_module_loc_conf(r: [*c]ngx_http_request_t, m: *ngx_module_t) ?*anyopaque {
    return r.*.loc_conf[m.ctx_index];
}

// http{}
pub inline fn ngx_http_conf_get_module_main_conf(cf: [*c]ngx_conf_t, m: *ngx_module_t) ?*anyopaque {
    if (castPtr(ngx_http_conf_ctx_t, cf.*.ctx)) |p| {
        return p.*.main_conf[m.ctx_index];
    }
    return null;
}

// http{}
pub inline fn ngx_http_conf_get_module_srv_conf(cf: [*c]ngx_conf_t, m: *ngx_module_t) ?*anyopaque {
    if (castPtr(ngx_http_conf_ctx_t, cf.*.ctx)) |p| {
        return p.*.srv_conf[m.ctx_index];
    }
    return null;
}

// http{}
pub inline fn ngx_http_conf_get_module_loc_conf(cf: [*c]ngx_conf_t, m: *ngx_module_t) ?*anyopaque {
    if (castPtr(ngx_http_conf_ctx_t, cf.*.ctx)) |p| {
        return p.*.loc_conf[m.ctx_index];
    }
    return null;
}

pub const NError = error{
    OOM,
    HASH_ERROR,
};

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

pub const NGX_CONF_UNSET = ngx.NGX_CONF_UNSET;
pub const NGX_CONF_UNSET_UINT = ngx.NGX_CONF_UNSET_UINT;
pub const NGX_CONF_UNSET_PTR = ngx.NGX_CONF_UNSET_PTR;
pub const NGX_CONF_UNSET_SIZE = ngx.NGX_CONF_UNSET_SIZE;
pub const NGX_CONF_UNSET_MSEC = ngx.NGX_CONF_UNSET_MSEC;

pub const NGX_CONF_NOARGS = ngx.NGX_CONF_NOARGS;
pub const NGX_CONF_TAKE1 = ngx.NGX_CONF_TAKE1;
pub const NGX_CONF_TAKE2 = ngx.NGX_CONF_TAKE2;
pub const NGX_CONF_TAKE3 = ngx.NGX_CONF_TAKE3;
pub const NGX_CONF_TAKE4 = ngx.NGX_CONF_TAKE4;
pub const NGX_CONF_TAKE5 = ngx.NGX_CONF_TAKE5;
pub const NGX_CONF_TAKE6 = ngx.NGX_CONF_TAKE6;
pub const NGX_CONF_TAKE7 = ngx.NGX_CONF_TAKE7;
pub const NGX_CONF_TAKE12 = ngx.NGX_CONF_TAKE12;
pub const NGX_CONF_TAKE13 = ngx.NGX_CONF_TAKE13;
pub const NGX_CONF_TAKE23 = ngx.NGX_CONF_TAKE23;
pub const NGX_CONF_TAKE123 = ngx.NGX_CONF_TAKE123;
pub const NGX_CONF_TAKE1234 = ngx.NGX_CONF_TAKE1234;

pub const NGX_CONF_BLOCK = ngx.NGX_CONF_BLOCK;
pub const NGX_CONF_FLAG = ngx.NGX_CONF_FLAG;
pub const NGX_CONF_ANY = ngx.NGX_CONF_ANY;
pub const NGX_CONF_1MORE = ngx.NGX_CONF_1MORE;
pub const NGX_CONF_2MORE = ngx.NGX_CONF_2MORE;

pub const NGX_CONF_OK = @as([*c]u8, @ptrCast(ngx.NGX_CONF_OK));
pub const NGX_CONF_ERROR = @as([*c]u8, @ptrCast(ngx.NGX_CONF_ERROR));

pub const ngx_conf_set_flag_slot = ngx.ngx_conf_set_flag_slot;
pub const ngx_conf_set_str_slot = ngx.ngx_conf_set_str_slot;
pub const ngx_conf_set_str_array_slot = ngx.ngx_conf_set_str_array_slot;
pub const ngx_conf_set_keyval_slot = ngx.ngx_conf_set_keyval_slot;
pub const ngx_conf_set_num_slot = ngx.ngx_conf_set_num_slot;
pub const ngx_conf_set_size_slot = ngx.ngx_conf_set_size_slot;
pub const ngx_conf_set_off_slot = ngx.ngx_conf_set_off_slot;
pub const ngx_conf_set_msec_slot = ngx.ngx_conf_set_msec_slot;
pub const ngx_conf_set_sec_slot = ngx.ngx_conf_set_sec_slot;
pub const ngx_conf_set_bufs_slot = ngx.ngx_conf_set_bufs_slot;
pub const ngx_conf_set_enum_slot = ngx.ngx_conf_set_enum_slot;
pub const ngx_conf_set_bitmask_slot = ngx.ngx_conf_set_bitmask_slot;

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
pub const NGX_MODULE_SIGNATURE_24 = "1";
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
    try expectEqual(@sizeOf(ngx_http_module_t), 64);

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

pub inline fn ngx_http_conf_debug(cf: [*c]ngx_conf_t, fmt: [*c]const u8, args: anytype) void {
    cf.*.log.*.log_level |= NGX_LOG_DEBUG_HTTP;
    ngz_log_debug(NGX_LOG_DEBUG_HTTP, cf.*.log, 0, fmt, args);
}

test "log" {
    const log = ngx_log_init(c_str(""), c_str(""));
    try expectEqual(log.*.log_level, NGX_LOG_NOTICE);

    log.*.log_level |= NGX_LOG_DEBUG_CORE;
    ngx_time_init();
    ngz_log_debug(NGX_LOG_DEBUG_HTTP, log, 0, "this never shows", .{});
}

pub inline fn make_module(cmds: [*c]ngx_command_t, ctx: ?*anyopaque) ngx_module_t {
    return ngx_module_t{
        .ctx_index = NGX_MODULE_UNSET_INDEX,
        .index = NGX_MODULE_UNSET_INDEX,
        .name = @ptrCast(NULL),
        .signature = NGX_MODULE_SIGNATURE,
        .spare0 = 0,
        .spare1 = 0,
        .version = nginx_version,
        .ctx = ctx,
        .commands = cmds,
        .type = NGX_HTTP_MODULE,
        .init_master = @ptrCast(NULL),
        .init_module = @ptrCast(NULL),
        .init_process = @ptrCast(NULL),
        .init_thread = @ptrCast(NULL),
        .exit_thread = @ptrCast(NULL),
        .exit_process = @ptrCast(NULL),
        .exit_master = @ptrCast(NULL),
        .spare_hook0 = 0,
        .spare_hook1 = 0,
        .spare_hook2 = 0,
        .spare_hook3 = 0,
        .spare_hook4 = 0,
        .spare_hook5 = 0,
        .spare_hook6 = 0,
        .spare_hook7 = 0,
    };
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

pub inline fn ngx_queue_tail(h: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return h.*.prev;
}

pub inline fn ngx_queue_next(q: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return q.*.next;
}

pub inline fn ngx_queue_prev(q: [*c]ngx_queue_t) [*c]ngx_queue_t {
    return q.*.prev;
}

pub inline fn ngx_queue_remove(x: [*c]ngx_queue_t) void {
    x.*.next.*.prev = x.*.prev;
    x.*.prev.*.next = x.*.next;
    x.*.prev = x;
    x.*.next = x;
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

pub inline fn ngx_queue_insert_before(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
    ngx_queue_insert_head(h, x);
}

pub inline fn ngx_queue_insert_tail(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
    x.*.prev = h.*.prev;
    x.*.prev.*.next = x;
    x.*.next = h;
    h.*.prev = x;
}

pub inline fn ngx_queue_insert_after(h: [*c]ngx_queue_t, x: [*c]ngx_queue_t) void {
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
    return @as(
        [*c]T,
        @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(q))) - @offsetOf(T, field))),
    );
}

// ngx_queue_init(s)
// n = ngx_queue_next(s)
pub fn ngz_queue_next(comptime T: type, comptime field: []const u8, s: [*c]ngx_queue_t, n: *[*c]ngx_queue_t) ?[*c]T {
    if (n.* != s) {
        defer n.* = ngx_queue_next(n.*);
        return ngz_queue_data(T, field, n.*);
    }
    return null;
}

pub fn NQueue(comptime T: type, comptime field: []const u8) type {
    const OFFSET = @offsetOf(T, field);

    const Iterator = struct {
        const Self = @This();

        q: [*c]ngx_queue_t,
        n: [*c]ngx_queue_t,

        pub fn next(self: *Self) ?[*c]T {
            if (self.n == self.q) {
                return null;
            }
            defer self.n = ngx_queue_next(self.n);
            return @as(
                [*c]T,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(self.n))) - OFFSET)),
            );
        }
    };

    const ReverseIterator = struct {
        const Self = @This();

        q: [*c]ngx_queue_t,
        n: [*c]ngx_queue_t,

        pub fn next(self: *Self) ?[*c]T {
            if (self.n == self.q) {
                return null;
            }
            defer self.n = ngx_queue_prev(self.n);
            return @as(
                [*c]T,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(self.n))) - OFFSET)),
            );
        }
    };

    return extern struct {
        const Self = @This();
        sentinel: [*c]ngx_queue_t,
        len: ngx_uint_t = 0,

        pub inline fn queue(pt: [*c]T) [*c]ngx_queue_t {
            return @as(
                [*c]ngx_queue_t,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(pt))) + OFFSET)),
            );
        }

        pub inline fn data(q: [*c]ngx_queue_t) [*c]T {
            return @as(
                [*c]T,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(q))) - OFFSET)),
            );
        }

        pub fn init(s: [*c]ngx_queue_t) Self {
            ngx_queue_init(s);
            return Self{ .sentinel = s };
        }

        pub fn iterator(self: *Self) Iterator {
            return Iterator{ .q = self.sentinel, .n = ngx_queue_next(self.sentinel) };
        }

        pub fn reverse_iterator(self: *Self) ReverseIterator {
            return Iterator{ .q = self.sentinel, .n = ngx_queue_prev(self.sentinel) };
        }

        pub fn size(self: *Self) ngx_uint_t {
            return self.len;
        }

        pub fn at(self: *Self, i: ngx_uint_t) ?[*c]T {
            if (i < self.len) {
                var n: [*c]ngx_queue_t = ngx_queue_head(self.sentinel);
                for (0..i) |_| {
                    n = n.*.next;
                }
                return data(n);
            }
            return null;
        }

        pub fn head(self: *Self) [*c]T {
            return data(ngx_queue_head(self.sentinel));
        }

        pub fn tail(self: *Self) [*c]T {
            return data(ngx_queue_tail(self.sentinel));
        }

        pub fn insert_before(self: *Self, q0: [*c]ngx_queue_t, pt1: [*c]T) void {
            defer self.len += 1;
            const q1 = queue(pt1);
            ngx_queue_insert_before(q0, q1);
        }

        pub fn insert_after(self: *Self, q0: [*c]ngx_queue_t, pt1: [*c]T) void {
            defer self.len += 1;
            const q1 = queue(pt1);
            ngx_queue_insert_after(q0, q1);
        }

        pub fn insert_head(self: *Self, pt: [*c]T) void {
            insert_before(self, self.sentinel, pt);
        }

        pub fn insert_tail(self: *Self, pt: [*c]T) void {
            insert_after(self, self.sentinel, pt);
        }

        pub fn remove(self: *Self, pt: [*c]T) void {
            if (!empty(self)) {
                defer self.len -= 1;
                const q = queue(pt);
                ngx_queue_remove(q);
            }
        }

        pub fn empty(self: *Self) bool {
            return ngx_queue_empty(self.sentinel);
        }
    };
}

test "queue" {
    const QT = extern struct {
        n: ngx_uint_t,
        q: ngx_queue_t = undefined,
    };

    var qt: ngx_queue_t = undefined;
    var q0 = NQueue(QT, "q").init(@ptrCast(&qt));
    try expectEqual(q0.size(), 0);

    var q4 = [_]QT{
        QT{ .n = 0 },
        QT{ .n = 1 },
        QT{ .n = 2 },
        QT{ .n = 3 },
        QT{ .n = 4 },
    };
    for (&q4) |*qx| {
        // ngx_queue_init(&qx.q);
        q0.insert_tail(qx);
    }

    try expectEqual(q0.at(3).?.*.n, 3);
    var it = q0.iterator();
    var total: ngx_uint_t = 0;
    while (it.next()) |_| {
        total += 1;
    }
    try expectEqual(q0.size(), total);
    try expectEqual(q0.at(total), null);
}

pub inline fn ngx_rbtree_init(tree: [*c]ngx_rbtree_t, s: [*c]ngx_rbtree_node_t, i: ngx_rbtree_insert_pt) void {
    ngx_rbtree_sentinel_init(s);
    tree.*.root = s;
    tree.*.sentinel = s;
    tree.*.insert = i;
}

pub inline fn ngz_rbtree_data(comptime T: type, comptime field: []const u8, n: [*c]ngx_rbtree_node_t) [*c]T {
    return @as(
        [*c]T,
        @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(n))) - @offsetOf(T, field))),
    );
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

const ngx_rbtree_insert = ngx.ngx_rbtree_insert;
const ngx_rbtree_delete = ngx.ngx_rbtree_delete;
pub fn NRBTree(
    comptime T: type,
    comptime field: []const u8,
    comptime Context: anytype,
    comptime KeyFn: fn (Context, [*c]T) ngx_rbtree_key_t,
) type {
    const OFFSET = @offsetOf(T, field);
    const Node = ngx_rbtree_node_t;
    const Tree = struct {
        pub fn isRoot(n: [*c]Node) bool {
            return n.*.parent == nullptr(Node);
        }
        pub fn isLeft(n: [*c]Node) bool {
            return !isRoot(n) and n.*.parent.*.left == n;
        }
        pub fn isRight(n: [*c]Node) bool {
            return !isRoot(n) and n.*.parent.*.right == n;
        }
        pub fn isLeaf(n: [*c]Node, s: [*c]Node) bool {
            return n.*.left == s and n.*.right == s;
        }
        pub fn sibling(n: [*c]Node) [*c]Node {
            if (isRoot(n)) {
                // unreachable;
                return nullptr(Node);
            }
            return if (isLeft(n)) n.*.parent.*.right else n.*.parent.*.left;
        }
        pub fn downLeft(n: [*c]Node, s: [*c]Node) [*c]Node {
            if (n.*.left != s) {
                return downLeft(n.*.left, s);
            }
            return n;
        }
        pub fn downBottom(n: [*c]Node, s: [*c]Node) [*c]Node {
            if (n.*.left != s) {
                return downBottom(n.*.left, s);
            }
            if (n.*.right != s) {
                return downBottom(n.*.right, s);
            }
            return n;
        }
        pub fn upRight(n: [*c]Node, s: [*c]Node) [*c]Node {
            if (isRoot(n)) {
                return nullptr(Node);
            }
            if (isLeft(n)) {
                const r = sibling(n);
                if (r != s) {
                    return r;
                }
            }
            return upRight(n.*.parent, s);
        }
        pub fn upLeft(n: [*c]Node) [*c]Node {
            if (isRoot(n)) {
                return nullptr(Node);
            }
            return if (isLeft(n)) n.*.parent else upLeft(n.*.parent);
        }

        pub fn depth(n: [*c]Node, s: [*c]Node, d: ngx_uint_t) ngx_uint_t {
            if (n == s) {
                return d;
            }
            return @max(depth(n.*.left, s, d + 1), depth(n.*.right, s, d + 1));
        }

        fn insertFn(parent: [*c]Node, n: [*c]Node, sentinel: [*c]Node) callconv(.C) void {
            var pp: *[*c]Node = @constCast(&parent);
            var p: [*c]Node = parent;
            while (pp.* != sentinel) {
                p = pp.*;
                pp = if (n.*.key < p.*.key) &p.*.left else &p.*.right;
            }
            pp.* = n;
            n.*.parent = p;
            n.*.left = sentinel;
            n.*.right = sentinel;
            ngx_rbt_red(n);
        }
    };

    const TraverseOrder = enum(u8) {
        PreOrder,
        InOrder,
        PostOrder,
    };

    const LookupIterator = struct {
        const Self = @This();
        key: ngx_rbtree_key_t,
        tree: [*c]ngx_rbtree_t,
        node: [*c]ngx_rbtree_node_t,

        pub fn next(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            it.node = nullptr(Node);
            if (x.*.left != it.tree.*.sentinel and x.*.left.*.key == it.key) {
                it.node = x.*.left;
            }
            if (x.*.right != it.tree.*.sentinel and x.*.right.*.key == it.key) {
                it.node = x.*.right;
            }

            return x;
        }
    };

    const Iterator = struct {
        const Self = @This();
        order: TraverseOrder,
        tree: [*c]ngx_rbtree_t,
        node: [*c]ngx_rbtree_node_t,

        fn nextPre(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            if (x.*.left != it.tree.*.sentinel) {
                it.node = x.*.left;
            }
            if (x.*.left == it.tree.*.sentinel) {
                if (x.*.right != it.tree.*.sentinel) {
                    it.node = x.*.right;
                } else {
                    it.node = Tree.upRight(x, it.tree.*.sentinel);
                }
            }
            return x;
        }

        fn nextIn(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            if (x.*.right != it.tree.*.sentinel) {
                it.node = Tree.downLeft(x.*.right, it.tree.*.sentinel);
            } else {
                it.node = Tree.upLeft(x);
            }
            return x;
        }

        fn nextPost(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            it.node = x.*.parent;

            if (Tree.isLeft(x)) {
                const s = Tree.sibling(x);
                if (s != it.tree.*.sentinel) {
                    it.node = Tree.downBottom(s, it.tree.*.sentinel);
                }
            }
            return x;
        }

        fn next(it: *Self) ?[*c]Node {
            return switch (it.order) {
                .PreOrder => nextPre(it),
                .InOrder => nextIn(it),
                .PostOrder => nextPost(it),
            };
        }
    };

    return extern struct {
        const Self = @This();
        const TraverseOrderType = TraverseOrder;

        tree: [*c]ngx_rbtree_t,

        pub inline fn node(pt: [*c]T) [*c]Node {
            return @as(
                [*c]Node,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(pt))) + OFFSET)),
            );
        }

        pub inline fn data(n: [*c]Node) [*c]T {
            return @as(
                [*c]T,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(n))) - OFFSET)),
            );
        }

        pub fn init(
            t: [*c]ngx_rbtree_t,
            p: [*c]ngx_pool_t,
            pt: ?ngx_rbtree_insert_pt,
        ) !Self {
            if (ngz_pcalloc_c(Node, p)) |sentinel| {
                const pt0 = pt orelse &Tree.insertFn;
                ngx_rbtree_init(t, sentinel, pt0);
                return Self{ .tree = t };
            }
            return NError.OOM;
        }

        pub fn lookup(self: *Self, key: ngx_rbtree_key_t) LookupIterator {
            var it = LookupIterator{
                .key = key,
                .node = nullptr(Node),
                .tree = self.*.tree,
            };
            var p: [*c]Node = self.tree.*.root;
            while (p != self.tree.*.sentinel) {
                if (p.*.key == it.key) {
                    it.node = p;
                    break;
                }
                p = if (it.key < p.*.key) p.*.left else p.*.right;
            }
            return it;
        }

        pub fn depth(self: *Self) ngx_uint_t {
            return Tree.depth(self.tree.*.root, self.tree.*.sentinel, 0);
        }

        pub fn iterator(self: *Self, order: TraverseOrderType) Iterator {
            var it = Iterator{
                .tree = self.tree,
                .node = self.tree.*.root,
                .order = order,
            };

            if (it.node == self.tree.*.sentinel) { //empty tree
                it.node = nullptr(Node);
                return it;
            }

            if (order == .InOrder) {
                it.node = Tree.downLeft(self.tree.*.root, self.tree.*.sentinel);
            }
            if (order == .PostOrder) {
                it.node = Tree.downBottom(self.tree.*.root, self.tree.*.sentinel);
            }
            return it;
        }

        pub fn insert(self: *Self, pt: [*c]T, ctx: Context) void {
            const n = node(pt);
            n.*.key = KeyFn(ctx, pt);
            ngx_rbtree_insert(self.tree, n);
        }

        pub fn delete(self: *Self, pt: [*c]T) void {
            const n = node(pt);
            ngx_rbtree_delete(self.tree, n);
        }
    };
}

test "rbtree" {
    const RBT = extern struct {
        const Self = @This();
        c: u8,
        n: ngx_uint_t,
        node: ngx_rbtree_node_t = undefined,

        pub fn key(ctx: void, p: [*c]Self) ngx_rbtree_key_t {
            _ = ctx;
            return p.*.n;
        }
    };

    var rs = [_]RBT{
        RBT{ .n = 0, .c = 'E' },
        RBT{ .n = 1, .c = 'X' },
        RBT{ .n = 2, .c = 'M' },
        RBT{ .n = 3, .c = 'B' },
        RBT{ .n = 4, .c = 'S' },
        RBT{ .n = 5, .c = 'A' },
        RBT{ .n = 6, .c = 'P' },
        RBT{ .n = 7, .c = 'T' },
        RBT{ .n = 8, .c = 'N' },
        RBT{ .n = 9, .c = 'W' },
        RBT{ .n = 10, .c = 'H' },
        RBT{ .n = 11, .c = 'C' },
    };

    const log = ngx_log_init(c_str(""), c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    const RBTree = NRBTree(RBT, "node", void, RBT.key);
    var t: ngx_rbtree_t = undefined;
    var tree = try RBTree.init(@ptrCast(&t), pool, null);
    for (&rs) |*r0| {
        tree.insert(r0, {});
    }
    try expectEqual(tree.depth(), 5);

    var it = tree.iterator(RBTree.TraverseOrderType.PostOrder);
    while (it.next()) |n| {
        const r0 = RBTree.data(n);
        std.debug.print("{c} ", .{r0.*.c});
    }
}

pub fn PointerIterator(comptime T: type) type {
    return struct {
        const Self = @This();
        p: [*:0]T,
        i: usize = 0,

        pub fn init(p: [*c]T) Self {
            return Self{
                .p = @ptrCast(p),
            };
        }

        pub fn next(self: *Self) ?T {
            defer self.i += 1;
            return if (self.p[self.i] != 0) self.p[self.i] else null;
        }
    };
}

const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;
const ngx_array_create = ngx.ngx_array_create;
const ngx_array_destroy = ngx.ngx_array_destroy;
const ngx_array_push = ngx.ngx_array_push;

pub fn ngx_array_next(comptime T: type, a: [*c]ngx_array_t, i: *ngx_uint_t) ?[*c]T {
    if (i.* < a.*.nelts) {
        if (castPtr(T, a.*.elts)) |p| {
            defer i.* += 1;
            return p + i.*;
        }
    }
    return null;
}

pub fn NArray(comptime T: type) type {
    if (@alignOf(T) != NGX_ALIGNMENT) {
        @compileError("NArray invalid element");
    }

    const Iterator = struct {
        const Self = @This();

        pa: [*c]ngx_array_t,
        offset: ngx_uint_t = 0,

        pub fn next(self: *Self) ?[*c]T {
            if (self.offset >= self.pa.*.nelts) {
                return null;
            }
            if (castPtr(T, self.pa.*.elts)) |p0| {
                defer self.offset += 1;
                return p0 + self.offset;
            }
            return null;
        }
    };

    return extern struct {
        const Self = @This();
        pa: [*c]ngx_array_t = undefined,

        pub fn init(p: [*c]ngx_pool_t, n: ngx_uint_t) !Self {
            if (nonNullPtr(ngx_array_t, ngx_array_create(p, n, @sizeOf(T)))) |p0| {
                return Self{ .pa = p0 };
            }
            return NError.OOM;
        }

        pub fn size(self: *Self) ngx_uint_t {
            return self.pa.*.nelts;
        }

        pub fn iterator(self: *Self) Iterator {
            return Iterator{ .pa = self.pa };
        }

        pub fn at(self: *Self, i: ngx_uint_t) ?[*c]T {
            if (i < self.pa.*.nelts) {
                if (castPtr(T, self.pa.*.elts)) |p0| {
                    return p0 + i;
                }
            }
            return null;
        }

        pub fn slice(self: *Self) []T {
            if (castPtr(T, self.pa.*.elts)) |p0| {
                return slicify(T, p0, self.pa.*.nelts);
            }
            unreachable;
        }

        pub fn deinit(self: *Self) void {
            ngx_array_destroy(self.pa);
        }

        pub fn append(self: *Self, t: T) !void {
            if (castPtr(T, ngx_array_push(self.pa))) |p0| {
                p0.* = t;
            } else {
                return NError.OOM;
            }
        }
    };
}

test "array" {
    const log = ngx_log_init(c_str(""), c_str(""));
    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    var ns = try NArray(ngx_uint_t).init(pool, 10);
    defer ns.deinit();

    try expectEqual(ns.pa.*.size, @sizeOf(ngx_uint_t));
    try expectEqual(ns.size(), 0);
    try expectEqual(ns.pa.*.nalloc, 10);

    for (0..20) |i| {
        try ns.append(i);
    }
    try expectEqual(ns.at(10).?.*, 10);
    try expectEqual(ns.at(20), null);
    try expectEqual(ns.size(), 20);
}

const ngx_list_part_t = ngx.ngx_list_part_t;
const ngx_list_create = ngx.ngx_list_create;
const ngx_list_push = ngx.ngx_list_push;

pub fn NList(comptime T: type) type {
    if (@alignOf(T) != NGX_ALIGNMENT) {
        @compileError("NList invalid element");
    }

    const Iterator = struct {
        const Self = @This();

        pl: [*c]ngx_list_t,
        last: [*c]ngx_list_part_t,
        offset: ngx_uint_t = 0,

        pub fn next(self: *Self) ?[*c]T {
            if (self.offset >= self.last.*.nelts) {
                return null;
            }
            if (castPtr(T, self.last.*.elts)) |p0| {
                const pt = p0 + self.offset;
                self.offset += 1;
                if (self.offset >= self.last.*.nelts and self.last != self.pl.*.last) {
                    self.last = self.last.*.next;
                    self.offset = 0;
                }
                return pt;
            }
            return null;
        }

        pub fn nextSlice(self: *Self) ?[]T {
            if (self.last == self.pl.*.last and self.offset == self.last.*.nelts) {
                return null;
            }
            if (castPtr(T, self.last.*.elts)) |p0| {
                const s = slicify(T, p0, self.last.*.nelts);
                if (self.last != self.pl.*.last) {
                    self.last = self.last.*.next;
                } else {
                    self.offset = self.last.*.nelts;
                }
                return s;
            }
            return null;
        }
    };

    return extern struct {
        const Self = @This();
        pl: [*c]ngx_list_t = undefined,
        len: ngx_uint_t = 0,

        pub fn init(p: [*c]ngx_pool_t, n: ngx_uint_t) !Self {
            if (nonNullPtr(ngx_list_t, ngx_list_create(p, n, @sizeOf(T)))) |p0| {
                return Self{ .pl = p0 };
            }
            return NError.OOM;
        }

        pub fn size(self: *Self) ngx_uint_t {
            return self.len;
        }

        pub fn at(self: *Self, i: ngx_uint_t) ?[*c]T {
            if (i < self.len) {
                const n = i / self.pl.*.nalloc;
                const m = i % self.pl.*.nalloc;
                var part: [*c]ngx_list_part_t = @ptrCast(&self.pl.*.part);
                for (0..n) |_| {
                    part = part.*.next;
                }
                if (castPtr(T, part.*.elts)) |p0| {
                    return p0 + m;
                }
            }
            return null;
        }

        pub fn iterator(self: *Self) Iterator {
            return Iterator{ .pl = self.pl, .last = @ptrCast(&self.pl.*.part) };
        }

        pub fn append(self: *Self, t: T) !void {
            if (castPtr(T, ngx_list_push(self.pl))) |p0| {
                p0.* = t;
                self.len += 1;
            } else {
                return NError.OOM;
            }
        }
    };
}

test "list" {
    const log = ngx_log_init(c_str(""), c_str(""));
    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    var ns = try NList(ngx_uint_t).init(pool, 6);

    try expectEqual(ns.pl.*.size, @sizeOf(ngx_uint_t));
    try expectEqual(ns.size(), 0);
    try expectEqual(ns.pl.*.nalloc, 6);

    for (0..20) |i| {
        try ns.append(i);
    }
    try expectEqual(ns.at(10).?.*, 10);
    try expectEqual(ns.at(20), null);
    try expectEqual(ns.size(), 20);
}

const NGX_CACHELINE_SIZE = ngx.NGX_CPU_CACHE_LINE;
const ngx_hash_keys_array_t = ngx.ngx_hash_keys_arrays_t;
const ngx_hash_init_t = ngx.ngx_hash_init_t;
const ngx_hash_key_t = ngx.ngx_hash_key_t;
pub const ngx_hash_type = enum(ngx_uint_t) {
    hash_small = NGX_HASH_SMALL,
    hash_large = NGX_HASH_LARGE,
};

const ngx_hash_key = ngx.ngx_hash_key;
const ngx_hash_key_pt = ngx.ngx_hash_key_pt;
const ngx_hash_keys_array_init = ngx.ngx_hash_keys_array_init;
const ngx_hash_add_key = ngx.ngx_hash_add_key;
const ngx_hash_init = ngx.ngx_hash_init;
const ngx_hash_find = ngx.ngx_hash_find;

pub fn NHash(comptime K: type, comptime V: type, comptime M: ngx_uint_t) type {
    const MAX_SIZE = M;
    const BUCKET_SIZE = ngx_align(64, NGX_CACHELINE_SIZE);

    const Ctx = extern struct {
        name: [*c]u8,
        type: ngx_hash_type,
        key: *const fn ([*c]u8, usize) callconv(.C) ngx_uint_t,
        data: *const fn (k: [*c]K) callconv(.C) [*c]u8,
        len: *const fn (k: [*c]K) callconv(.C) usize,
        pool: [*c]ngx_pool_t,
        temp_pool: [*c]ngx_pool_t,
    };

    const KV = extern struct {
        key_ptr: [*c]K,
        value_ptr: [*c]V,
    };

    return extern struct {
        const Self = @This();
        pub const HashCtx = Ctx;
        pub const HashKV = KV;

        ctx: [*c]Ctx,
        hash: ngx_hash_t = undefined,

        // [*c]Ctx and []KV must retain
        pub fn init(ctx: [*c]Ctx, kv: []KV) !Self {
            var h = Self{ .ctx = ctx };

            var keys: ngx_hash_keys_array_t = undefined;
            keys.temp_pool = ctx.*.temp_pool;
            keys.pool = ctx.*.pool;

            if (ngx_hash_keys_array_init(&keys, @intCast(@intFromEnum(ctx.*.type))) != NGX_OK) {
                return NError.HASH_ERROR;
            }

            for (kv) |*kv0| {
                const str = ngx_str_t{ .len = ctx.*.len(kv0.key_ptr), .data = ctx.*.data(kv0.key_ptr) };
                if (ngx_hash_add_key(&keys, @constCast(&str), @alignCast(@ptrCast(kv0)), NGX_HASH_READONLY_KEY) != NGX_OK) {
                    return NError.HASH_ERROR;
                }
            }

            var hash_init = ngx_hash_init_t{
                .name = ctx.*.name,
                .max_size = MAX_SIZE,
                .bucket_size = BUCKET_SIZE,
                .pool = ctx.*.pool,
                .temp_pool = ctx.*.temp_pool,
                .key = ctx.*.key,
                .hash = &h.hash,
            };
            if (castPtr(ngx_hash_key_t, keys.keys.elts)) |ks| {
                if (ngx_hash_init(&hash_init, ks, keys.keys.nelts) == NGX_OK) {
                    return h;
                }
            }

            return NError.HASH_ERROR;
        }

        pub fn getPtr(self: *Self, k: [*c]K) ?[*c]KV {
            const name = self.ctx.*.data(k);
            const len = self.ctx.*.len(k);
            const k0 = self.ctx.*.key(name, len);
            if (castPtr(KV, ngx_hash_find(@ptrCast(&self.hash), k0, name, len))) |kv| {
                return kv;
            }
            return null;
        }
    };
}

pub fn ngx_str_data(k: [*c]ngx_str_t) callconv(.C) [*c]u8 {
    return k.*.data;
}

pub fn ngx_str_len(k: [*c]ngx_str_t) callconv(.C) usize {
    return k.*.len;
}

extern var ngx_cacheline_size: ngx_uint_t;
test "hash" {
    const log = ngx_log_init(c_str(""), c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    const temp_pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(temp_pool);

    ngx_cacheline_size = NGX_CACHELINE_SIZE;
    const Hash = NHash(ngx_str_t, ngx_int_t, 100);
    const KV = Hash.HashKV;
    const Ctx = Hash.HashCtx;

    const ctx = Ctx{
        .name = @constCast("test"),
        .type = .hash_small,
        .pool = pool,
        .temp_pool = temp_pool,
        .data = ngx_str_data,
        .len = ngx_str_len,
        .key = ngx_hash_key,
    };

    var ks = [_]ngx_str_t{
        ngx_string("a"),
        ngx_string("b"),
        ngx_string("c"),
    };
    var vs = [_]ngx_int_t{ 1, 2, 3 };

    var kv = [_]KV{
        KV{ .key_ptr = @ptrCast(&ks[0]), .value_ptr = @ptrCast(&vs[0]) },
        KV{ .key_ptr = @ptrCast(&ks[1]), .value_ptr = @ptrCast(&vs[1]) },
        KV{ .key_ptr = @ptrCast(&ks[2]), .value_ptr = @ptrCast(&vs[2]) },
    };

    var h = try Hash.init(@constCast(&ctx), &kv);
    if (h.getPtr(kv[2].key_ptr)) |d| {
        try expectEqual(d.*.key_ptr, kv[2].key_ptr);
        try expectEqual(d.*.value_ptr.*, 3);
    }
}

pub fn ZHash(comptime K: type, comptime V: type, comptime Ctx: type, comptime M: ngx_uint_t) type {
    const PAGE_SIZE = 1024;
    const HashMapType = std.HashMap(K, V, Ctx, M);
    const IteratorType = HashMapType.Iterator;

    return extern struct {
        const Self = @This();
        pub const HashMap = HashMapType;
        pub const Iterator = IteratorType;

        hash: ?*anyopaque,
        fba: ?*anyopaque,

        pub fn init(p: [*c]ngx_pool_t) !Self {
            if (ngz_pcalloc(HashMap, p)) |hash| {
                if (ngz_pcalloc(std.heap.FixedBufferAllocator, p)) |fba| {
                    if (castPtr(u8, ngx_pmemalign(p, PAGE_SIZE, NGX_ALIGNMENT))) |buf| {
                        fba.* = std.heap.FixedBufferAllocator.init(slicify(u8, buf, PAGE_SIZE));
                        const allocator = fba.allocator();
                        hash.* = HashMap.init(allocator);
                        return Self{ .hash = @alignCast(@ptrCast(hash)), .fba = @alignCast(@ptrCast(fba)) };
                    }
                }
            }
            return NError.OOM;
        }

        pub fn put(self: *Self, k: K, v: V) !void {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            try h.put(k, v);
        }

        pub fn iterator(self: *Self) Iterator {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            return h.iterator();
        }

        pub fn getPtr(self: *Self, k: K) ?*V {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            return h.getPtr(k);
        }

        pub fn size(self: *Self) ngx_uint_t {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            return h.count();
        }

        pub fn deinit(self: *Self) void {
            var h: *HashMap = @alignCast(@ptrCast(self.hash));
            h.deinit();
        }
    };
}

pub const ngx_str_hash_ctx = struct {
    pub fn hash(_: @This(), s: ngx_str_t) u64 {
        return ngx_hash_key(s.data, s.len);
    }
    pub fn eql(_: @This(), s0: ngx_str_t, s1: ngx_str_t) bool {
        if (s0.len != s1.len) {
            return false;
        }
        return std.mem.eql(u8, slicify(u8, s0.data, s0.len), slicify(u8, s1.data, s1.len));
    }
};

test "zhash" {
    const log = ngx_log_init(c_str(""), c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(4096, log);
    defer ngx_destroy_pool(pool);

    ngx_cacheline_size = NGX_CACHELINE_SIZE;
    const Hash = ZHash(ngx_str_t, ngx_int_t, ngx_str_hash_ctx, 80);

    var m = try Hash.init(pool);
    try m.put(ngx_string("abc"), 1);
    try m.put(ngx_string("xyz"), 2);
    try expectEqual(m.size(), 2);
    try expectEqual(m.getPtr(ngx_string("abc")).?.*, 1);

    defer m.deinit();
}

pub fn NAllocator(comptime PAGE_SIZE: ngx_uint_t) type {
    return extern struct {
        const Self = @This();
        fba: ?*anyopaque,

        pub fn init(p: [*c]ngx_pool_t) !Self {
            if (ngz_pcalloc(std.heap.FixedBufferAllocator, p)) |fba| {
                if (castPtr(u8, ngx_pmemalign(p, PAGE_SIZE, NGX_ALIGNMENT))) |buf| {
                    fba.* = std.heap.FixedBufferAllocator.init(slicify(u8, buf, PAGE_SIZE));
                    return Self{ .fba = @alignCast(@ptrCast(fba)) };
                }
            }
            return NError.OOM;
        }

        pub fn allocator(self: *Self) std.mem.Allocator {
            return .{
                .ptr = self.fba.?,
                .vtable = &.{
                    .alloc = alloc,
                    .resize = resize,
                    .free = free,
                },
            };
        }

        fn alloc(ctx: *anyopaque, len: usize, ptr_align: u8, ret_addr: usize) ?[*]u8 {
            var fba: *std.heap.FixedBufferAllocator = @alignCast(@ptrCast(ctx));
            return fba.allocator().rawAlloc(len, ptr_align, ret_addr);
        }

        fn resize(ctx: *anyopaque, buf: []u8, buf_align: u8, new_len: usize, ret_addr: usize) bool {
            var fba: *std.heap.FixedBufferAllocator = @alignCast(@ptrCast(ctx));
            return fba.allocator().rawResize(buf, buf_align, new_len, ret_addr);
        }

        fn free(ctx: *anyopaque, buf: []u8, buf_align: u8, ret_addr: usize) void {
            var fba: *std.heap.FixedBufferAllocator = @alignCast(@ptrCast(ctx));
            return fba.allocator().rawFree(buf, buf_align, ret_addr);
        }
    };
}

test "allocator" {
    const log = ngx_log_init(c_str(""), c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    var fba = try NAllocator(1024).init(pool);
    const allocator = fba.allocator();

    var as = std.ArrayList(usize).init(allocator);
    for (0..10) |i| {
        try as.append(i);
    }
    try expectEqual(as.items.len, 10);
}
