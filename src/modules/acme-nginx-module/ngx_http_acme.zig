const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const ssl = ngx.ssl;

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
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const ngx_null_str = ngx.string.ngx_null_str;

// ============================================================================
// Base64url encoding (RFC 4648 Section 5)
// ============================================================================

// Standard base64 to base64url conversion (in-place)
// Replaces: '+' -> '-', '/' -> '_', removes '=' padding
fn base64_to_base64url(data: []u8) []u8 {
    var len = data.len;

    // Remove padding
    while (len > 0 and data[len - 1] == '=') {
        len -= 1;
    }

    // Replace characters
    for (data[0..len]) |*c| {
        if (c.* == '+') {
            c.* = '-';
        } else if (c.* == '/') {
            c.* = '_';
        }
    }

    return data[0..len];
}

// Base64url to standard base64 conversion
// Replaces: '-' -> '+', '_' -> '/', adds '=' padding
fn base64url_to_base64(data: []u8, out: []u8) []u8 {
    var i: usize = 0;
    for (data) |c| {
        if (c == '-') {
            out[i] = '+';
        } else if (c == '_') {
            out[i] = '/';
        } else {
            out[i] = c;
        }
        i += 1;
    }

    // Add padding
    const padding = (4 - (i % 4)) % 4;
    for (0..padding) |_| {
        out[i] = '=';
        i += 1;
    }

    return out[0..i];
}

// Encode bytes to base64url string (no padding)
pub fn base64url_encode(pool: [*c]ngx_pool_t, input: []const u8) ?ngx_str_t {
    if (input.len == 0) {
        return ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    }

    // Allocate space for base64 (with potential padding)
    const b64_len = ssl.ngx_base64_encoded_length(input.len);
    const buf = core.castPtr(u8, core.ngx_pnalloc(pool, b64_len)) orelse return null;

    // Encode using nginx's base64
    var src = ngx_str_t{ .len = input.len, .data = @constCast(input.ptr) };
    var dst = ngx_str_t{ .len = b64_len, .data = buf };
    ngx.string.ngx_encode_base64(&dst, &src);

    // Convert to base64url (in-place) and remove padding
    const result = base64_to_base64url(core.slicify(u8, dst.data, dst.len));

    return ngx_str_t{ .len = result.len, .data = dst.data };
}

// Decode base64url string to bytes
pub fn base64url_decode(pool: [*c]ngx_pool_t, input: ngx_str_t) ?ngx_str_t {
    if (input.len == 0) {
        return ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    }

    // Need temporary buffer for base64 conversion (with padding)
    const padded_len = input.len + ((4 - (input.len % 4)) % 4);
    const temp = core.castPtr(u8, core.ngx_pnalloc(pool, padded_len)) orelse return null;

    // Convert base64url to base64
    const b64 = base64url_to_base64(core.slicify(u8, input.data, input.len), core.slicify(u8, temp, padded_len));

    // Allocate output buffer
    const out_len = ssl.ngx_base64_decoded_length(b64.len);
    const out = core.castPtr(u8, core.ngx_pnalloc(pool, out_len)) orelse return null;

    // Decode
    var src = ngx_str_t{ .len = b64.len, .data = temp };
    var dst = ngx_str_t{ .len = out_len, .data = out };

    if (ngx.string.ngx_decode_base64(&dst, &src) != NGX_OK) {
        return null;
    }

    return dst;
}

// ============================================================================
// SHA256 hashing
// ============================================================================

pub fn sha256_hash(input: []const u8) [32]u8 {
    var hash: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(input, &hash, .{});
    return hash;
}

// ============================================================================
// JWK Thumbprint (RFC 7638)
// ============================================================================

// For RSA keys, the canonical JWK format is:
// {"e":"<base64url>","kty":"RSA","n":"<base64url>"}
// (keys must be in lexicographic order: e, kty, n)

// Compute thumbprint from RSA public key components
pub fn compute_jwk_thumbprint(pool: [*c]ngx_pool_t, e: []const u8, n: []const u8) ?ngx_str_t {
    // Encode e and n as base64url
    const e_b64 = base64url_encode(pool, e) orelse return null;
    const n_b64 = base64url_encode(pool, n) orelse return null;

    // Build canonical JWK JSON
    // {"e":"...","kty":"RSA","n":"..."}
    const prefix = "{\"e\":\"";
    const mid1 = "\",\"kty\":\"RSA\",\"n\":\"";
    const suffix = "\"}";

    const json_len = prefix.len + e_b64.len + mid1.len + n_b64.len + suffix.len;
    const json_buf = core.castPtr(u8, core.ngx_pnalloc(pool, json_len)) orelse return null;

    var pos: usize = 0;
    @memcpy(json_buf[pos .. pos + prefix.len], prefix);
    pos += prefix.len;
    @memcpy(json_buf[pos .. pos + e_b64.len], core.slicify(u8, e_b64.data, e_b64.len));
    pos += e_b64.len;
    @memcpy(json_buf[pos .. pos + mid1.len], mid1);
    pos += mid1.len;
    @memcpy(json_buf[pos .. pos + n_b64.len], core.slicify(u8, n_b64.data, n_b64.len));
    pos += n_b64.len;
    @memcpy(json_buf[pos .. pos + suffix.len], suffix);

    // SHA256 hash the JSON
    const hash = sha256_hash(core.slicify(u8, json_buf, json_len));

    // Base64url encode the hash
    return base64url_encode(pool, &hash);
}

