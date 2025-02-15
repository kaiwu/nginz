const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
const ssl = ngx.ssl;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const cjson = ngx.cjson;
const CJSON = cjson.CJSON;

const Pair = core.Pair;
const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_AGAIN = core.NGX_AGAIN;
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
const ngx_table_elt_t = ngx.hash.ngx_table_elt_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const ngx_sprintf = ngx.string.ngx_sprintf;
const NList = ngx.list.NList;
const NChain = ngx.buf.NChain;
const NArray = ngx.array.NArray;
const NTimer = ngx.event.NTimer;
const NSubrequest = http.NSubrequest;
const NSSL_RSA = ssl.NSSL_RSA;
const NSSL_AES_256_GCM = ssl.NSSL_AES_256_GCM;

const WECHATPAY_AUTH_HEADER = ngx_string("WECHATPAY2-SHA256-RSA2048");
extern var ngx_pagesize: ngx_uint_t;

const WError = error{
    BODY_ERROR,
    HEADER_ERROR,
    COMMAND_ERROR,
    UPSTREAM_ERROR,
    SIGNATURE_ERROR,
};

const oaep_action = enum(ngx_uint_t) {
    OAEP_DECRYPT,
    OAEP_ENCRYPT,
    OAEP_NONE,
};

const signature_verification_status = enum(ngx_uint_t) {
    SIG_VERIFICATION_FAILED,
    SIG_VERIFICATION_SUCCESS,
    SIG_VERIFICATION_PENDDING,
};

const wechatpay_context = extern struct {
    rsa: [*c]NSSL_RSA,
    aes: [*c]NSSL_AES_256_GCM,
    notify: ngx_str_t,
    action: oaep_action,
};

const wechatpay_request_context = extern struct {
    lccf: [*c]wechatpay_loc_conf,
    sig_verify: signature_verification_status,
    status: http.ngx_http_status_t,
};

const wechatpay_loc_conf = extern struct {
    proxy: ngx_str_t,
    apiclient_key: ngx_str_t,
    apiclient_serial: ngx_str_t,
    wechatpay_public_key: ngx_str_t,
    wechatpay_serial: ngx_str_t,
    mch_id: ngx_str_t,
    notify_location: ?*anyopaque,
    oaep_encrypt: ngx_flag_t,
    oaep_decrypt: ngx_flag_t,
    ctx: [*c]wechatpay_context,
    ups: [*c]http.ngx_http_upstream_conf_t,
};

fn init_upstream_conf(p: [*c]ngx_pool_t) ![*c]http.ngx_http_upstream_conf_t {
    if (core.ngz_pcalloc_c(http.ngx_http_upstream_conf_t, p)) |cf| {
        cf.*.buffering = 1;
        cf.*.buffer_size = 4 * ngx_pagesize;
        cf.*.bufs.num = 8;
        cf.*.bufs.size = 4 * ngx_pagesize;
        cf.*.ssl_verify = 0;
        cf.*.max_temp_file_size = 0;
        cf.*.temp_file_write_size = 0;
        cf.*.module = ngx_string("ngx_http_wechatpay_module");
        if (core.ngz_pcalloc_c(ngx_array_t, p)) |hide| {
            cf.*.hide_headers = hide;
            if (core.ngz_pcalloc_c(ngx_array_t, p)) |pass| {
                cf.*.pass_headers = pass;
                return cf;
            }
        }
    }
    return core.NError.OOM;
}

