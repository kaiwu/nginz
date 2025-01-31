const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

const NULL = core.NULL;
const u_char = core.u_char;
const nullptr = core.nullptr;
const ngx_str_t = core.ngx_str_t;
const ngx_pool_t = core.ngx_pool_t;

const CRYPTO_malloc_fn = ngx.CRYPTO_malloc_fn;
const CRYPTO_realloc_fn = ngx.CRYPTO_realloc_fn;
const CRYPTO_free_fn = ngx.CRYPTO_free_fn;

const OPENSSL_init_crypto = ngx.OPENSSL_init_crypto;
const CRYPTO_set_mem_functions = ngx.CRYPTO_set_mem_functions;
const OPENSSL_INIT_ADD_ALL_CIPHERS = ngx.OPENSSL_INIT_ADD_ALL_CIPHERS;
const OPENSSL_INIT_ADD_ALL_DIGESTS = ngx.OPENSSL_INIT_ADD_ALL_DIGESTS;
const OPENSSL_INIT_LOAD_CRYPTO_STRINGS = ngx.OPENSSL_INIT_LOAD_CRYPTO_STRINGS;

const RAND_bytes = ngx.RAND_bytes;
const EVP_PKEY_free = ngx.EVP_PKEY_free;
const EVP_PKEY_CTX_new = ngx.EVP_PKEY_CTX_new;
const EVP_PKEY_CTX_free = ngx.EVP_PKEY_CTX_free;

const BIO = ngx.BIO;
const EVP_PKEY = ngx.EVP_PKEY;
const BIO_free = ngx.BIO_free;
const BIO_new_mem_buf = ngx.BIO_new_mem_buf;
const PEM_read_bio_PUBKEY = ngx.PEM_read_bio_PUBKEY;
const PEM_read_bio_PrivateKey = ngx.PEM_read_bio_PrivateKey;

// AES-256-GCM
const EVP_CIPHER_CTX_new = ngx.EVP_CIPHER_CTX_new;
const EVP_CIPHER_CTX_free = ngx.EVP_CIPHER_CTX_free;
const EVP_aes_256_gcm = ngx.EVP_aes_256_gcm;
const EVP_CTRL_GCM_SET_TAG = ngx.EVP_CTRL_GCM_SET_TAG;

const EVP_EncryptInit_ex = ngx.EVP_EncryptInit_ex;
const EVP_EncryptUpdate = ngx.EVP_EncryptUpdate;
const EVP_EncryptFinal_ex = ngx.EVP_EncryptFinal_ex;
const EVP_CIPHER_CTX_ctrl = ngx.EVP_CIPHER_CTX_ctrl;
const EVP_DecryptInit_ex = ngx.EVP_DecryptInit_ex;
const EVP_DecryptUpdate = ngx.EVP_DecryptUpdate;
const EVP_DecryptFinal_ex = ngx.EVP_DecryptFinal_ex;

// RSA-OAEP
const RSA_PKCS1_OAEP_PADDING = ngx.RSA_PKCS1_OAEP_PADDING;
const RSA_PKCS1_PADDING = ngx.RSA_PKCS1_PADDING;
const RSA_NO_PADDING = ngx.RSA_NO_PADDING;
const EVP_PKEY_encrypt_init = ngx.EVP_PKEY_encrypt_init;
const EVP_PKEY_CTX_set_rsa_padding = ngx.EVP_PKEY_CTX_set_rsa_padding;
const EVP_PKEY_encrypt = ngx.EVP_PKEY_encrypt;
const EVP_PKEY_decrypt_init = ngx.EVP_PKEY_decrypt_init;
const EVP_PKEY_decrypt = ngx.EVP_PKEY_decrypt;

