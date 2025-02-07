const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
const ssl = ngx.ssl;
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
const ngx_kayval_t = ngx.string.ngx_keyval_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NChain = ngx.buf.NChain;
const NArray = ngx.array.NArray;
const NTimer = ngx.event.NTimer;
const NSubrequest = http.NSubrequest;
const NSSL_RSA = ssl.NSSL_RSA;
const NSSL_AES_256_GCM = ssl.NSSL_AES_256_GCM;

const WError = error{
    BODY_ERROR,
    HEADER_ERROR,
    COMMAND_ERROR,
};

const oaep_action = enum(ngx_uint_t) {
    OAEP_DECRYPT,
    OAEP_ENCRYPT,
    OAEP_NONE,
};

const wechatpay_context = extern struct {
    rsa: [*c]NSSL_RSA,
    aes: [*c]NSSL_AES_256_GCM,
    notify: ngx_str_t,
    action: oaep_action,
};

const wechatpay_loc_conf = extern struct {
    proxy: ngx_str_t,
    apiclient_key: ngx_str_t,
    apiclient_serial: ngx_str_t,
    wechatpay_public_key: ngx_str_t,
    wechatpay_serial: ngx_str_t,
    mch_id: ngx_str_t,
    notify_proxy: ?*anyopaque,
    oaep_encrypt: ngx_flag_t,
    oaep_decrypt: ngx_flag_t,
    ctx: [*c]wechatpay_context,
};

fn init_wechatpay_context(cf: [*c]wechatpay_loc_conf, p: [*c]ngx_pool_t) ![*c]wechatpay_context {
    if (core.ngz_pcalloc_c(wechatpay_context, p)) |ctx| {
        if (core.ngz_pcalloc_c(NSSL_RSA, p)) |rsa| {
            rsa.* = try NSSL_RSA.init(cf.*.apiclient_key, cf.*.wechatpay_public_key);
            ctx.*.rsa = rsa;
        }
        if (core.castPtr(ngx_array_t, cf.*.notify_proxy)) |notify_proxy| {
            if (core.castPtr(ngx.string.ngx_keyval_t, notify_proxy.*.elts)) |kv| {
                if (core.ngz_pcalloc_c(NSSL_AES_256_GCM, p)) |aes| {
                    aes.* = try NSSL_AES_256_GCM.init(kv.*.key);
                    ctx.*.aes = aes;
                    ctx.*.notify = kv.*.value;
                }
            }
        }
        ctx.*.action = .OAEP_NONE;
        if (cf.*.oaep_encrypt == 1) {
            ctx.*.action = .OAEP_ENCRYPT;
        }
        if (cf.*.oaep_decrypt == 1) {
            ctx.*.action = .OAEP_DECRYPT;
        }
        return ctx;
    }
    return core.NError.OOM;
}

fn deinit_wechatpay_context(ctx: [*c]wechatpay_context) void {
    ctx.*.rsa.*.deinit();
    ctx.*.aes.*.deinit();
}

fn wechatpay_create_loc_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (core.ngz_pcalloc_c(wechatpay_loc_conf, cf.*.pool)) |p| {
        p.*.oaep_encrypt = conf.NGX_CONF_UNSET;
        p.*.oaep_decrypt = conf.NGX_CONF_UNSET;
        p.*.notify_proxy = null;
        return p;
    }
    return null;
}

fn config_assert(cf: [*c]ngx_conf_t, condition: bool, statement: []const u8) !void {
    if (!condition) {
        ngx.log.ngz_log_error(ngx.log.NGX_LOG_EMERG, cf.*.log, 0, statement.ptr, .{});
        return core.NError.CONF_ERROR;
    }
}

fn config_check(cf: [*c]ngx_conf_t, ch: [*c]wechatpay_loc_conf) [*c]u8 {
    const b0 = ssl.check_public_key(ch.*.wechatpay_public_key) catch false;
    config_assert(cf, b0, "invalid wechatpay public key") catch return conf.NGX_CONF_ERROR;
    const b1 = ssl.check_private_key(ch.*.apiclient_key) catch false;
    config_assert(cf, b1, "invalid wechatpay apiclient key") catch return conf.NGX_CONF_ERROR;
    config_assert(cf, ch.*.wechatpay_serial.len > 0, "invalid wechatpay serial") catch return conf.NGX_CONF_ERROR;
    config_assert(cf, ch.*.apiclient_serial.len > 0, "invalid apiclient serial") catch return conf.NGX_CONF_ERROR;
    config_assert(cf, ch.*.mch_id.len > 0, "invalid wechatpay mch_id") catch return conf.NGX_CONF_ERROR;

    ch.*.ctx = init_wechatpay_context(ch, cf.*.pool) catch return conf.NGX_CONF_ERROR;
    return conf.NGX_CONF_OK;
}