fn init_wechatpay_context(cf: [*c]wechatpay_loc_conf, p: [*c]ngx_pool_t) ![*c]wechatpay_context {
    if (core.ngz_pcalloc_c(wechatpay_context, p)) |ctx| {
        if (core.ngz_pcalloc_c(NSSL_RSA, p)) |rsa| {
            rsa.* = try NSSL_RSA.init(cf.*.apiclient_key, cf.*.wechatpay_public_key);
            ctx.*.rsa = rsa;
        }
        if (core.castPtr(ngx_array_t, cf.*.notify_location)) |notify_location| {
            if (core.castPtr(ngx.string.ngx_keyval_t, notify_location.*.elts)) |kv| {
                ctx.*.notify = kv.*.value;
                ctx.*.aes = core.nullptr(NSSL_AES_256_GCM);
                if (kv.*.key.len == NSSL_AES_256_GCM.KEY_SIZE) {
                    if (core.ngz_pcalloc_c(NSSL_AES_256_GCM, p)) |aes| {
                        aes.* = try NSSL_AES_256_GCM.init(kv.*.key);
                        ctx.*.aes = aes;
                    }
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
        p.*.notify_location = null;
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
                if (ch.*.proxy.len > 5) { // http:// or https://
                    cocf.*.handler = ngx_http_wechatpay_proxy_handler;
                    ch.*.ups = init_upstream_conf(cf.*.pool) catch return conf.NGX_CONF_ERROR;
                    return config_check(cf, ch);
                }
                if (core.castPtr(ngx_array_t, ch.*.notify_location)) |notify_location| {
                    if (core.castPtr(ngx.string.ngx_keyval_t, notify_location.*.elts)) |kv| {
                        ngx.log.ngx_http_conf_debug(cf, "aes key is %V, notify location is %V", .{ &kv.*.key, &kv.*.value });
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

fn nonce(p: [*c]ngx_pool_t) !ngx_str_t {
    var bf: [16]u8 = undefined;
    if (ssl.RAND_bytes(&bf, bf.len) != 1) {
        return WError.HEADER_ERROR;
    }
    if (core.castPtr(u8, core.ngx_pnalloc(p, bf.len * 2))) |b| {
        _ = ngx.string.ngx_hex_dump(b, &bf, bf.len);
        return ngx_str_t{ .data = b, .len = bf.len * 2 };
    }
    return core.NError.OOM;
}

fn timestamp(p: [*c]ngx_pool_t) !ngx_str_t {
    if (core.castPtr(u8, core.ngx_pnalloc(p, 16))) |b| {
        var t = core.ngx_time();
        var t0 = t;
        var len: usize = 0;
        while (t0 > 0) : (len += 1) {
            t0 = @divTrunc(t0, 10);
        }

        var i = len;
        while (i > 0) : (i -= 1) {
            b[i - 1] = '0' + @as(u8, @intCast(@mod(t, 10)));
            t = @divTrunc(t, 10);
        }
        return ngx_str_t{ .data = b, .len = len };
    }
    return core.NError.OOM;
}

fn read_body(r: [*c]ngx_http_request_t) ngx_str_t {
    const res: ngx_str_t = ngx.string.ngx_null_str;
    const b0 = r.*.request_body == core.nullptr(http.ngx_http_request_body_t);
    const b1 = r.*.request_body.*.bufs == core.nullptr(buf.ngx_chain_t);
    const b2 = r.*.request_body.*.temp_file != core.nullptr(core.ngx_temp_file_t); //TODO
    if (b0 or b1 or b2) {
        return res;
    }
    return buf.ngz_chain_content(r.*.request_body.*.bufs, r.*.pool) catch res;
}

fn sign_request(lccf: [*c]wechatpay_loc_conf, r: [*c]ngx_http_request_t, data: [*c]u8) !ngx_str_t {
    const nstr = try nonce(r.*.pool);
    const tstr = try timestamp(r.*.pool);
    var write: [*c]u8 = data;
    write = ngx_sprintf(write, "%V\n", &r.*.method_name);
    write = ngx_sprintf(write, "%V?%V\n", &r.*.uri, &r.*.args);
    write = ngx_sprintf(write, "%V\n", &tstr);
    write = ngx_sprintf(write, "%V\n", &nstr);
    const body = read_body(r);
    write = ngx_sprintf(write, "%V\n", &body);
    var len = @intFromPtr(write) - @intFromPtr(&data);
    const signed = try lccf.*.ctx.*.rsa.*.sign_sha256(ngx_str_t{ .data = data, .len = len }, r.*.pool);

    write = data;
    write = ngx_sprintf(write, "Authorization: %V ", &WECHATPAY_AUTH_HEADER);
    write = ngx_sprintf(write, "mchid=\"%V\",", &lccf.*.mch_id);
    write = ngx_sprintf(write, "serial_no=\"%V\",", &lccf.*.apiclient_serial);
    write = ngx_sprintf(write, "nonce_str=\"%V\",", &nstr);
    write = ngx_sprintf(write, "timestamp=\"%V\",", &tstr);
    write = ngx_sprintf(write, "signature=\"%V\"\r\n", &signed);
    len = @intFromPtr(write) - @intFromPtr(&data);
    if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, len))) |b| {
        @memcpy(core.slicify(u8, b, len), core.slicify(u8, data, len));
        return ngx_str_t{ .data = b, .len = len };
    }
    return core.NError.OOM;
}

fn build_request(lccf: [*c]wechatpay_loc_conf, r: [*c]ngx_http_request_t) !ngx_str_t {
    if (core.castPtr(u8, core.ngx_pmemalign(r.*.pool, 2 * ngx_pagesize, core.NGX_ALIGNMENT))) |data| {
        defer _ = core.ngx_pfree(r.*.pool, data);

        const sign = try sign_request(lccf, r, data);
        var write: [*c]u8 = data;
        write = ngx_sprintf(write, "%V %V?%V HTTP/1.1\r\n", &r.*.method_name, &r.*.uri, &r.*.args);
        write = ngx_sprintf(write, "Host: %V\r\n", &r.*.upstream.*.resolved.*.host);

        var headers = NList(ngx_table_elt_t).init0(&r.*.headers_in.headers);
        var it = headers.iterator();
        while (it.next()) |h| {
            write = ngx_sprintf(write, "%V: %V\r\n", &h.*.key, &h.*.value);
        }
        write = ngx_sprintf(write, "%V\r\n", &sign);
        const len = @intFromPtr(write) - @intFromPtr(&data);
        if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, len))) |b| {
            @memcpy(core.slicify(u8, b, len), core.slicify(u8, data, len));
            return ngx_str_t{ .data = b, .len = len };
        }
    }
    return core.NError.OOM;
}

fn find_header(headers: [*c]NList(ngx_table_elt_t), name: ngx_str_t) !ngx_str_t {
    const key = ngx.hash.ngx_hash_key_lc(name.data, name.len);
    var it = headers.*.iterator();
    while (it.next()) |h| {
        if (h.*.hash == key) {
            return h.*.value;
        }
    }
    return WError.HEADER_ERROR;
}

fn verify_request(
    lccf: [*c]wechatpay_loc_conf,
    headers: [*c]NList(ngx_table_elt_t),
    body: ngx_str_t,
    pool: [*c]ngx_pool_t,
    data: [*c]u8,
) !bool {
    const w_serial = try find_header(headers, ngx_string("Wechatpay-Serial"));
    const req_id = try find_header(headers, ngx_string("Request-ID"));
    if (req_id.len == 0 or !ngx.string.eql(w_serial, lccf.*.wechatpay_serial)) {
        return false;
    }
    const w_nonce = try find_header(headers, ngx_string("Wechatpay-Nonce"));
    const w_timestamp = try find_header(headers, ngx_string("Wechatpay-Timestamp"));
    const w_signature = try find_header(headers, ngx_string("Wechatpay-Signature"));
    var write: [*c]u8 = data;
    write = ngx_sprintf(write, "%V\n", &w_timestamp);
    write = ngx_sprintf(write, "%V\n", &w_nonce);
    write = ngx_sprintf(write, "%V\n", &body);
    const len = @intFromPtr(write) - @intFromPtr(&data);
    return lccf.*.ctx.*.rsa.*.verify_sha256(w_signature, ngx_str_t{ .data = data, .len = len }, pool);
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

fn wechatpay_preconfiguration(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    ssl.SSL_LOG = cf.*.log;
    return NGX_OK;
}

fn wechatpay_postconfiguration(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    _ = cf;
    return NGX_OK;
}

fn is_http(host: ngx_str_t) Pair(bool, ngx_str_t) {
    const h5 = core.slicify(u8, host.data, 5);
    if (std.mem.eql(u8, "http:", h5) and host.len > 7) {
        return Pair(bool, ngx_str_t){ .t = true, .u = .{ .data = host.data + 7, .len = host.len - 7 } };
    }
    if (std.mem.eql(u8, "https", h5) and host.len > 8) {
        return Pair(bool, ngx_str_t){ .t = false, .u = .{ .data = host.data + 8, .len = host.len - 8 } };
    }
    return Pair(bool, ngx_str_t){ .t = false, .u = host };
}

/////////////////////////////////////////  WECHATPAY UPSTREAM  //////////////////////////////////////////////////
fn ngx_http_wechatpay_proxy_upstream_create_request(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
        const req = build_request(rctx.*.lccf, r) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        var chain = NChain.init(r.*.pool);
        var out = buf.ngx_chain_t{
            .buf = core.nullptr(ngx_buf_t),
            .next = core.nullptr(ngx_chain_t),
        };
        const last = chain.allocStr(req, &out) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        rctx.*.sig_verify = .SIG_VERIFICATION_PENDDING;
        if (r.*.upstream.*.request_bufs == core.nullptr(ngx_chain_t)) {
            last.*.buf.*.flags.last_buf = true;
            last.*.buf.*.flags.last_in_chain = true;
        }
        last.*.next = r.*.upstream.*.request_bufs;
        r.*.upstream.*.request_bufs = last;

        r.*.upstream.*.flags.header_sent = false;
        r.*.upstream.*.flags.request_sent = false;
    }
    return NGX_OK;
}

fn ngx_http_wechatpay_proxy_upstream_process_status(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
        const u = r.*.upstream;
        const rc = http.ngx_http_parse_status_line(r, &u.*.buffer, &rctx.*.status);
        if (rc == NGX_AGAIN) {
            return rc;
        }
        if (rc == NGX_ERROR) {
            return rc; //TODO
        }
        if (u.*.state != core.nullptr(http.ngx_http_upstream_state_t) and
            u.*.state.*.status == 0)
        {
            u.*.state.*.status = rctx.*.status.code;
        }
        u.*.headers_in.status_n = rctx.*.status.code;
        const len = @intFromPtr(rctx.*.status.end) - @intFromPtr(rctx.*.status.start);
        u.*.headers_in.status_line.len = len;
        if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, len))) |data| {
            @memcpy(core.slicify(u8, data, len), core.slicify(u8, rctx.*.status.start, len));
            u.*.process_header = ngx_http_wechatpay_proxy_upstream_process_header;
            return ngx_http_wechatpay_proxy_upstream_process_header(r);
        }
    }
    return NGX_ERROR;
}