// SHA256 DIGEST SIGN/VERIFY
const SHA256_DIGEST_LENGTH = ngx.SHA256_DIGEST_LENGTH;
const EVP_sha256 = ngx.EVP_sha256;
const EVP_MD_CTX = ngx.EVP_MD_CTX;
const EVP_MD_CTX_new = ngx.EVP_MD_CTX_new;
const EVP_MD_CTX_free = ngx.EVP_MD_CTX_free;
const EVP_MD_CTX_reset = ngx.EVP_MD_CTX_reset;
const EVP_DigestVerifyInit = ngx.EVP_DigestVerifyInit;
const EVP_DigestVerifyUpdate = ngx.EVP_DigestVerifyUpdate;
const EVP_DigestVerifyFinal = ngx.EVP_DigestVerifyFinal;
const EVP_DigestSignInit = ngx.EVP_DigestSignInit;
const EVP_DigestSignUpdate = ngx.EVP_DigestSignUpdate;
const EVP_DigestSignFinal = ngx.EVP_DigestSignFinal;

// base64
const EVP_EncodeBlock = ngx.EVP_EncodeBlock;
const EVP_DecodeBlock = ngx.EVP_DecodeBlock;

const ERR_get_error = ngx.ERR_get_error;
const ERR_error_string_n = ngx.ERR_error_string_n;
const ERR_print_errors_cb = ngx.ERR_print_errors_cb;

const ngx_encode_base64 = ngx.ngx_encode_base64;
const ngx_decode_base64 = ngx.ngx_decode_base64;

pub inline fn ngx_base64_encoded_length(len: usize) usize {
    return ((len + 2) / 3) * 4;
}

pub inline fn ngx_base64_decoded_length(len: usize) usize {
    return ((len + 3) / 4) * 3;
}

inline fn not_null(p: ?*anyopaque) bool {
    return p != core.NULL;
}

inline fn is_one(r: c_int) bool {
    return r == 1;
}

inline fn is_zero_or_more(r: c_int) bool {
    return r >= 0;
}

var SSL_ERROR_BUFFER: [256]u8 = undefined;
pub fn sslcall(comptime F: anytype, args: anytype, comptime predicate: anytype) !@TypeOf(@call(.auto, F, args)) {
    const ResultType = @TypeOf(@call(.auto, F, args));
    const result: ResultType = @call(.auto, F, args);

    if (!predicate(result)) {
        // @memset(&SSL_ERROR_BUFFER, 0);
        // ERR_error_string_n(ERR_get_error(), &SSL_ERROR_BUFFER, 256);
        // std.debug.print("{s}\n", .{SSL_ERROR_BUFFER});
        return core.NError.SSL_ERROR;
    } else {
        return result;
    }
}