// ============================================================================
// OpenSSL bindings for RSA key management (via ssl wrapper)
// ============================================================================

const EVP_PKEY = ssl.EVP_PKEY;
const EVP_MD_CTX = ssl.EVP_MD_CTX;
const BIGNUM = ssl.BIGNUM;
const BIO = ssl.BIO;
const RSA = ssl.RSA;

const EVP_RSA_gen = ssl.EVP_RSA_gen;
const EVP_PKEY_free = ssl.EVP_PKEY_free;
const EVP_PKEY_get0_RSA = ssl.EVP_PKEY_get0_RSA;
const RSA_get0_key = ssl.RSA_get0_key;
const BN_num_bytes = ssl.BN_num_bytes;
const BN_bn2bin = ssl.BN_bn2bin;
const BIO_new = ssl.BIO_new;
const BIO_s_mem = ssl.BIO_s_mem;
const BIO_free = ssl.BIO_free;
const BIO_ctrl = ssl.BIO_ctrl;
const BIO_new_mem_buf = ssl.BIO_new_mem_buf;
const PEM_write_bio_PrivateKey = ssl.PEM_write_bio_PrivateKey;
const PEM_read_bio_PrivateKey = ssl.PEM_read_bio_PrivateKey;
const EVP_MD_CTX_new = ssl.EVP_MD_CTX_new;
const EVP_MD_CTX_free = ssl.EVP_MD_CTX_free;
const EVP_MD_CTX_reset = ssl.EVP_MD_CTX_reset;
const EVP_sha256 = ssl.EVP_sha256;
const EVP_DigestSignInit = ssl.EVP_DigestSignInit;
const EVP_DigestSignUpdate = ssl.EVP_DigestSignUpdate;
const EVP_DigestSignFinal = ssl.EVP_DigestSignFinal;
const OPENSSL_init_crypto = ssl.OPENSSL_init_crypto;
const OPENSSL_INIT_ADD_ALL_CIPHERS = ssl.OPENSSL_INIT_ADD_ALL_CIPHERS;
const OPENSSL_INIT_ADD_ALL_DIGESTS = ssl.OPENSSL_INIT_ADD_ALL_DIGESTS;
const OPENSSL_INIT_LOAD_CRYPTO_STRINGS = ssl.OPENSSL_INIT_LOAD_CRYPTO_STRINGS;
const BIO_CTRL_INFO = ssl.BIO_CTRL_INFO;

// ============================================================================
// RSA Account Key Management
// ============================================================================