extern var ngx_http_upstream_module: ngx_module_t;
fn ngx_http_wechatpay_proxy_upstream_process_header(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(http.ngx_http_upstream_main_conf_t, conf.ngx_http_get_module_main_conf(r, &ngx_http_upstream_module))) |umcf| {
        const u = r.*.upstream;
        var headers = NList(ngx_table_elt_t).init0(&u.*.headers_in.headers);
        while (true) {
            const rc = http.ngx_http_parse_header_line(r, &u.*.buffer, 1);
            switch (rc) {
                NGX_OK => {
                    const h = headers.append() catch return NGX_ERROR;
                    if (http.ngz_set_upstream_header(h, r, umcf) != NGX_OK) {
                        return NGX_ERROR;
                    }
                    continue;
                },
                NGX_AGAIN => return rc,
                http.NGX_HTTP_PARSE_HEADER_DONE => {
                    if (u.*.headers_in.flags.chunked) {
                        u.*.headers_in.content_length_n = -1;
                    }
                    return NGX_OK;
                },
                else => return http.NGX_HTTP_UPSTREAM_INVALID_HEADER,
            }
        }
    }
    return NGX_OK;
}

fn finalize_request(r: [*c]ngx_http_request_t, rc: ngx_int_t, rctx: [*c]wechatpay_request_context) !bool {
    if (rc != NGX_OK) {
        return false;
    }
    if (core.castPtr(u8, core.ngx_pmemalign(r.*.pool, 2 * ngx_pagesize, core.NGX_ALIGNMENT))) |data| {
        defer _ = core.ngx_pfree(r.*.pool, data);
        const u = r.*.upstream;
        var headers = NList(ngx_table_elt_t).init0(&u.*.headers_in.headers);
        const content_length: ngx_uint_t = @intCast(u.*.headers_in.content_length_n);
        var body = ngx_str_t{ .data = u.*.buffer.pos, .len = core.ngz_len(u.*.buffer.pos, u.*.buffer.last) };
        if (content_length == body.len) {
            return verify_request(rctx.*.lccf, &headers, body, r.*.pool, data);
        }

        const olen = buf.ngz_chain_length(u.*.out_bufs);
        if (olen > 0 and content_length == body.len + olen) {
            if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, content_length))) |p| {
                const out = try buf.ngz_chain_content(u.*.out_bufs, r.*.pool);
                @memcpy(core.slicify(u8, p, body.len), core.slicify(u8, body.data, body.len));
                @memcpy(core.slicify(u8, p + body.len, olen), core.slicify(u8, out.data, olen));
                body = ngx_str_t{ .data = p, .len = content_length };
                return verify_request(rctx.*.lccf, &headers, body, r.*.pool, data);
            }
        }
    }
    return false;
}