const NSSL_KEYS = extern struct {
    const Self = @This();
    prv_key_bio: ?*BIO,
    pub_key_bio: ?*BIO,
    prv_key: ?*EVP_PKEY,
    pub_key: ?*EVP_PKEY,
    md_ctx: ?*EVP_MD_CTX,

    pub fn init(prvkey: ngx_str_t, pubkey: ngx_str_t) !Self {
        _ = OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, null);
        const prv_key_bio = try sslcall(BIO_new_mem_buf, .{ prvkey.data, @as(c_int, @intCast(prvkey.len)) }, not_null);
        const pub_key_bio = try sslcall(BIO_new_mem_buf, .{ pubkey.data, @as(c_int, @intCast(pubkey.len)) }, not_null);
        const prv_key = try sslcall(PEM_read_bio_PrivateKey, .{ prv_key_bio, null, null, null }, not_null);
        const pub_key = try sslcall(PEM_read_bio_PUBKEY, .{ pub_key_bio, null, null, null }, not_null);
        const md_ctx = try sslcall(EVP_MD_CTX_new, .{}, not_null);

        return Self{
            .prv_key_bio = prv_key_bio,
            .pub_key_bio = pub_key_bio,
            .prv_key = prv_key,
            .pub_key = pub_key,
            .md_ctx = md_ctx,
        };
    }

    pub fn deinit(self: *Self) void {
        EVP_MD_CTX_free(self.md_ctx);
        EVP_PKEY_free(self.prv_key);
        EVP_PKEY_free(self.pub_key);
        BIO_free(self.prv_key_bio);
        BIO_free(self.pub_key_bio);
    }

    pub fn sign_sha256(self: *Self, msg: ngx_str_t, pool: ngx_pool_t) !ngx_str_t {
        var buf: [256]u8 = undefined;
        var len: usize = buf.len;
        if (core.castPtr(u8, core.ngx_pnalloc(pool, ngx_base64_encoded_length(len)))) |p| {
            _ = try sslcall(EVP_DigestSignInit, .{ self.md_ctx, null, EVP_sha256(), null, self.prv_key }, is_one);
            _ = try sslcall(EVP_DigestSignUpdate, .{ self.md_ctx, msg.data, msg.len }, is_one);
            _ = try sslcall(EVP_DigestSignFinal, .{ self.mdctx, &buf, &len }, is_one);
            const blen = try sslcall(EVP_EncodeBlock, .{ p, &buf, @as(c_int, @intCast(len)) }, is_zero_or_more);
            _ = try sslcall(EVP_MD_CTX_reset, .{self.md_ctx}, is_one);
            return ngx_str_t{ .len = blen, .data = p };
        }
        return core.NError.OOM;
    }

    pub fn verify_sha256(self: *Self, sig: ngx_str_t, pool: ngx_pool_t) !bool {
        if (sig.len == 0) {
            return false;
        }
        var d: usize = 0;
        var i: usize = sig.len - 1;
        while (i > 0 and sig.data[i] == '=') : (i -= 1) {
            d += 1;
        }
        if (core.castPtr(u8, core.ngx_pnalloc(pool, ngx_base64_decoded_length(sig.len)))) |p| {
            defer core.ngx_pfree(p);
            defer _ = EVP_MD_CTX_reset(self.md_ctx);

            const blen = try sslcall(EVP_DecodeBlock, .{ p, sig.data, @as(c_int, @intCast(sig.len)) }, is_zero_or_more);
            _ = try sslcall(EVP_DigestVerifyInit, .{ self.md_ctx, null, EVP_sha256(), null, self.pub_key }, is_one);
            _ = try sslcall(EVP_DigestVerifyUpdate, .{ self.md_ctx, sig.data, sig.len }, is_one);
            _ = try sslcall(EVP_DigestVerifyFinal, .{ self.md_ctx, p, @as(usize, @intCast(blen)) - d }, is_one) catch return false;
            //_ = try sslcall(EVP_MD_CTX_reset, .{self.md_ctx}, is_one);
            return true;
        }

        return core.NError.OOM;
    }
};