pub const AcmeAccountKey = struct {
    const Self = @This();

    pkey: ?*EVP_PKEY,
    md_ctx: ?*EVP_MD_CTX,

    // Public key components (for JWK)
    e_bytes: []u8,
    n_bytes: []u8,

    pub fn generate(pool: [*c]ngx_pool_t) !Self {
        _ = OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, null);

        // Generate 2048-bit RSA key
        const pkey = EVP_RSA_gen(2048) orelse return error.KeyGenFailed;

        // Create MD context for signing
        const md_ctx = EVP_MD_CTX_new() orelse {
            EVP_PKEY_free(pkey);
            return error.ContextFailed;
        };

        // Extract public key components
        const key = try extractKeyComponents(pkey, pool);

        return Self{
            .pkey = pkey,
            .md_ctx = md_ctx,
            .e_bytes = key.e,
            .n_bytes = key.n,
        };
    }

    pub fn loadFromPem(pem: ngx_str_t, pool: [*c]ngx_pool_t) !Self {
        _ = OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, null);

        const bio = BIO_new_mem_buf(pem.data, @intCast(pem.len)) orelse return error.BioFailed;
        defer _ = BIO_free(bio);

        const pkey = PEM_read_bio_PrivateKey(bio, null, null, null) orelse return error.PemParseFailed;

        const md_ctx = EVP_MD_CTX_new() orelse {
            EVP_PKEY_free(pkey);
            return error.ContextFailed;
        };

        const key = try extractKeyComponents(pkey, pool);

        return Self{
            .pkey = pkey,
            .md_ctx = md_ctx,
            .e_bytes = key.e,
            .n_bytes = key.n,
        };
    }

    fn extractKeyComponents(pkey: *EVP_PKEY, pool: [*c]ngx_pool_t) !struct { e: []u8, n: []u8 } {
        const rsa = EVP_PKEY_get0_RSA(pkey) orelse return error.NotRsaKey;

        var n_bn: ?*const BIGNUM = null;
        var e_bn: ?*const BIGNUM = null;
        RSA_get0_key(rsa, &n_bn, &e_bn, null);

        if (n_bn == null or e_bn == null) return error.KeyComponentsFailed;

        // Get sizes
        const n_size: usize = @intCast(BN_num_bytes(n_bn));
        const e_size: usize = @intCast(BN_num_bytes(e_bn));

        // Allocate buffers
        const n_buf = core.castPtr(u8, core.ngx_pnalloc(pool, n_size)) orelse return error.AllocFailed;
        const e_buf = core.castPtr(u8, core.ngx_pnalloc(pool, e_size)) orelse return error.AllocFailed;

        // Extract bytes
        _ = BN_bn2bin(n_bn, n_buf);
        _ = BN_bn2bin(e_bn, e_buf);

        return .{
            .e = core.slicify(u8, e_buf, e_size),
            .n = core.slicify(u8, n_buf, n_size),
        };
    }

    pub fn toPem(self: *Self, pool: [*c]ngx_pool_t) !ngx_str_t {
        const bio = BIO_new(BIO_s_mem()) orelse return error.BioFailed;
        defer _ = BIO_free(bio);

        if (PEM_write_bio_PrivateKey(bio, self.pkey, null, null, 0, null, null) != 1) {
            return error.PemWriteFailed;
        }

        // Get the PEM data from BIO
        var data: [*c]u8 = undefined;
        const len = BIO_ctrl(bio, BIO_CTRL_INFO, 0, @ptrCast(&data));

        if (len <= 0) return error.BioEmpty;

        // Copy to pool
        const pem_buf = core.castPtr(u8, core.ngx_pnalloc(pool, @intCast(len))) orelse return error.AllocFailed;
        @memcpy(core.slicify(u8, pem_buf, @intCast(len)), core.slicify(u8, data, @intCast(len)));

        return ngx_str_t{ .len = @intCast(len), .data = pem_buf };
    }

    pub fn getThumbprint(self: *Self, pool: [*c]ngx_pool_t) ?ngx_str_t {
        return compute_jwk_thumbprint(pool, self.e_bytes, self.n_bytes);
    }

    pub fn signRs256(self: *Self, message: []const u8, pool: [*c]ngx_pool_t) !ngx_str_t {
        // RS256 signature buffer (max 256 bytes for 2048-bit key)
        var sig_buf: [256]u8 = undefined;
        var sig_len: usize = sig_buf.len;

        defer _ = EVP_MD_CTX_reset(self.md_ctx);

        if (EVP_DigestSignInit(self.md_ctx, null, EVP_sha256(), null, self.pkey) != 1) {
            return error.SignInitFailed;
        }

        if (EVP_DigestSignUpdate(self.md_ctx, message.ptr, message.len) != 1) {
            return error.SignUpdateFailed;
        }

        if (EVP_DigestSignFinal(self.md_ctx, &sig_buf, &sig_len) != 1) {
            return error.SignFinalFailed;
        }

        // Base64url encode the signature
        return base64url_encode(pool, sig_buf[0..sig_len]) orelse error.EncodeFailed;
    }

    pub fn deinit(self: *Self) void {
        if (self.md_ctx) |ctx| EVP_MD_CTX_free(ctx);
        if (self.pkey) |key| EVP_PKEY_free(key);
        self.pkey = null;
        self.md_ctx = null;
    }
};

// ============================================================================
// JWS (JSON Web Signature) for ACME - RFC 7515
// ============================================================================

// JWS format for ACME:
// {
//   "protected": base64url({"alg":"RS256","nonce":"...","url":"...","kid":"..."})
//   "payload": base64url(payload_json) or "" for POST-as-GET
//   "signature": base64url(RS256(protected.payload))
// }

pub fn createJws(
    pool: [*c]ngx_pool_t,
    account_key: *AcmeAccountKey,
    nonce: ngx_str_t,
    url: ngx_str_t,
    kid: ?ngx_str_t, // account URL, null for new account (use jwk instead)
    payload: ?ngx_str_t, // null for POST-as-GET
) !ngx_str_t {
    // Build protected header
    const protected = try buildProtectedHeader(pool, account_key, nonce, url, kid);
    const protected_b64 = base64url_encode(pool, core.slicify(u8, protected.data, protected.len)) orelse return error.EncodeFailed;

    // Encode payload (or empty string for POST-as-GET)
    var payload_b64: ngx_str_t = undefined;
    if (payload) |p| {
        payload_b64 = base64url_encode(pool, core.slicify(u8, p.data, p.len)) orelse return error.EncodeFailed;
    } else {
        payload_b64 = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    }

    // Create signing input: protected.payload
    const signing_input_len = protected_b64.len + 1 + payload_b64.len;
    const signing_input = core.castPtr(u8, core.ngx_pnalloc(pool, signing_input_len)) orelse return error.AllocFailed;

    var pos: usize = 0;
    @memcpy(signing_input[pos .. pos + protected_b64.len], core.slicify(u8, protected_b64.data, protected_b64.len));
    pos += protected_b64.len;
    signing_input[pos] = '.';
    pos += 1;
    if (payload_b64.len > 0) {
        @memcpy(signing_input[pos .. pos + payload_b64.len], core.slicify(u8, payload_b64.data, payload_b64.len));
    }

    // Sign
    const signature = try account_key.signRs256(core.slicify(u8, signing_input, signing_input_len), pool);

    // Build JWS JSON
    return buildJwsJson(pool, protected_b64, payload_b64, signature);
}