fn wechatpay_merge_loc_conf(cf: [*c]ngx_conf_t, parent: ?*anyopaque, child: ?*anyopaque) callconv(.C) [*c]u8 {
    if (core.castPtr(wechatpay_loc_conf, parent)) |pr| {
        if (core.castPtr(wechatpay_loc_conf, child)) |ch| {
            conf.ngx_conf_merge_str_value(&ch.*.apiclient_key, &pr.*.apiclient_key, ngx_string(""));
            conf.ngx_conf_merge_str_value(&ch.*.apiclient_serial, &pr.*.apiclient_serial, ngx_string(""));
            conf.ngx_conf_merge_str_value(&ch.*.wechatpay_public_key, &pr.*.wechatpay_public_key, ngx_string(""));
            conf.ngx_conf_merge_str_value(&ch.*.wechatpay_serial, &pr.*.wechatpay_serial, ngx_string(""));
            conf.ngx_conf_merge_str_value(&ch.*.mch_id, &pr.*.mch_id, ngx_string(""));

            if (conf.ngx_http_conf_get_core_module_loc_conf(cf)) |cocf| {
                if (ch.*.proxy.len > 0) {
                    cocf.*.handler = ngx_http_wechatpay_proxy_handler;
                    return config_check(cf, ch);
                }
                if (core.castPtr(ngx_array_t, ch.*.notify_proxy)) |notify_proxy| {
                    if (core.castPtr(ngx.string.ngx_keyval_t, notify_proxy.*.elts)) |kv| {
                        ngx.log.ngx_http_conf_debug(cf, "aes key is %V notify url is %V", .{ &kv.*.key, &kv.*.value });
                        cocf.*.handler = ngx_http_wechatpay_notify_handler;
                        return config_check(cf, ch);
                    }
                }
                if (ch.*.oaep_decrypt != conf.NGX_CONF_UNSET or ch.*.oaep_encrypt != conf.NGX_CONF_UNSET) {
                    cocf.*.handler = ngx_http_wechatpay_oaep_handler;
                    return config_check(cf, ch);
                }
            }
        }
    }
    return conf.NGX_CONF_OK;
}

fn send_header(r: [*c]ngx_http_request_t) WError!void {
    r.*.headers_out.status = http.NGX_HTTP_OK;
    http.ngx_http_clear_content_length(r);
    http.ngx_http_clear_accept_ranges(r);

    if (http.ngx_http_send_header(r) != NGX_OK) {
        return WError.HEADER_ERROR;
    }
}

fn send_body(r: [*c]ngx_http_request_t, chain: [*c]ngx_chain_t) WError!ngx_int_t {
    if (!r.*.flags1.header_sent) {
        try send_header(r);
    }

    if (chain != core.nullptr(ngx_chain_t)) {
        return http.ngx_http_output_filter(r, chain);
    } else {
        return http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
    }
}

fn wechatpay_postconfiguration(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    _ = cf;
    return NGX_OK;
}

export fn ngx_http_wechatpay_proxy_body_handler(r: [*c]ngx_http_request_t) callconv(.C) void {
    _ = r;
}

export fn ngx_http_wechatpay_proxy_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    _ = r;
    return NGX_OK;
}

export fn ngx_http_wechatpay_notify_body_handler(r: [*c]ngx_http_request_t) callconv(.C) void {
    _ = r;
}

export fn ngx_http_wechatpay_notify_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    _ = r;
    return NGX_OK;
}