test "ssl" {
    const prvkey: []const u8 =
        \\-----BEGIN RSA PRIVATE KEY-----
        \\MIIEogIBAAKCAQEAptpm+qvIDCh/9wjU26SQCK26ogYkBhDrYxnAaw2JbbBsp1oD
        \\bHKk+1r381NeBUG2HEFAuU+Fr72u5ot3yKdzoF/FajAzQNKnm569/D3upKoi8mYB
        \\aST15Uig8j8qoUW1U217LL0jEHlSnHV3lcaDTXqDpTRR4Bfz9IqOgJgFZ8/oTfEo
        \\mSrjrLYef81Eyxr7ZIMQXEKKEK7V4UXKS0+/fDsiG/cXidhzt8UbTL9vqXqxM2+I
        \\DImyO+FAc/tkBG55LmzxPto1Nq0WbnZzRM/wTzrd0I/8NlevxtFbphg4evlHjFNI
        \\7+GrqR87ViEwuAJJ9Je5QQjct5YJfFRWiZ5CMQIDAQABAoIBAGBi/GhEgezcHIg1
        \\ltlHaFlLGuxsRbUnYwM9phVxnXk7GJlYe2/TjpERjPkIqOC6hBwwadZjJORP3FCc
        \\Mtc8PKRhjuZ377O7vU0915x2nnyLOGL1IE2AJ3iLi0ZFzTea0FPgg+5lWHM00s9F
        \\YI6qPcGtS41M+xtMWwZiYE3TBBRibHiY8ugGyaNAhiMKehyW05uApjlIF55wwCGx
        \\BkyESJpGRR/6853iHke6Ge+xVcMa9QmQdoH0QqL/8kT28PL568mJJr0Ow/83t4+d
        \\Pe70YPzKAxgUnaDsHJqO+b8qH69AEs8rTI5h2Mon6pH+bJT66KUoiXhn+Kf+4LSs
        \\henRP10CgYEA1QJSfuFOWVRjrg3N/rAIc/Ak84BTZavbyrkqBSuoTs9i/nMI/hOz
        \\VxpDntg7Bx2Tctl6sZO3GioTxKdc/YYaTKci1TKBbeginpsqEQVgwkMCy8HpvUmR
        \\fyAMqLwZC4h9+j+NiZtuoFJDTCgv+WYbasX+kWYEUM21bnSYuO7yEQsCgYEAyIdP
        \\r9uzqPgzN34Tmx+CNTa16VjhBh+zkBtXRLDLhWBeIYxoYNJARD98Pb1XZdvpkZZW
        \\Sk7MfaKo2/DomzyyyB/MbHWwAdFi3yb4y7uMJfyC1MzdUSNN3Vp579hJxHkJ+nN4
        \\Ys76yfcEeVOLnvUT1Z0KKCdIWRdT1Lgi+X1itzMCgYBJUXlPzwGG4fNFj97d0X23
        \\Wmt9nSgXkOYgi0eZbAOMzPmIF9R6kBFk49dur4Lx2g5Ms+r1gKC/0sfnIqxxX11i
        \\EQ1+UNoYGJUB/uql3TIG68XkmKR50P7RwRhaZBRC0gJ6xrFTMjsL2ATuC88niyvY
        \\vrn3FiRaI9RVZrDCxwxvLQKBgEXW4okEAqGBuAzGqztmkOnJoTehDdYdKmOxMgap
        \\cGiGdKJIjX3THDDoz3ONQyglnEZpTqpYoV3MTfU0BT8zt6x9bqwDnQY1D7NalmIW
        \\cqw0Mri8lQQSQKcsQLWo5aA466G/n5kCL1Qx5OwAjesRvhOyuvvbGpZ0ymyWqQ+t
        \\fLkDAoGATcul1L8y5D/wNVP1GXbXMZfBsFP3bbqy8c+Ashm6g8OLm2mGNntd5Z6h
        \\1KkID7Yksh+dZ6t7XaPBtGACXX5Eryr537JVvdX8hAVCp5HVtaN/9VBVP8Ka2e4s
        \\VS/xeNgOMQ7uzhRPBJ8HiTmdI1nHhDnYQpGiBgQn0Z5RAkSvFMk=
        \\-----END RSA PRIVATE KEY-----
    ;
    const data0 =
        \\GET
        \\/v3/refund/domestic/refunds/123123123123
        \\1554208460
        \\593BEC0C930BF1AFEB40B4A08C8FB242
        \\
        \\
    ;
    const signed0 =
        \\Lc9VXxmeonkdV8Xk9tmigQFLhl0vRWTerdmoRu01aAnYwIrD/5nsSwE1WlmZGLRlAFTNQ3QsMa0+VRDlJp1Wp5p0nO8EK68b5sJBbjouxaFciIfq1zfDWWz+jqhcMoKXI1A6dPm1AW7D4d30WsMTNzp6g23OXakIsh9LO3lUmwvTuE0BY8ncf6tNGk4wKmvXwERd/ZpoQY3MAVKz+Nakwc+2XBmzT66KcUehU5kr4IvGa/lEU5RZb/q00zP9VLdBhC/jQSX3X1UcJLCtEc4gTmib4tnmAT+bHF/e17ZAuxDNcx6rqT8gNEXqaJGG+1OflMSTU2tpyG65G4dMKdFcoA==
    ;

    const data1 =
        \\POST
        \\/v3/pay/transactions/jsapi
        \\1554208460
        \\593BEC0C930BF1AFEB40B4A08C8FB242
        \\{"appid":"wxd678efh567hg6787","mchid":"1230000109","description":"Image形象店-深圳腾大-QQ公仔","out_trade_no":"1217752501201407033233368018","notify_url":"https://www.weixin.qq.com/wxpay/pay.php","amount":{"total":100,"currency":"CNY"},"payer":{"openid":"oUpF8uMuAJO_M2pxb1Q9zNjWeS6o"}}
        \\
    ;

    const signed1 =
        \\gEuexJ547PHFV77TQ6eiE4tphVYfWfUe1Wc2dBmVnoMYU2rl/M4zhw+b3vBhuMw6AC7pteNkryLA7UWU2h+umo0OdSuuLm1++O3NckQPCSfm6dypsjn4GYm84KMqXWFrhFmyxEwIdEJDr3w1UYfxOcu55OQupfLkrt/ZzuOspnliJFrPzGQFUk7lGqMMtpz3EfbDUNxnVsHblORg3hVmuYNmbGWnS2ovU30Y2Q+iKFDxzkaXBk8LTy6HzvxizRo6Q+J4SVM7O0hKXfgo1QdI68kpzNULb3EVBXlhTyPUzhkHzzLxECL1qHl3HH2hEv8++C+4wBlsagF3j/O6PABojA==
    ;

    const data2 =
        \\GET
        \\/v3/marketing/partnerships?limit=5&offset=10&authorized_data%3D%7B%22business_type%22%3A%22FAVOR_STOCK%22%2C%20%22stock_id%22%3A%222433405%22%7D&partner%3D%7B%22type%22%3A%22APPID%22%2C%22appid%22%3A%22wx4e1916a585d1f4e9%22%2C%22merchant_id%22%3A%222480029552%22%7D
        \\1554208460
        \\593BEC0C930BF1AFEB40B4A08C8FB242
        \\
        \\
    ;

    const signed2 =
        \\C9PrZx8RTw7NF+e6SLmZxKgUBdXjH6EmUiu1i85Y6MApfWn4ueNpS4ED5no6uGObU0cfzTdaWyl6gAWDmyO2nG3MjHursadpzpNT8d+HaZapKis+boTHwJLgZXHXtacjX4zx2lOk/AONrKCLkjXRnh/DDp/kNsmDNYEiu+d/SeVvr+cL0XkL0CibAphyQSLYkv7Fh9uel89ax3ZGgVnBx+/MaBLCrYc1UqyYBDqfWPhS9fZf2OSghWMFp9c5dm+ORc97XbgzSOwAl8dcfLSrL/Sb4+L57+JZiq0iURjMXWzAD8FTUFYsJtJOYszRXJKLZNh4WGST39oplhhSdtxcoQ==
    ;

    const data3 =
        \\POST
        \\/v3/marketing/favor/media/image-upload
        \\1554208460
        \\593BEC0C930BF1AFEB40B4A08C8FB242
        \\{ "filename": "wechatpay_logo.png", "sha256": "d2973a45b1d528c21ebb77792ef3fcea40fa9a4e04a17e35369102ba9c84c8b1"}
        \\
    ;

    const signed3 =
        \\oykQTJijZbHL+0QjYjOcwvovGxlU9LMcfVheUUdvr94DIzN02MBwwAwnBMsDqGTnXe0fr7kxFbXz3cd53e7Fx2VU8S9Lt3u1dCMQV+b5Ut6wpReTMBcfSVVXl4AbmLHxvyi1KhVg+O3KGL2BT4dEbuR93voru/p/9CS7gyMSviZiupf1cuaipyTdZ/1Nn4ESeuPX8H7p2nwaxNLbS/rdLltvQGU1ecK0m4u5p4uXh1mdM1Kh8fymJHvkurOzVORoB3Y23g2RUFT0WwNBVxpp19bdAWsqIoouPjyY6tFGD9cnQIVmIbm9oRDrOWmQMHubWlmjYL5UfP39pq1T+/hNpw==
    ;

    const ds = [_][2][]const u8{
        .{ data0, signed0 },
        .{ data1, signed1 },
        .{ data2, signed2 },
        .{ data3, signed3 },
    };
    _ = OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, null);
    const prv_key_bio = try sslcall(BIO_new_mem_buf, .{ prvkey.ptr, prvkey.len }, not_null);
    const prv_key = try sslcall(PEM_read_bio_PrivateKey, .{ prv_key_bio, null, null, null }, not_null);
    const mdctx = try sslcall(EVP_MD_CTX_new, .{}, not_null);

    for (ds) |ds0| {
        var buf: [256]u8 = undefined;
        var len: usize = 256;
        var base64: [((256 + 2) / 3) * 4]u8 = undefined;
        _ = try sslcall(EVP_DigestSignInit, .{ mdctx, null, EVP_sha256(), null, prv_key }, is_one);
        _ = try sslcall(EVP_DigestSignUpdate, .{ mdctx, ds0[0].ptr, ds0[0].len }, is_one);
        _ = try sslcall(EVP_DigestSignFinal, .{ mdctx, &buf, &len }, is_one);
        const blen = try sslcall(EVP_EncodeBlock, .{ &base64, &buf, @as(c_int, @intCast(len)) }, is_zero_or_more);
        try expectEqual(std.mem.eql(u8, ds0[1], core.slicify(u8, &base64, @as(usize, @intCast(blen)))), true);
        _ = try sslcall(EVP_MD_CTX_reset, .{mdctx}, is_one);
    }

    const pubkey4 =
        \\-----BEGIN PUBLIC KEY-----
        \\MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwXNI6sdlknHBnK8Fu2U6
        \\Cwor9qY747jP8KAfeBMeveEt1TqaHkLfaSD07trZLhGpfs8/AHqjhgSMO1O10YQW
        \\OrrJ4hjIWPKqxbgrYMkBQc+mwdiWp4W3ByCqxBRagCveCXRWCmuJYovl9H/bsDI0
        \\iGbpVtEOghJtfciisYSgxcLufUDTRkvwxjIBK1pCRjk33jJ5YTBWTHMRtMAOcFLN
        \\F6hdEYdX8SPsgHHeLZ5Lv2T/686w1xtgCHef/sd4uSfWmyzsalQdHG/e4IyYmrhx
        \\+O3VBoNDzE3nx23bFeV/RVNCG7cV6VhmYokJNHa/erIPkEmEFID6A5wQOXuxUkmJ
        \\WwIDAQAB
        \\-----END PUBLIC KEY-----
    ;

    const data4 =
        \\1722850421
        \\d824f2e086d3c1df967785d13fcd22ef
        \\{"code_url":"weixin://wxpay/bizpayurl?pr=JyC91EIz1"}
        \\
    ;

    const signed4 =
        \\mfI1CPqvBrgcXfgXMFjdNIhBf27ACE2YyeWsWV9ZI7T7RU0vHvbQpu9Z32ogzc+k8ZC5n3kz7h70eWKjgqNdKQF0eRp8mVKlmfzMLBVHbssB9jEZEDXThOX1XFqX7s7ymia1hoHQxQagPGzkdWxtlZPZ4ZPvr1RiqkgAu6Is8MZgXXrRoBKqjmSdrP1N7uxzJ/cjfSiis9FiLjuADoqmQ1P7p2N876YPAol7Rn0+GswwAwxldbdLrmVSjfytfSBJFqTMHn4itojgxSWWN1byuckQt8hSTEv/Lg97QoeGniYP17T80pJeQyL3b+295FPHSO2AtvCgyIbKMZ0BALilAA==
    ;

    const ds_pub = [_][3][]const u8{
        .{ data4, signed4, pubkey4 },
    };

    for (ds_pub) |ds0| {
        const pub_key_bio = try sslcall(BIO_new_mem_buf, .{ ds0[2].ptr, @as(c_int, @intCast(ds0[2].len)) }, not_null);
        const pub_key = try sslcall(PEM_read_bio_PUBKEY, .{ pub_key_bio, null, null, null }, not_null);

        var d: usize = 0;
        var i: usize = ds0[1].len - 1;
        while (i > 0 and ds0[1][i] == '=') : (i -= 1) {
            d += 1;
        }
        const len: usize = ((344 + 3) / 4) * 3;
        var buf: [len]u8 = undefined;
        const blen = try sslcall(EVP_DecodeBlock, .{ &buf, ds0[1].ptr, @as(c_int, @intCast(ds0[1].len)) }, is_zero_or_more);
        _ = try sslcall(EVP_DigestVerifyInit, .{ mdctx, null, EVP_sha256(), null, pub_key }, is_one);
        _ = try sslcall(EVP_DigestVerifyUpdate, .{ mdctx, ds0[0].ptr, ds0[0].len }, is_one);
        _ = try sslcall(EVP_DigestVerifyFinal, .{ mdctx, &buf, @as(usize, @intCast(blen)) - d }, is_one);
        _ = try sslcall(EVP_MD_CTX_reset, .{mdctx}, is_one);
    }
}