fn buildProtectedHeader(
    pool: [*c]ngx_pool_t,
    account_key: *AcmeAccountKey,
    nonce: ngx_str_t,
    url: ngx_str_t,
    kid: ?ngx_str_t,
) !ngx_str_t {
    // Calculate size
    // {"alg":"RS256","nonce":"...","url":"...", "kid":"..."} or
    // {"alg":"RS256","jwk":{...},"nonce":"...","url":"..."}

    if (kid) |k| {
        // With kid (existing account)
        const template = "{\"alg\":\"RS256\",\"kid\":\"";
        const mid1 = "\",\"nonce\":\"";
        const mid2 = "\",\"url\":\"";
        const suffix = "\"}";

        const len = template.len + k.len + mid1.len + nonce.len + mid2.len + url.len + suffix.len;
        const buf = core.castPtr(u8, core.ngx_pnalloc(pool, len)) orelse return error.AllocFailed;

        var pos: usize = 0;
        @memcpy(buf[pos .. pos + template.len], template);
        pos += template.len;
        @memcpy(buf[pos .. pos + k.len], core.slicify(u8, k.data, k.len));
        pos += k.len;
        @memcpy(buf[pos .. pos + mid1.len], mid1);
        pos += mid1.len;
        @memcpy(buf[pos .. pos + nonce.len], core.slicify(u8, nonce.data, nonce.len));
        pos += nonce.len;
        @memcpy(buf[pos .. pos + mid2.len], mid2);
        pos += mid2.len;
        @memcpy(buf[pos .. pos + url.len], core.slicify(u8, url.data, url.len));
        pos += url.len;
        @memcpy(buf[pos .. pos + suffix.len], suffix);

        return ngx_str_t{ .len = len, .data = buf };
    } else {
        // With JWK (new account registration)
        const e_b64 = base64url_encode(pool, account_key.e_bytes) orelse return error.EncodeFailed;
        const n_b64 = base64url_encode(pool, account_key.n_bytes) orelse return error.EncodeFailed;

        const template = "{\"alg\":\"RS256\",\"jwk\":{\"e\":\"";
        const mid1 = "\",\"kty\":\"RSA\",\"n\":\"";
        const mid2 = "\"},\"nonce\":\"";
        const mid3 = "\",\"url\":\"";
        const suffix = "\"}";

        const len = template.len + e_b64.len + mid1.len + n_b64.len + mid2.len + nonce.len + mid3.len + url.len + suffix.len;
        const buf = core.castPtr(u8, core.ngx_pnalloc(pool, len)) orelse return error.AllocFailed;

        var pos: usize = 0;
        @memcpy(buf[pos .. pos + template.len], template);
        pos += template.len;
        @memcpy(buf[pos .. pos + e_b64.len], core.slicify(u8, e_b64.data, e_b64.len));
        pos += e_b64.len;
        @memcpy(buf[pos .. pos + mid1.len], mid1);
        pos += mid1.len;
        @memcpy(buf[pos .. pos + n_b64.len], core.slicify(u8, n_b64.data, n_b64.len));
        pos += n_b64.len;
        @memcpy(buf[pos .. pos + mid2.len], mid2);
        pos += mid2.len;
        @memcpy(buf[pos .. pos + nonce.len], core.slicify(u8, nonce.data, nonce.len));
        pos += nonce.len;
        @memcpy(buf[pos .. pos + mid3.len], mid3);
        pos += mid3.len;
        @memcpy(buf[pos .. pos + url.len], core.slicify(u8, url.data, url.len));
        pos += url.len;
        @memcpy(buf[pos .. pos + suffix.len], suffix);

        return ngx_str_t{ .len = len, .data = buf };
    }
}

fn buildJwsJson(
    pool: [*c]ngx_pool_t,
    protected: ngx_str_t,
    payload: ngx_str_t,
    signature: ngx_str_t,
) !ngx_str_t {
    const prefix = "{\"protected\":\"";
    const mid1 = "\",\"payload\":\"";
    const mid2 = "\",\"signature\":\"";
    const suffix = "\"}";

    const len = prefix.len + protected.len + mid1.len + payload.len + mid2.len + signature.len + suffix.len;
    const buf = core.castPtr(u8, core.ngx_pnalloc(pool, len)) orelse return error.AllocFailed;

    var pos: usize = 0;
    @memcpy(buf[pos .. pos + prefix.len], prefix);
    pos += prefix.len;
    @memcpy(buf[pos .. pos + protected.len], core.slicify(u8, protected.data, protected.len));
    pos += protected.len;
    @memcpy(buf[pos .. pos + mid1.len], mid1);
    pos += mid1.len;
    if (payload.len > 0) {
        @memcpy(buf[pos .. pos + payload.len], core.slicify(u8, payload.data, payload.len));
        pos += payload.len;
    }
    @memcpy(buf[pos .. pos + mid2.len], mid2);
    pos += mid2.len;
    @memcpy(buf[pos .. pos + signature.len], core.slicify(u8, signature.data, signature.len));
    pos += signature.len;
    @memcpy(buf[pos .. pos + suffix.len], suffix);

    return ngx_str_t{ .len = len, .data = buf };
}

// ============================================================================
// Config Structures
// ============================================================================

pub const acme_main_conf = extern struct {
    enabled: ngx_flag_t,
    directory_url: ngx_str_t,
    account_email: ngx_str_t,
    storage_path: ngx_str_t,
    renew_before_days: ngx_uint_t,

    // Computed thumbprint (set after account key is loaded)
    account_thumbprint: ngx_str_t,
};