fn ngx_http_wechatpay_proxy_upstream_finalize_request(r: [*c]ngx_http_request_t, rc: ngx_int_t) callconv(.C) void {
    if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
        const verify = finalize_request(r, rc, rctx) catch false;
        const header_wait = rctx.*.sig_verify == .SIG_VERIFICATION_PENDDING;
        rctx.*.sig_verify = if (verify) .SIG_VERIFICATION_SUCCESS else .SIG_VERIFICATION_FAILED;
        if (header_wait) {
            _ = http.ngx_http_send_header(r);
        }
    }
}

fn create_upstream(r: [*c]ngx_http_request_t, lccf: [*c]wechatpay_loc_conf) !ngx_int_t {
    if (http.ngx_http_upstream_create(r) != NGX_OK) {
        return WError.UPSTREAM_ERROR;
    }
    r.*.upstream.*.conf = lccf.*.ups;
    r.*.upstream.*.flags.buffering = true;
    r.*.upstream.*.create_request = ngx_http_wechatpay_proxy_upstream_create_request;
    r.*.upstream.*.process_header = ngx_http_wechatpay_proxy_upstream_process_status;
    r.*.upstream.*.finalize_request = ngx_http_wechatpay_proxy_upstream_finalize_request;
    const hhost = is_http(lccf.*.proxy);
    if (hhost.t) {
        r.*.upstream.*.resolved.*.host = hhost.u;
        r.*.upstream.*.resolved.*.port = 80;
        r.*.upstream.*.flags.ssl = false;
    } else {
        r.*.upstream.*.resolved.*.host = hhost.u;
        r.*.upstream.*.resolved.*.port = 443;
        r.*.upstream.*.flags.ssl = true;
    }
    r.*.upstream.*.resolved.*.naddrs = 1;
    http.ngx_http_upstream_init(r);
    return core.NGX_DONE;
}