// AES-256-GCM
// #include <openssl/evp.h>
// #include <openssl/rand.h>
// #include <openssl/err.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
//
// // 错误处理函数
// void handle_errors() {
//     ERR_print_errors_fp(stderr);
//     abort();
// }
//
// int main() {
//     // 初始化 OpenSSL 库
//     OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NULL);
//
//     // 需要加密的消息
//     const char *plaintext = "Hello, OpenSSL 3.0 AES-256-GCM!";
//     size_t plaintext_len = strlen(plaintext);
//
//     // 密钥和 IV（初始化向量）
//     unsigned char key[32];  // AES-256 需要 32 字节的密钥
//     unsigned char iv[12];   // GCM 需要 12 字节的 IV
//
//     // 生成随机密钥和 IV
//     if (RAND_bytes(key, sizeof(key)) <= 0 || RAND_bytes(iv, sizeof(iv)) <= 0) {
//         handle_errors();
//     }
//
//     // 加密
//     EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
//     if (!ctx) handle_errors();
//
//     int len;
//     int ciphertext_len;
//     unsigned char ciphertext[128];  // 加密后的数据缓冲区
//     unsigned char tag[16];          // GCM 认证标签
//
//     // 初始化加密操作
//     if (EVP_EncryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL) <= 0) {
//         handle_errors();
//     }
//
//     // 设置密钥和 IV
//     if (EVP_EncryptInit_ex(ctx, NULL, NULL, key, iv) <= 0) {
//         handle_errors();
//     }
//
//     // 加密数据
//     if (EVP_EncryptUpdate(ctx, ciphertext, &len, (const unsigned char *)plaintext, plaintext_len) <= 0) {
//         handle_errors();
//     }
//     ciphertext_len = len;
//
//     // 结束加密操作
//     if (EVP_EncryptFinal_ex(ctx, ciphertext + len, &len) <= 0) {
//         handle_errors();
//     }
//     ciphertext_len += len;
//
//     // 获取认证标签
//     if (EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_GET_TAG, 16, tag) <= 0) {
//         handle_errors();
//     }
//
//     // 输出加密后的数据
//     printf("Ciphertext (%d bytes):\n", ciphertext_len);
//     for (int i = 0; i < ciphertext_len; i++) {
//         printf("%02x", ciphertext[i]);
//     }
//     printf("\n");
//
//     // 输出认证标签
//     printf("Tag (16 bytes):\n");
//     for (int i = 0; i < 16; i++) {
//         printf("%02x", tag[i]);
//     }
//     printf("\n");
//
//     // 解密
//     unsigned char decryptedtext[128];  // 解密后的数据缓冲区
//     int decryptedtext_len;
//
//     // 初始化解密操作
//     if (EVP_DecryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL) <= 0) {
//         handle_errors();
//     }
//
//     // 设置密钥和 IV
//     if (EVP_DecryptInit_ex(ctx, NULL, NULL, key, iv) <= 0) {
//         handle_errors();
//     }
//
//     // 解密数据
//     if (EVP_DecryptUpdate(ctx, decryptedtext, &len, ciphertext, ciphertext_len) <= 0) {
//         handle_errors();
//     }
//     decryptedtext_len = len;
//
//     // 设置认证标签
//     if (EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_SET_TAG, 16, tag) <= 0) {
//         handle_errors();
//     }
//
//     // 结束解密操作
//     if (EVP_DecryptFinal_ex(ctx, decryptedtext + len, &len) <= 0) {
//         handle_errors();
//     }
//     decryptedtext_len += len;
//
//     // 输出解密后的数据
//     printf("Decrypted text: %.*s\n", decryptedtext_len, decryptedtext);
//
//     // 释放资源
//     EVP_CIPHER_CTX_free(ctx);
//
//     // 清理 OpenSSL 库
//     EVP_cleanup();
//     ERR_free_strings();
//
//     return 0;
// }