pub const acme_srv_conf = extern struct {
    domain: ngx_str_t,
};

// ============================================================================
// Challenge Storage
// ============================================================================

// Active challenge entry
pub const acme_challenge_t = struct {
    token: ngx_str_t,
    key_authorization: ngx_str_t,
    domain: ngx_str_t,
    expires: ngx_msec_t,
};

// Simple challenge storage (for now, array-based; can upgrade to rbtree later)
const MAX_CHALLENGES = 32;
var challenges: [MAX_CHALLENGES]?acme_challenge_t = [_]?acme_challenge_t{null} ** MAX_CHALLENGES;
var challenge_count: usize = 0;

pub fn add_challenge(token: ngx_str_t, key_auth: ngx_str_t, domain: ngx_str_t, expires: ngx_msec_t) bool {
    if (challenge_count >= MAX_CHALLENGES) {
        // Try to remove expired challenges first
        cleanup_expired_challenges();
        if (challenge_count >= MAX_CHALLENGES) {
            return false;
        }
    }

    for (&challenges) |*slot| {
        if (slot.* == null) {
            slot.* = acme_challenge_t{
                .token = token,
                .key_authorization = key_auth,
                .domain = domain,
                .expires = expires,
            };
            challenge_count += 1;
            return true;
        }
    }
    return false;
}

pub fn find_challenge(token: []const u8) ?*const acme_challenge_t {
    for (&challenges) |*slot| {
        if (slot.*) |*ch| {
            if (ch.token.len == token.len) {
                if (std.mem.eql(u8, core.slicify(u8, ch.token.data, ch.token.len), token)) {
                    return ch;
                }
            }
        }
    }
    return null;
}

pub fn remove_challenge(token: []const u8) void {
    for (&challenges) |*slot| {
        if (slot.*) |ch| {
            if (ch.token.len == token.len) {
                if (std.mem.eql(u8, core.slicify(u8, ch.token.data, ch.token.len), token)) {
                    slot.* = null;
                    challenge_count -= 1;
                    return;
                }
            }
        }
    }
}

// External variable for current time (only used at runtime, not in tests)
extern var ngx_current_msec: ngx_msec_t;

fn cleanup_expired_challenges() void {
    // Note: ngx_current_msec is only available at nginx runtime
    // During tests, we use maxInt for expires so this won't affect tests
    const now = ngx_current_msec;
    for (&challenges) |*slot| {
        if (slot.*) |ch| {
            if (ch.expires < now) {
                slot.* = null;
                challenge_count -= 1;
            }
        }
    }
}

// ============================================================================
// Configuration Functions
// ============================================================================

fn create_main_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    const p = core.ngz_pcalloc_c(acme_main_conf, cf.*.pool) orelse return null;
    p.*.enabled = conf.NGX_CONF_UNSET;
    p.*.renew_before_days = conf.NGX_CONF_UNSET_UINT;
    return p;
}

fn init_main_conf(cf: [*c]ngx_conf_t, c: ?*anyopaque) callconv(.c) [*c]u8 {
    _ = cf;
    const mcf = core.castPtr(acme_main_conf, c) orelse return conf.NGX_CONF_ERROR;

    if (mcf.*.enabled == conf.NGX_CONF_UNSET) {
        mcf.*.enabled = 0;
    }

    if (mcf.*.renew_before_days == conf.NGX_CONF_UNSET_UINT) {
        mcf.*.renew_before_days = 30;
    }

    // Default ACME server (Let's Encrypt production)
    if (mcf.*.directory_url.len == 0) {
        mcf.*.directory_url = ngx_string("https://acme-v02.api.letsencrypt.org/directory");
    }

    // Default storage path
    if (mcf.*.storage_path.len == 0) {
        mcf.*.storage_path = ngx_string("/etc/nginx/acme");
    }

    return conf.NGX_CONF_OK;
}

fn create_srv_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    const p = core.ngz_pcalloc_c(acme_srv_conf, cf.*.pool) orelse return null;
    return p;
}

// ============================================================================
// HTTP-01 Challenge Handler
// ============================================================================

const ACME_CHALLENGE_PREFIX = "/.well-known/acme-challenge/";

fn is_acme_challenge_uri(uri: ngx_str_t) bool {
    if (uri.len <= ACME_CHALLENGE_PREFIX.len) {
        return false;
    }
    const prefix = core.slicify(u8, uri.data, ACME_CHALLENGE_PREFIX.len);
    return std.mem.eql(u8, prefix, ACME_CHALLENGE_PREFIX);
}