export fn ngx_http_wechatpay_proxy_body_handler(r: [*c]ngx_http_request_t) callconv(.C) void {
    if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
        const rc = create_upstream(r, rctx.*.lccf) catch http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        return http.ngx_http_finalize_request(r, rc);
    }
    http.ngx_http_finalize_request(r, http.NGX_HTTP_SERVICE_UNAVAILABLE);
}

export fn ngx_http_wechatpay_proxy_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(wechatpay_loc_conf, conf.ngx_http_get_module_loc_conf(r, &ngx_http_wechatpay_module))) |lccf| {
        const rctx = http.ngz_http_get_module_ctx(wechatpay_request_context, r, &ngx_http_wechatpay_module) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        if (rctx.*.lccf == core.nullptr(wechatpay_loc_conf)) {
            rctx.*.lccf = lccf;
        }
        if (r.*.method & (http.NGX_HTTP_PUT | http.NGX_HTTP_POST) == 0) {
            const rc = create_upstream(r, lccf) catch http.NGX_HTTP_INTERNAL_SERVER_ERROR;
            return rc;
        } else {
            const rc = http.ngx_http_read_client_request_body(r, ngx_http_wechatpay_proxy_body_handler);
            return if (rc == NGX_AGAIN) core.NGX_DONE else rc;
        }
    }
    return NGX_OK;
}