// RSA OAEP
// #include <openssl/evp.h>
// #include <openssl/pem.h>
// #include <openssl/err.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
//
// // 错误处理函数
// void handle_errors() {
//     ERR_print_errors_fp(stderr);
//     abort();
// }
//
// int main() {
//     // 初始化 OpenSSL 库
//     OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NULL);
//
//     // 生成 RSA 密钥对
//     EVP_PKEY *pkey = NULL;
//     EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_id(EVP_PKEY_RSA, NULL);
//     if (!ctx) handle_errors();
//
//     if (EVP_PKEY_keygen_init(ctx) <= 0) handle_errors();
//     if (EVP_PKEY_CTX_set_rsa_keygen_bits(ctx, 2048) <= 0) handle_errors();
//     if (EVP_PKEY_keygen(ctx, &pkey) <= 0) handle_errors();
//
//     // 需要加密的消息
//     const char *message = "Hello, OpenSSL 3.0 RSA-OAEP!";
//     size_t message_len = strlen(message);
//
//     // 加密
//     EVP_PKEY_CTX *enc_ctx = EVP_PKEY_CTX_new(pkey, NULL);
//     if (!enc_ctx) handle_errors();
//
//     if (EVP_PKEY_encrypt_init(enc_ctx) <= 0) handle_errors();
//     if (EVP_PKEY_CTX_set_rsa_padding(enc_ctx, RSA_PKCS1_OAEP_PADDING) <= 0) handle_errors();
//
//     // 获取加密后的长度
//     size_t encrypted_len;
//     if (EVP_PKEY_encrypt(enc_ctx, NULL, &encrypted_len, (const unsigned char *)message, message_len) <= 0) {
//         handle_errors();
//     }
//
//     // 分配加密缓冲区
//     unsigned char *encrypted = (unsigned char *)OPENSSL_malloc(encrypted_len);
//     if (!encrypted) handle_errors();
//
//     // 执行加密
//     if (EVP_PKEY_encrypt(enc_ctx, encrypted, &encrypted_len, (const unsigned char *)message, message_len) <= 0) {
//         handle_errors();
//     }
//
//     // 输出加密后的数据
//     printf("Encrypted data (%zu bytes):\n", encrypted_len);
//     for (size_t i = 0; i < encrypted_len; i++) {
//         printf("%02x", encrypted[i]);
//     }
//     printf("\n");
//
//     // 解密
//     EVP_PKEY_CTX *dec_ctx = EVP_PKEY_CTX_new(pkey, NULL);
//     if (!dec_ctx) handle_errors();
//
//     if (EVP_PKEY_decrypt_init(dec_ctx) <= 0) handle_errors();
//     if (EVP_PKEY_CTX_set_rsa_padding(dec_ctx, RSA_PKCS1_OAEP_PADDING) <= 0) handle_errors();
//
//     // 获取解密后的长度
//     size_t decrypted_len;
//     if (EVP_PKEY_decrypt(dec_ctx, NULL, &decrypted_len, encrypted, encrypted_len) <= 0) {
//         handle_errors();
//     }
//
//     // 分配解密缓冲区
//     unsigned char *decrypted = (unsigned char *)OPENSSL_malloc(decrypted_len);
//     if (!decrypted) handle_errors();
//
//     // 执行解密
//     if (EVP_PKEY_decrypt(dec_ctx, decrypted, &decrypted_len, encrypted, encrypted_len) <= 0) {
//         handle_errors();
//     }
//
//     // 输出解密后的数据
//     printf("Decrypted data: %.*s\n", (int)decrypted_len, decrypted);
//
//     // 释放资源
//     OPENSSL_free(encrypted);
//     OPENSSL_free(decrypted);
//     EVP_PKEY_CTX_free(enc_ctx);
//     EVP_PKEY_CTX_free(dec_ctx);
//     EVP_PKEY_free(pkey);
//     EVP_PKEY_CTX_free(ctx);
//
//     // 清理 OpenSSL 库
//     EVP_cleanup();
//     ERR_free_strings();
//
//     return 0;
// }