fn extract_token(uri: ngx_str_t) ?[]const u8 {
    if (uri.len <= ACME_CHALLENGE_PREFIX.len) {
        return null;
    }

    const token_start = ACME_CHALLENGE_PREFIX.len;
    const token = core.slicify(u8, uri.data + token_start, uri.len - token_start);

    // Validate token: should only contain base64url characters
    for (token) |c| {
        if (!((c >= 'a' and c <= 'z') or
            (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or
            c == '-' or c == '_'))
        {
            return null;
        }
    }

    if (token.len == 0) {
        return null;
    }

    return token;
}

export fn ngx_http_acme_challenge_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    // Check if this is an ACME challenge request
    if (!is_acme_challenge_uri(r.*.uri)) {
        return NGX_DECLINED;
    }

    // Get server config to check if acme_domain is set
    const scf = core.castPtr(acme_srv_conf, conf.ngx_http_get_module_srv_conf(r, &ngx_http_acme_module)) orelse {
        return NGX_DECLINED;
    };

    // Only handle challenges for servers with acme_domain configured
    if (scf.*.domain.len == 0) {
        return NGX_DECLINED;
    }

    // Extract token from URI
    const token = extract_token(r.*.uri) orelse {
        return http.NGX_HTTP_NOT_FOUND;
    };

    // Look up challenge
    const challenge = find_challenge(token) orelse {
        return http.NGX_HTTP_NOT_FOUND;
    };

    // Send response
    return send_challenge_response(r, challenge.key_authorization);
}

const NChain = ngx.buf.NChain;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;

fn send_challenge_response(r: [*c]ngx_http_request_t, key_auth: ngx_str_t) ngx_int_t {
    // Set response headers
    r.*.headers_out.status = 200;
    r.*.headers_out.content_type = ngx_string("text/plain");
    r.*.headers_out.content_type_len = 10;
    r.*.headers_out.content_length_n = @intCast(key_auth.len);

    // Send header
    const rc = http.ngx_http_send_header(r);
    if (rc == NGX_ERROR or rc > NGX_OK or r.*.flags1.header_only) {
        return rc;
    }

    // Create buffer for body using NChain helper
    var chain = NChain.init(r.*.pool);
    var out = ngx_chain_t{
        .buf = core.nullptr(ngx_buf_t),
        .next = core.nullptr(ngx_chain_t),
    };

    _ = chain.allocStr(key_auth, &out) catch {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    };

    // Mark as last buffer
    if (out.next != core.nullptr(ngx_chain_t) and out.next.*.buf != core.nullptr(ngx_buf_t)) {
        out.next.*.buf.*.flags.last_buf = true;
        out.next.*.buf.*.flags.last_in_chain = true;
    }

    return http.ngx_http_output_filter(r, out.next);
}

// ============================================================================
// Module Registration
// ============================================================================

extern var ngx_http_core_module: ngx_module_t;

const NArray = ngx.array.NArray;

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register handler in CONTENT phase (early, to intercept challenges)
    const cmcf = core.castPtr(http.ngx_http_core_main_conf_t, conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module)) orelse {
        return NGX_ERROR;
    };

    var handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[http.NGX_HTTP_CONTENT_PHASE].handlers,
    );
    const h = handlers.append() catch return NGX_ERROR;
    h.* = ngx_http_acme_challenge_handler;

    return NGX_OK;
}

export const ngx_http_acme_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = create_main_conf,
    .init_main_conf = init_main_conf,
    .create_srv_conf = create_srv_conf,
    .merge_srv_conf = null,
    .create_loc_conf = null,
    .merge_loc_conf = null,
};

export const ngx_http_acme_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("acme"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = @offsetOf(acme_main_conf, "enabled"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_server"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = @offsetOf(acme_main_conf, "directory_url"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_email"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = @offsetOf(acme_main_conf, "account_email"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_storage"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = @offsetOf(acme_main_conf, "storage_path"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_domain"),
        .type = conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = @offsetOf(acme_srv_conf, "domain"),
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_acme_module = ngx.module.make_module(
    @constCast(&ngx_http_acme_commands),
    @constCast(&ngx_http_acme_module_ctx),
);

// ============================================================================
// Unit Tests
// ============================================================================

const ngx_log_init = core.ngx_log_init;
const ngx_create_pool = core.ngx_create_pool;
const ngx_destroy_pool = core.ngx_destroy_pool;

test "base64url encode" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(4096, nlog);
    defer ngx_destroy_pool(pool);

    // Test vectors from RFC 4648
    {
        const result = base64url_encode(pool, "");
        try std.testing.expect(result != null);
        try std.testing.expectEqual(result.?.len, 0);
    }
    {
        const result = base64url_encode(pool, "f");
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("Zg", core.slicify(u8, result.?.data, result.?.len));
    }
    {
        const result = base64url_encode(pool, "fo");
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("Zm8", core.slicify(u8, result.?.data, result.?.len));
    }
    {
        const result = base64url_encode(pool, "foo");
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("Zm9v", core.slicify(u8, result.?.data, result.?.len));
    }
    {
        const result = base64url_encode(pool, "foob");
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("Zm9vYg", core.slicify(u8, result.?.data, result.?.len));
    }
    {
        const result = base64url_encode(pool, "fooba");
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("Zm9vYmE", core.slicify(u8, result.?.data, result.?.len));
    }
    {
        const result = base64url_encode(pool, "foobar");
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("Zm9vYmFy", core.slicify(u8, result.?.data, result.?.len));
    }
}

test "base64url encode with special chars" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(4096, nlog);
    defer ngx_destroy_pool(pool);

    // Test data that would produce + and / in standard base64
    // 0xfb, 0xff -> standard base64: "+/8" -> base64url: "-_8"
    const input = [_]u8{ 0xfb, 0xff };
    const result = base64url_encode(pool, &input);
    try std.testing.expect(result != null);

    const output = core.slicify(u8, result.?.data, result.?.len);
    // Should not contain + or /
    for (output) |c| {
        try std.testing.expect(c != '+');
        try std.testing.expect(c != '/');
    }
    // Should contain - or _ (the base64url replacements)
    try std.testing.expectEqualStrings("-_8", output);
}