///////////////////////////////////////   NOTIFY LOCATION  //////////////////////////////////////////////////////

// if verified aes decrypt https://pay.weixin.qq.com/doc/v3/merchant/4012791902
fn aes_decode(r: [*c]ngx_http_request_t, body: ngx_str_t, aes: [*c]NSSL_AES_256_GCM, data: [*c]u8) !ngx_str_t {
    if (aes == core.nullptr(NSSL_AES_256_GCM)) {
        return body;
    }
    var cj = CJSON.init(r.*.pool);
    const json = cj.decode(body);
    const resource = CJSON.query(json, "$.resource");
    const ciphertext = CJSON.query(json, "$.resource.ciphertext");
    const aad = CJSON.query(json, "$.resource.associated_data");
    const iv = CJSON.query(json, "$.resource.nonce");
    if (resource == null or ciphertext == null or aad == null or iv == null) {
        return WError.BODY_ERROR;
    }
    const plaintxt = try aes.*.decrypt(
        CJSON.stringValue(ciphertext.?).?,
        CJSON.stringValue(iv.?).?,
        CJSON.stringValue(aad.?).?,
        r.*.pool,
    );
    var write: [*c]u8 = data;
    write = ngx_sprintf(write, "plaintxt");
    write.* = 0;
    write = ngx_sprintf(write + 1, "%V", &plaintxt);
    write.* = 0;

    if (cjson.cJSON_AddStringToObject(resource.?, data, data + 9, &cj.alloc) == core.nullptr(cjson.cJSON)) {
        return WError.BODY_ERROR;
    }
    return cj.encode(json);
}