fn read_body(r: [*c]ngx_http_request_t) ngx_str_t {
    const b0 = r.*.request_body == core.nullptr(http.ngx_http_request_body_t);
    const b1 = r.*.request_body.*.bufs == core.nullptr(buf.ngx_chain_t);
    const b2 = r.*.request_body.*.temp_file != core.nullptr(core.ngx_temp_file_t); //TODO
    var res: ngx_str_t = ngx.string.ngx_null_str;
    if (b0 or b1 or b2) {
        return res;
    }
    var len: ngx_uint_t = 0;
    var bufs = r.*.request_body.*.bufs;
    var it = &bufs;
    while (buf.ngz_chain_iterate(it)) |b| {
        if (!buf.ngx_buf_in_memory(b) and b.*.flags.in_file) {
            return res; //TODO
        }
        len += @intFromPtr(b.*.last) - @intFromPtr(b.*.pos);
    }
    if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, len))) |p| {
        var i: usize = 0;
        var s = core.slicify(u8, p, len);
        bufs = r.*.request_body.*.bufs;
        it = &bufs;
        while (buf.ngz_chain_iterate(it)) |b| {
            if (buf.ngx_buf_in_memory(b)) {
                const l = @intFromPtr(b.*.last) - @intFromPtr(b.*.pos);
                @memcpy(s[i .. i + l], core.slicify(u8, b.*.pos, l));
                i += l;
            }
        }
        if (i == len) {
            res = ngx_str_t{ .data = p, .len = len };
        }
    }
    return res;
}

fn execute_oaep_action(r: [*c]ngx_http_request_t, ctx: [*c]wechatpay_context) !ngx_int_t {
    const action = ctx.*.action;
    const body = read_body(r);
    if (body.len == 0) {
        return NGX_OK;
    }
    // defer core.ngx_pfree(r.*.pool, msg.data);
    const msg = switch (action) {
        .OAEP_DECRYPT => try ctx.*.rsa.*.oaep_decrypt(body, r.*.pool),
        .OAEP_ENCRYPT => try ctx.*.rsa.*.oaep_encrypt(body, r.*.pool),
        .OAEP_NONE => body,
    };
    var out = buf.ngx_chain_t{
        .buf = core.nullptr(ngx_buf_t),
        .next = core.nullptr(ngx_chain_t),
    };
    var chain = NChain.init(r.*.pool);
    const last = try chain.allocStr(msg, &out);
    last.*.buf.*.flags.last_buf = true;
    last.*.buf.*.flags.last_in_chain = true;

    const rc = try send_body(r, out.next);
    return rc;
}

export fn ngx_http_wechatpay_oaep_body_handler(r: [*c]ngx_http_request_t) callconv(.C) void {
    if (core.castPtr(wechatpay_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |ctx| {
        const rc = execute_oaep_action(r, ctx) catch return http.ngx_http_finalize_request(r, http.NGX_HTTP_INTERNAL_SERVER_ERROR);
        http.ngx_http_finalize_request(r, rc);
    }
}

export fn ngx_http_wechatpay_oaep_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(wechatpay_loc_conf, conf.ngx_http_get_module_loc_conf(r, &ngx_http_wechatpay_module))) |lccf| {
        _ = http.ngz_http_getor_module_ctx(wechatpay_context, r, &ngx_http_wechatpay_module, lccf.*.ctx);
        const rc = http.ngx_http_read_client_request_body(r, ngx_http_wechatpay_oaep_body_handler);
        if (rc == core.NGX_ERROR or rc >= http.NGX_HTTP_SPECIAL_RESPONSE) {
            return rc;
        }
        r.*.main.*.flags0.count -= 1;
        return if (rc == core.NGX_AGAIN) core.NGX_DONE else rc;
    }
    return NGX_OK;
}

export const ngx_http_wechatpay_module_ctx = ngx_http_module_t{
    .preconfiguration = @ptrCast(NULL),
    .postconfiguration = wechatpay_postconfiguration,
    .create_main_conf = @ptrCast(NULL),
    .init_main_conf = @ptrCast(NULL),
    .create_srv_conf = @ptrCast(NULL),
    .merge_srv_conf = @ptrCast(NULL),
    .create_loc_conf = wechatpay_create_loc_conf,
    .merge_loc_conf = wechatpay_merge_loc_conf,
};

export const ngx_http_wechatpay_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("wechatpay_proxy"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "proxy"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_apiclient_key_file"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_file_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "apiclient_key"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_apiclient_serial"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "apiclient_serial"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_public_key_file"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_file_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "wechatpay_public_key"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_serial"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "wechatpay_serial"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_mch_id"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "mch_id"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_oaep_encrypt"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "oaep_encrypt"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_oaep_decrypt"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "oaep_decrypt"),
        .post = NULL,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_notify_proxy"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE2,
        .set = conf.ngx_conf_set_keyval_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "notify_proxy"),
        .post = NULL,
    },
};

export var ngx_http_wechatpay_module = ngx.module.make_module(
    @constCast(&ngx_http_wechatpay_commands),
    @constCast(&ngx_http_wechatpay_module_ctx),
);

const expectEqual = std.testing.expectEqual;
test "wechatpay module" {}