test "base64url decode" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(4096, nlog);
    defer ngx_destroy_pool(pool);

    {
        const result = base64url_decode(pool, ngx_string("Zm9vYmFy"));
        try std.testing.expect(result != null);
        try std.testing.expectEqualStrings("foobar", core.slicify(u8, result.?.data, result.?.len));
    }
    {
        // With URL-safe chars
        const result = base64url_decode(pool, ngx_string("-_8"));
        try std.testing.expect(result != null);
        try std.testing.expectEqualSlices(u8, &[_]u8{ 0xfb, 0xff }, core.slicify(u8, result.?.data, result.?.len));
    }
}

test "sha256 hash" {
    // Test vector: SHA256("") = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
    const hash_empty = sha256_hash("");
    try std.testing.expectEqual(hash_empty[0], 0xe3);
    try std.testing.expectEqual(hash_empty[1], 0xb0);
    try std.testing.expectEqual(hash_empty[31], 0x55);

    // Test vector: SHA256("abc") = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
    const hash_abc = sha256_hash("abc");
    try std.testing.expectEqual(hash_abc[0], 0xba);
    try std.testing.expectEqual(hash_abc[1], 0x78);
    try std.testing.expectEqual(hash_abc[31], 0xad);
}

test "is_acme_challenge_uri" {
    try std.testing.expect(is_acme_challenge_uri(ngx_string("/.well-known/acme-challenge/abc123")));
    try std.testing.expect(is_acme_challenge_uri(ngx_string("/.well-known/acme-challenge/a")));
    try std.testing.expect(!is_acme_challenge_uri(ngx_string("/.well-known/acme-challenge/")));
    try std.testing.expect(!is_acme_challenge_uri(ngx_string("/.well-known/acme-challenge")));
    try std.testing.expect(!is_acme_challenge_uri(ngx_string("/other/path")));
    try std.testing.expect(!is_acme_challenge_uri(ngx_string("")));
}

test "extract_token" {
    {
        const token = extract_token(ngx_string("/.well-known/acme-challenge/abc123"));
        try std.testing.expect(token != null);
        try std.testing.expectEqualStrings("abc123", token.?);
    }
    {
        const token = extract_token(ngx_string("/.well-known/acme-challenge/abc-123_XYZ"));
        try std.testing.expect(token != null);
        try std.testing.expectEqualStrings("abc-123_XYZ", token.?);
    }
    {
        // Invalid: contains path traversal
        const token = extract_token(ngx_string("/.well-known/acme-challenge/../etc/passwd"));
        try std.testing.expect(token == null);
    }
    {
        // Invalid: empty token
        const token = extract_token(ngx_string("/.well-known/acme-challenge/"));
        try std.testing.expect(token == null);
    }
}

test "challenge storage" {
    // Clear any existing challenges
    for (&challenges) |*slot| {
        slot.* = null;
    }
    challenge_count = 0;

    // Add a challenge
    const token1 = ngx_string("token1");
    const key_auth1 = ngx_string("token1.thumbprint123");
    const domain1 = ngx_string("example.com");

    const added = add_challenge(token1, key_auth1, domain1, std.math.maxInt(ngx_msec_t));
    try std.testing.expect(added);
    try std.testing.expectEqual(challenge_count, 1);

    // Find the challenge
    const found = find_challenge("token1");
    try std.testing.expect(found != null);
    try std.testing.expectEqualStrings("token1.thumbprint123", core.slicify(u8, found.?.key_authorization.data, found.?.key_authorization.len));

    // Not found
    const not_found = find_challenge("token2");
    try std.testing.expect(not_found == null);

    // Remove the challenge
    remove_challenge("token1");
    try std.testing.expectEqual(challenge_count, 0);

    const after_remove = find_challenge("token1");
    try std.testing.expect(after_remove == null);
}

test "jwk thumbprint" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(4096, nlog);
    defer ngx_destroy_pool(pool);

    // Test with known RSA key components
    // e = 65537 (0x010001) - standard RSA exponent
    // n = some test modulus
    const e = [_]u8{ 0x01, 0x00, 0x01 };
    const n = [_]u8{ 0x00, 0xc5, 0x73, 0x48 }; // Truncated for test

    const thumbprint = compute_jwk_thumbprint(pool, &e, &n);
    try std.testing.expect(thumbprint != null);

    // Thumbprint should be base64url encoded (43 chars for SHA256)
    try std.testing.expectEqual(thumbprint.?.len, 43);

    // Should only contain base64url characters
    for (core.slicify(u8, thumbprint.?.data, thumbprint.?.len)) |c| {
        try std.testing.expect((c >= 'a' and c <= 'z') or
            (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or
            c == '-' or c == '_');
    }
}