fn notify(r: [*c]ngx_http_request_t) !ngx_int_t {
    if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
        if (core.castPtr(u8, core.ngx_pmemalign(r.*.pool, 2 * ngx_pagesize, core.NGX_ALIGNMENT))) |data| {
            defer _ = core.ngx_pfree(r.*.pool, data);

            const lccf = rctx.*.lccf;
            const mch_id = lccf.*.mch_id;
            // verify signature
            const body = read_body(r);
            var headers = NList(ngx_table_elt_t).init0(&r.*.headers_in.headers);
            const verify = verify_request(lccf, &headers, body, r.*.pool, data) catch false;
            if (!verify) {
                ngx.log.ngz_log_error(ngx.log.NGX_LOG_WARN, r.*.connection.*.log, 0, "mch_id %V signature verification failed", .{&mch_id});
                return WError.SIGNATURE_ERROR;
            }

            const new_body = try aes_decode(r, body, lccf.*.ctx.*.aes, data);
            if (new_body.len != body.len) {
                var chain = NChain.init(r.*.pool);
                var out = buf.ngx_chain_t{
                    .buf = core.nullptr(ngx_buf_t),
                    .next = core.nullptr(ngx_chain_t),
                };
                const last = try chain.allocStr(new_body, &out);
                last.*.buf.*.flags.last_buf = true;
                last.*.buf.*.flags.last_in_chain = true;
                r.*.request_body.*.bufs = last;
            }

            // init subrequest to proxy location
            if (core.ngz_pcalloc_c(ngx_str_t, r.*.pool)) |args| {
                _ = try NSubrequest.create(r, &lccf.*.ctx.*.notify, args);
                return NGX_OK;
            }
        }
    }
    return http.NGX_HTTP_SERVICE_UNAVAILABLE;
}

export fn ngx_http_wechatpay_notify_body_handler(r: [*c]ngx_http_request_t) callconv(.C) void {
    const rc = notify(r) catch |e| {
        switch (e) {
            WError.SIGNATURE_ERROR => return http.ngx_http_finalize_request(r, http.NGX_HTTP_UNAUTHORIZED),
            WError.BODY_ERROR => return http.ngx_http_finalize_request(r, http.NGX_HTTP_BAD_REQUEST),
            else => return http.ngx_http_finalize_request(r, http.NGX_HTTP_SERVICE_UNAVAILABLE),
        }
    };
    http.ngx_http_finalize_request(r, rc);
}

export fn ngx_http_wechatpay_notify_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(wechatpay_loc_conf, conf.ngx_http_get_module_loc_conf(r, &ngx_http_wechatpay_module))) |lccf| {
        const rctx = http.ngz_http_get_module_ctx(wechatpay_request_context, r, &ngx_http_wechatpay_module) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        if (rctx.*.lccf == core.nullptr(wechatpay_loc_conf)) {
            rctx.*.lccf = lccf;
        }
        const rc = http.ngx_http_read_client_request_body(r, ngx_http_wechatpay_notify_body_handler);
        return if (rc == NGX_AGAIN) core.NGX_DONE else rc;
    }
    return NGX_OK;
}

///////////////////////////////////////     OAEP HANDLER   //////////////////////////////////////////////////////

fn execute_oaep_action(r: [*c]ngx_http_request_t, ctx: [*c]wechatpay_context) !ngx_int_t {
    const action = ctx.*.action;
    const body = read_body(r);
    if (body.len == 0) {
        return NGX_OK;
    }
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
    if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
        const rc = execute_oaep_action(r, rctx.*.lccf.*.ctx) catch |e| {
            switch (e) {
                core.NError.SSL_ERROR => return http.ngx_http_finalize_request(r, http.NGX_HTTP_BAD_REQUEST),
                else => return http.ngx_http_finalize_request(r, http.NGX_HTTP_INTERNAL_SERVER_ERROR),
            }
        };
        return http.ngx_http_finalize_request(r, rc);
    }
    http.ngx_http_finalize_request(r, http.NGX_HTTP_SERVICE_UNAVAILABLE);
}

export fn ngx_http_wechatpay_oaep_handler(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (core.castPtr(wechatpay_loc_conf, conf.ngx_http_get_module_loc_conf(r, &ngx_http_wechatpay_module))) |lccf| {
        const rctx = http.ngz_http_get_module_ctx(wechatpay_request_context, r, &ngx_http_wechatpay_module) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        if (rctx.*.lccf == core.nullptr(wechatpay_loc_conf)) {
            rctx.*.lccf = lccf;
        }
        const rc = http.ngx_http_read_client_request_body(r, ngx_http_wechatpay_oaep_body_handler);
        return if (rc == NGX_AGAIN) core.NGX_DONE else rc;
    }
    return NGX_OK;
}

