const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

const NULL = core.NULL;
const u_char = core.u_char;

pub const RAND_bytes = ngx.RAND_bytes;
pub const RSA_PKCS1_OAEP_PADDING = ngx.RSA_PKCS1_OAEP_PADDING;
pub const RSA_PKCS1_PADDING = ngx.RSA_PKCS1_PADDING;
pub const RSA_NO_PADDING = ngx.RSA_NO_PADDING;

pub const EVP_PKEY_CTX_new = ngx.EVP_PKEY_CTX_new;
pub const EVP_PKEY_CTX_free = ngx.EVP_PKEY_CTX_free;

pub const PEM_read_PUBKEY = ngx.PEM_read_PUBKEY;
pub const PEM_read_PUBKEY_ex = ngx.PEM_read_PUBKEY_ex;
pub const PEM_read_PrivateKey = ngx.PEM_read_PrivateKey;
pub const PEM_read_PrivateKey_ex = ngx.PEM_read_PrivateKey_ex;

pub const EVP_aes_256_gcm = ngx.EVP_aes_256_gcm;
pub const EVP_PKEY_encrypt_init_ex = ngx.EVP_PKEY_encrypt_init_ex;
pub const EVP_PKEY_encrypt = ngx.EVP_PKEY_encrypt;
pub const EVP_PKEY_decrypt_init_ex = ngx.EVP_PKEY_decrypt_init_ex;
pub const EVP_PKEY_decrypt = ngx.EVP_PKEY_decrypt;

pub const EVP_sha256 = ngx.EVP_sha256;

pub const EVP_MD_CTX_new = ngx.EVP_MD_CTX_new;
pub const EVP_MD_CTX_free = ngx.EVP_MD_CTX_free;

pub const EVP_DigestVerifyInit_ex = ngx.EVP_DigestVerifyInit_ex;
pub const EVP_DigestVerifyInit = ngx.EVP_DigestVerifyInit;
pub const EVP_DigestVerifyUpdate = ngx.EVP_DigestVerifyUpdate;
pub const EVP_DigestVerifyFinal = ngx.EVP_DigestVerifyFinal;

pub const EVP_DigestSignInit_ex = ngx.EVP_DigestSignInit_ex;
pub const EVP_DigestSignInit = ngx.EVP_DigestSignInit;
pub const EVP_DigestSignUpdate = ngx.EVP_DigestSignUpdate;
pub const EVP_DigestSignFinal = ngx.EVP_DigestSignFinal;