test "RSA key generation" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(8192, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a new RSA key
    var key = AcmeAccountKey.generate(pool) catch |err| {
        std.debug.print("Key generation failed: {}\n", .{err});
        return error.TestFailed;
    };
    defer key.deinit();

    // Verify key components are populated
    try std.testing.expect(key.e_bytes.len > 0);
    try std.testing.expect(key.n_bytes.len > 0);

    // e should be 65537 (0x010001) for standard RSA
    try std.testing.expectEqual(key.e_bytes.len, 3);
    try std.testing.expectEqual(key.e_bytes[0], 0x01);
    try std.testing.expectEqual(key.e_bytes[1], 0x00);
    try std.testing.expectEqual(key.e_bytes[2], 0x01);

    // n should be 256 bytes for 2048-bit key
    try std.testing.expectEqual(key.n_bytes.len, 256);
}

test "RSA key to PEM and back" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(16384, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a key
    var key = AcmeAccountKey.generate(pool) catch return error.TestFailed;
    defer key.deinit();

    // Convert to PEM
    const pem = key.toPem(pool) catch return error.TestFailed;

    // Verify PEM format
    try std.testing.expect(pem.len > 0);
    const pem_str = core.slicify(u8, pem.data, pem.len);
    try std.testing.expect(std.mem.startsWith(u8, pem_str, "-----BEGIN PRIVATE KEY-----") or
        std.mem.startsWith(u8, pem_str, "-----BEGIN RSA PRIVATE KEY-----"));

    // Load from PEM
    var loaded_key = AcmeAccountKey.loadFromPem(pem, pool) catch return error.TestFailed;
    defer loaded_key.deinit();

    // Verify key components match
    try std.testing.expectEqualSlices(u8, key.e_bytes, loaded_key.e_bytes);
    try std.testing.expectEqualSlices(u8, key.n_bytes, loaded_key.n_bytes);
}

test "RSA signing" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(8192, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a key
    var key = AcmeAccountKey.generate(pool) catch return error.TestFailed;
    defer key.deinit();

    // Sign a message
    const message = "test message to sign";
    const signature = key.signRs256(message, pool) catch return error.TestFailed;

    // Signature should be base64url encoded
    try std.testing.expect(signature.len > 0);

    // For 2048-bit RSA, signature is 256 bytes, base64url encoded = ~342 chars
    try std.testing.expect(signature.len > 300);
    try std.testing.expect(signature.len < 400);

    // Should only contain base64url characters
    for (core.slicify(u8, signature.data, signature.len)) |c| {
        try std.testing.expect((c >= 'a' and c <= 'z') or
            (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or
            c == '-' or c == '_');
    }
}

test "RSA thumbprint" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(8192, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a key
    var key = AcmeAccountKey.generate(pool) catch return error.TestFailed;
    defer key.deinit();

    // Get thumbprint
    const thumbprint = key.getThumbprint(pool);
    try std.testing.expect(thumbprint != null);

    // Thumbprint should be 43 chars (base64url of SHA256)
    try std.testing.expectEqual(thumbprint.?.len, 43);
}

test "JWS creation with kid" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(16384, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a key
    var key = AcmeAccountKey.generate(pool) catch return error.TestFailed;
    defer key.deinit();

    // Create JWS with kid (existing account)
    const nonce = ngx_string("test-nonce-12345");
    const url = ngx_string("https://acme.example.com/new-order");
    const kid = ngx_string("https://acme.example.com/acct/12345");
    const payload = ngx_string("{\"identifiers\":[{\"type\":\"dns\",\"value\":\"example.com\"}]}");

    const jws = createJws(pool, &key, nonce, url, kid, payload) catch return error.TestFailed;

    // Verify JWS structure
    const jws_str = core.slicify(u8, jws.data, jws.len);

    // Should contain required fields
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"protected\":\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"payload\":\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"signature\":\"") != null);

    // Should start with { and end with }
    try std.testing.expectEqual(jws_str[0], '{');
    try std.testing.expectEqual(jws_str[jws_str.len - 1], '}');
}

test "JWS creation for new account (with jwk)" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(16384, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a key
    var key = AcmeAccountKey.generate(pool) catch return error.TestFailed;
    defer key.deinit();

    // Create JWS without kid (new account, will embed JWK)
    const nonce = ngx_string("test-nonce-67890");
    const url = ngx_string("https://acme.example.com/new-account");
    const payload = ngx_string("{\"termsOfServiceAgreed\":true}");

    const jws = createJws(pool, &key, nonce, url, null, payload) catch return error.TestFailed;

    // Verify JWS structure
    const jws_str = core.slicify(u8, jws.data, jws.len);

    // Should contain required fields
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"protected\":\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"payload\":\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"signature\":\"") != null);
}

test "JWS POST-as-GET (empty payload)" {
    const nlog = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(16384, nlog);
    defer ngx_destroy_pool(pool);

    // Generate a key
    var key = AcmeAccountKey.generate(pool) catch return error.TestFailed;
    defer key.deinit();

    // Create JWS with empty payload (POST-as-GET)
    const nonce = ngx_string("test-nonce-post-as-get");
    const url = ngx_string("https://acme.example.com/order/12345");
    const kid = ngx_string("https://acme.example.com/acct/12345");

    const jws = createJws(pool, &key, nonce, url, kid, null) catch return error.TestFailed;

    // Verify JWS has empty payload
    const jws_str = core.slicify(u8, jws.data, jws.len);

    // Should have empty payload: "payload":""
    try std.testing.expect(std.mem.indexOf(u8, jws_str, "\"payload\":\"\"") != null);
}