export const ngx_http_wechatpay_module_ctx = ngx_http_module_t{
    .preconfiguration = wechatpay_preconfiguration,
    .postconfiguration = wechatpay_postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = wechatpay_create_loc_conf,
    .merge_loc_conf = wechatpay_merge_loc_conf,
};

export const ngx_http_wechatpay_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("wechatpay_proxy_pass"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "proxy"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_apiclient_key_file"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_file_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "apiclient_key"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_apiclient_serial"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "apiclient_serial"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_public_key_file"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_file_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "wechatpay_public_key"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_serial"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "wechatpay_serial"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_mch_id"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "mch_id"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_oaep_encrypt"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "oaep_encrypt"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_oaep_decrypt"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "oaep_decrypt"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("wechatpay_notify_location"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE2,
        .set = conf.ngx_conf_set_keyval_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(wechatpay_loc_conf, "notify_location"),
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_wechatpay_module = ngx.module.make_module(
    @constCast(&ngx_http_wechatpay_commands),
    @constCast(&ngx_http_wechatpay_module_ctx),
);

///////////////////////////////////////    WECHATPAY HEADER FILTER   ////////////////////////////////////////////
fn postconfiguration_filter(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    _ = cf;
    ngx_http_wechatpay_next_header_filter = http.ngx_http_top_header_filter;
    http.ngx_http_top_header_filter = ngx_http_wechatpay_header_filter;
    return NGX_OK;
}

export fn ngx_http_wechatpay_header_filter(r: [*c]ngx_http_request_t) callconv(.C) ngx_int_t {
    if (r.*.upstream != core.nullptr(http.ngx_http_upstream_t) and
        r.*.upstream.*.finalize_request.? == ngx_http_wechatpay_proxy_upstream_finalize_request)
    {
        if (core.castPtr(wechatpay_request_context, r.*.ctx[ngx_http_wechatpay_module.ctx_index])) |rctx| {
            switch (rctx.*.sig_verify) {
                .SIG_VERIFICATION_PENDDING => return NGX_OK,
                .SIG_VERIFICATION_FAILED => {
                    r.*.headers_out.status = http.NGX_HTTP_UNAUTHORIZED;
                    r.*.headers_out.status_line = ngx_string("SIGN VERIFICATION ERROR");
                }, //TODO
                .SIG_VERIFICATION_SUCCESS => {},
            }
        }
    }
    if (ngx_http_wechatpay_next_header_filter) |filter| {
        return filter(r);
    }
    return NGX_OK;
}

export const ngx_http_wechatpay_filter_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration_filter,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = null,
    .merge_loc_conf = null,
};

export const ngx_http_wechatpay_filter_commands = [_]ngx_command_t{
    conf.ngx_null_command,
};

export var ngx_http_wechatpay_filter_module = ngx.module.make_module(
    @constCast(&ngx_http_wechatpay_filter_commands),
    @constCast(&ngx_http_wechatpay_filter_module_ctx),
);

var ngx_http_wechatpay_next_header_filter: http.ngx_http_output_header_filter_pt = null;

const expectEqual = std.testing.expectEqual;
test "wechatpay module" {
    const h1 = is_http(ngx_string("http://abc"));
    try expectEqual(h1.t, true);
    try expectEqual(std.mem.eql(u8, core.slicify(u8, h1.u.data, h1.u.len), "abc"), true);

    const h2 = is_http(ngx_string("https://abcd.com"));
    try expectEqual(h2.t, false);
    try expectEqual(std.mem.eql(u8, core.slicify(u8, h2.u.data, h2.u.len), "abcd.com"), true);

    const h3 = is_http(ngx_string("abcd.com"));
    try expectEqual(h3.t, false);
    try expectEqual(std.mem.eql(u8, core.slicify(u8, h3.u.data, h3.u.len), "abcd.com"), true);
}
