const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_msec_t = core.ngx_msec_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;
const ngx_http_handler_pt = http.ngx_http_handler_pt;
const ngx_http_core_main_conf_t = http.ngx_http_core_main_conf_t;
const ngx_http_variable_value_t = http.ngx_http_variable_value_t;

const ngx_string = ngx.string.ngx_string;
const ngx_null_str = ngx.string.ngx_null_str;
const concat_string_from_pool = ngx.string.concat_string_from_pool;
const NArray = ngx.array.NArray;

extern var ngx_http_core_module: ngx_module_t;
extern var ngx_current_msec: ngx_msec_t;

// TODO: nftset_ratelimit — per-IP rate window with optional autoban to a named set
// TODO: nftset_autoadd   — honeypot: visiting this location adds client IP to a set
// TODO: multi-set OR logic (nftset_blacklist t:s1 t:s2 …)
// TODO: $nftset_matched_set variable — which set matched, in table:set format
// TODO: CIDR subnet matching via ipv4_addr prefix set type
// TODO: nftset_cache_ttl — extend beyond the current exact-match membership cache if needed

// ──────────────────────────────────────────────────────────────────────────
// Linux socket / Netlink / nftables kernel ABI constants
// ──────────────────────────────────────────────────────────────────────────

// Client IP address family (stable Linux kernel ABI)
const AF_INET: u16 = 2;
const AF_INET6: u16 = 10;

// Netlink socket constants
const AF_NETLINK_SOCK: c_int = 16;
const SOCK_RAW_C: c_int = 3;
const NETLINK_NETFILTER_PROT: c_int = 12;
const SOL_SOCKET_C: c_int = 1;
const SO_RCVTIMEO_C: c_int = 20;

// nftables Netlink subsystem and message types
const NFNL_SUBSYS_NFTABLES: u16 = 10;
const NFT_MSG_GETSETELEM: u16 = 13; // request: get set element(s)
const NFT_MSG_NEWSETELEM: u16 = 12; // response: element found
const NLMSG_ERROR_TYPE: u16 = 2; // standard Netlink error / ACK
const NLMSG_DONE_TYPE: u16 = 3;

// Netlink message flags
const NLM_F_REQUEST: u16 = 0x01;
const NLM_F_ACK: u16 = 0x04;

// nftables protocol families (nfgenmsg.nfgen_family)
const NFNETLINK_V0: u8 = 0;
const NFPROTO_INET: u8 = 1; // dual-stack inet table
const NFPROTO_IPV4: u8 = 2;
const NFPROTO_IPV6: u8 = 10;

// nftables set-element attribute types
const NLA_F_NESTED: u16 = 0x8000; // kernel flag: attribute contains nested attrs
const NFTA_SET_ELEM_LIST_TABLE: u16 = 1;
const NFTA_SET_ELEM_LIST_SET: u16 = 2;
const NFTA_SET_ELEM_LIST_ELEMENTS: u16 = 3;
const NFTA_LIST_ELEM: u16 = 1; // one element in the list
const NFTA_SET_ELEM_KEY: u16 = 1; // key nested under NFTA_LIST_ELEM
const NFTA_DATA_VALUE: u16 = 1; // raw bytes under NFTA_SET_ELEM_KEY

// Fixed sizes matching Linux kernel ABI
const NLMSG_HDR_SZ: usize = 16; // sizeof(struct nlmsghdr)
const NFGENMSG_SZ: usize = 4; // sizeof(struct nfgenmsg)
const NLATTR_HDR_SZ: usize = 4; // sizeof(struct nlattr)

// ──────────────────────────────────────────────────────────────────────────
// Kernel ABI structs
// ──────────────────────────────────────────────────────────────────────────

const Nlmsghdr = extern struct {
    len: u32,
    type_: u16,
    flags: u16,
    seq: u32,
    pid: u32,
};

const Nfgenmsg = extern struct {
    family: u8,
    version: u8,
    res_id: u16, // big-endian; 0 for unicast
};

const Nlattr = extern struct {
    len: u16,
    type_: u16,
};

const SockaddrNl = extern struct {
    family: u16,
    pad: u16,
    pid: u32,
    groups: u32,
};

const Timeval = extern struct {
    tv_sec: c_long,
    tv_usec: c_long,
};

fn writeStruct(buf: []u8, pos: usize, value: anytype) void {
    const bytes = std.mem.asBytes(&value);
    @memcpy(buf[pos .. pos + bytes.len], bytes);
}

fn readStruct(comptime T: type, buf: []const u8, pos: usize) T {
    var value: T = undefined;
    @memcpy(std.mem.asBytes(&value), buf[pos .. pos + @sizeOf(T)]);
    return value;
}

// Minimal sockaddr_in layout (IPv4 — size must match Linux kernel ABI)
const Sockaddr4 = extern struct {
    family: u16,
    port: u16,
    addr: u32, // network byte order IPv4 address
    zero: [8]u8,
};

// Minimal sockaddr_in6 layout (IPv6 — used for both native and IPv4-mapped)
const Sockaddr6 = extern struct {
    family: u16,
    port: u16,
    flowinfo: u32,
    addr: [16]u8, // sin6_addr as flat byte array
    scope_id: u32,
};

// ──────────────────────────────────────────────────────────────────────────
// C runtime function declarations
// ──────────────────────────────────────────────────────────────────────────

extern fn socket(domain: c_int, type_: c_int, protocol: c_int) c_int;
extern fn bind(fd: c_int, addr: *const anyopaque, addrlen: u32) c_int;
extern fn setsockopt(fd: c_int, level: c_int, optname: c_int, optval: *const anyopaque, optlen: u32) c_int;
extern fn send(fd: c_int, buf: *const anyopaque, len: usize, flags: c_int) isize;
extern fn sendto(fd: c_int, buf: *const anyopaque, len: usize, flags: c_int, dest_addr: *const anyopaque, addrlen: u32) isize;
extern fn recv(fd: c_int, buf: *anyopaque, len: usize, flags: c_int) isize;
extern fn close(fd: c_int) c_int;

// ──────────────────────────────────────────────────────────────────────────
// Per-worker Netlink socket state (each worker gets its own after fork)
// ──────────────────────────────────────────────────────────────────────────

var netlink_fd: c_int = -1;
var netlink_seq: u32 = 0;

const NFTSET_CACHE_SIZE: usize = 128;
const NFTSET_CACHE_KEY_MAX: usize = 512;

const CacheMembership = enum(u8) {
    in_set,
    not_in_set,
};

const CacheLookup = union(enum) {
    hit: CacheMembership,
    miss,
};

const CacheEntry = struct {
    valid: bool,
    key_len: u16,
    key: [NFTSET_CACHE_KEY_MAX]u8,
    membership: CacheMembership,
    expires_at: ngx_msec_t,
    last_used_at: ngx_msec_t,
};

var nftset_cache = std.mem.zeroes([NFTSET_CACHE_SIZE]CacheEntry);

// ──────────────────────────────────────────────────────────────────────────
// Netlink message construction helpers
// ──────────────────────────────────────────────────────────────────────────

fn nla_align(len: usize) usize {
    return (len + 3) & ~@as(usize, 3);
}

fn ensureSpace(buf_len: usize, pos: usize, need: usize) bool {
    return pos <= buf_len and need <= buf_len - pos;
}

// Write a null-terminated string as a netlink attribute. Returns new pos.
fn put_nla_str(buf: []u8, pos: usize, nla_type: u16, s: []const u8) usize {
    const payload = s.len + 1;
    const total: u16 = @intCast(NLATTR_HDR_SZ + payload);
    const aligned = nla_align(total);
    @memset(buf[pos .. pos + aligned], 0);
    writeStruct(buf, pos, Nlattr{ .len = total, .type_ = nla_type });
    @memcpy(buf[pos + NLATTR_HDR_SZ .. pos + NLATTR_HDR_SZ + s.len], s);
    return pos + aligned;
}

// Write raw bytes as a netlink attribute. Returns new pos.
fn put_nla_raw(buf: []u8, pos: usize, nla_type: u16, data: []const u8) usize {
    const total: u16 = @intCast(NLATTR_HDR_SZ + data.len);
    const aligned = nla_align(total);
    @memset(buf[pos .. pos + aligned], 0);
    writeStruct(buf, pos, Nlattr{ .len = total, .type_ = nla_type });
    @memcpy(buf[pos + NLATTR_HDR_SZ .. pos + NLATTR_HDR_SZ + data.len], data);
    return pos + aligned;
}

// Begin a nested attribute. Returns the position of the content (after header).
// Caller must remember `pos` (before this call) as `header_pos` for nla_nest_end.
fn nla_nest_start(buf: []u8, pos: usize, nla_type: u16) usize {
    writeStruct(buf, pos, Nlattr{ .len = 0, .type_ = nla_type | NLA_F_NESTED });
    return pos + NLATTR_HDR_SZ;
}

// Finish a nested attribute: write the total length into the header.
fn nla_nest_end(buf: []u8, header_pos: usize, content_end: usize) void {
    const h = readStruct(Nlattr, buf, header_pos);
    writeStruct(buf, header_pos, Nlattr{ .len = @intCast(content_end - header_pos), .type_ = h.type_ });
}

// Build a NFT_MSG_GETSETELEM query into buf[0..512].
// Returns the total message length.
fn build_query(
    buf: *[512]u8,
    seq: u32,
    table_fam: u8,
    table: []const u8,
    set_name: []const u8,
    ip_bytes: []const u8,
) ?usize {
    @memset(buf, 0);
    var pos: usize = 0;

    // nlmsghdr — filled in at end once we know total length
    if (!ensureSpace(buf.len, pos, NLMSG_HDR_SZ)) return null;
    pos += NLMSG_HDR_SZ;

    // nfgenmsg: table protocol family, nfnetlink v0, res_id=0
    if (!ensureSpace(buf.len, pos, NFGENMSG_SZ)) return null;
    writeStruct(buf, pos, Nfgenmsg{ .family = table_fam, .version = NFNETLINK_V0, .res_id = 0 });
    pos += NFGENMSG_SZ;

    // NFTA_SET_ELEM_LIST_SET: set name
    if (!ensureSpace(buf.len, pos, nla_align(NLATTR_HDR_SZ + set_name.len + 1))) return null;
    pos = put_nla_str(buf, pos, NFTA_SET_ELEM_LIST_SET, set_name);

    // NFTA_SET_ELEM_LIST_TABLE: table name
    if (!ensureSpace(buf.len, pos, nla_align(NLATTR_HDR_SZ + table.len + 1))) return null;
    pos = put_nla_str(buf, pos, NFTA_SET_ELEM_LIST_TABLE, table);

    // NFTA_SET_ELEM_LIST_ELEMENTS (nested)
    //   └─ NFTA_LIST_ELEM (nested)
    //       └─ NFTA_SET_ELEM_KEY (nested)
    //           └─ NFTA_DATA_VALUE: raw IP bytes
    const nested_need = (NLATTR_HDR_SZ * 4) + nla_align(NLATTR_HDR_SZ + ip_bytes.len);
    if (!ensureSpace(buf.len, pos, nested_need)) return null;
    const elements_hdr = pos;
    pos = nla_nest_start(buf, pos, NFTA_SET_ELEM_LIST_ELEMENTS);
    const list_elem_hdr = pos;
    pos = nla_nest_start(buf, pos, NFTA_LIST_ELEM);
    const key_hdr = pos;
    pos = nla_nest_start(buf, pos, NFTA_SET_ELEM_KEY);
    pos = put_nla_raw(buf, pos, NFTA_DATA_VALUE, ip_bytes);
    nla_nest_end(buf, key_hdr, pos);
    nla_nest_end(buf, list_elem_hdr, pos);
    nla_nest_end(buf, elements_hdr, pos);

    // Fill in nlmsghdr now that total length is known
    writeStruct(buf, 0, Nlmsghdr{
        .len = @intCast(pos),
        .type_ = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_GETSETELEM,
        .flags = NLM_F_REQUEST | NLM_F_ACK,
        .seq = seq,
        .pid = 0,
    });

    return pos;
}

// ──────────────────────────────────────────────────────────────────────────
// IP address family helpers
// ──────────────────────────────────────────────────────────────────────────

// Detect the element IP family from the client connection.
// Returns "ip" for IPv4 (and IPv4-mapped IPv6), "ip6" for native IPv6.
fn detect_client_family(r: [*c]ngx_http_request_t) ngx_str_t {
    const sa = r.*.connection.*.sockaddr orelse return ngx_string("ip");
    if (sa.*.sa_family != AF_INET6) return ngx_string("ip");

    // Check for IPv4-mapped ::ffff:a.b.c.d
    // Layout: 10 zero bytes, 0xFF, 0xFF, then 4 IPv4 bytes
    const sa6: *Sockaddr6 = @ptrCast(@alignCast(sa));
    const a = sa6.*.addr;
    const is_mapped = a[0] == 0 and a[1] == 0 and a[2] == 0 and a[3] == 0 and
        a[4] == 0 and a[5] == 0 and a[6] == 0 and a[7] == 0 and
        a[8] == 0 and a[9] == 0 and a[10] == 0xFF and a[11] == 0xFF;
    return if (is_mapped) ngx_string("ip") else ngx_string("ip6");
}

// Map a configured family string to the nfgenmsg protocol family byte.
fn table_family_num(family_str: []const u8) u8 {
    if (std.mem.eql(u8, family_str, "ip")) return NFPROTO_IPV4;
    if (std.mem.eql(u8, family_str, "ip6")) return NFPROTO_IPV6;
    return NFPROTO_INET; // "inet" or any unknown value defaults to dual-stack
}

// Extract binary IP bytes from the request's remote address.
// is_ipv6=false → 4 bytes (IPv4 network byte order)
// is_ipv6=true  → 16 bytes (IPv6 network byte order)
// Returns null if the sockaddr type does not match the requested family.
fn get_client_ip_bytes(
    r: [*c]ngx_http_request_t,
    is_ipv6: bool,
    buf: *[16]u8,
) ?[]const u8 {
    const sa = r.*.connection.*.sockaddr orelse return null;
    const sa_fam: u16 = @intCast(sa.*.sa_family);

    if (!is_ipv6) {
        if (sa_fam == AF_INET) {
            const sa4: *const Sockaddr4 = @ptrCast(@alignCast(sa));
            // nft get element emits IPv4 keys as 7f 00 00 01 for 127.0.0.1.
            // Copy the sockaddr bytes as-is to match that request encoding.
            const addr_bytes: *const [4]u8 = @ptrCast(&sa4.*.addr);
            @memcpy(buf[0..4], addr_bytes);
            return buf[0..4];
        }
        if (sa_fam == AF_INET6) {
            // IPv4-mapped ::ffff:a.b.c.d — last 4 bytes are the IPv4 address
            const sa6: *const Sockaddr6 = @ptrCast(@alignCast(sa));
            @memcpy(buf[0..4], sa6.*.addr[12..16]);
            return buf[0..4];
        }
        return null;
    } else {
        if (sa_fam != AF_INET6) return null;
        const sa6: *const Sockaddr6 = @ptrCast(@alignCast(sa));
        @memcpy(buf[0..16], &sa6.*.addr);
        return buf[0..16];
    }
}

// Read a host-endian i32 from an unaligned byte slice.
fn read_i32_native(buf: []const u8, off: usize) i32 {
    return readStruct(i32, buf, off);
}

// ──────────────────────────────────────────────────────────────────────────
// nftables kernel lookup via raw Netlink (NFT_MSG_GETSETELEM)
// ──────────────────────────────────────────────────────────────────────────

const LookupResult = union(enum) {
    in_set,
    not_in_set,
    lookup_error: i32,
};

fn cacheMembershipToLookup(membership: CacheMembership) LookupResult {
    return switch (membership) {
        .in_set => .in_set,
        .not_in_set => .not_in_set,
    };
}

fn lookupToCacheMembership(lookup: LookupResult) ?CacheMembership {
    return switch (lookup) {
        .in_set => .in_set,
        .not_in_set => .not_in_set,
        .lookup_error => null,
    };
}

fn appendKeyPart(dst: []u8, pos: *usize, part: []const u8) bool {
    if (part.len > std.math.maxInt(u8)) return false;
    if (!ensureSpace(dst.len, pos.*, 1 + part.len)) return false;
    dst[pos.*] = @intCast(part.len);
    pos.* += 1;
    @memcpy(dst[pos.* .. pos.* + part.len], part);
    pos.* += part.len;
    return true;
}

fn buildCacheKey(
    key_buf: *[NFTSET_CACHE_KEY_MAX]u8,
    table: []const u8,
    set_name: []const u8,
    table_fam: u8,
    ip_bytes: []const u8,
) ?[]const u8 {
    var pos: usize = 0;
    if (!ensureSpace(key_buf.len, pos, 2)) return null;
    key_buf[pos] = table_fam;
    pos += 1;
    key_buf[pos] = @intCast(ip_bytes.len);
    pos += 1;
    if (!ensureSpace(key_buf.len, pos, ip_bytes.len)) return null;
    @memcpy(key_buf[pos .. pos + ip_bytes.len], ip_bytes);
    pos += ip_bytes.len;
    if (!appendKeyPart(key_buf, &pos, table)) return null;
    if (!appendKeyPart(key_buf, &pos, set_name)) return null;
    return key_buf[0..pos];
}

fn cacheLookup(key: []const u8, now: ngx_msec_t) CacheLookup {
    for (&nftset_cache) |*entry| {
        if (!entry.valid) continue;
        if (entry.expires_at < now) {
            entry.valid = false;
            continue;
        }
        if (entry.key_len != key.len) continue;
        if (!std.mem.eql(u8, entry.key[0..entry.key_len], key)) continue;
        entry.last_used_at = now;
        return .{ .hit = entry.membership };
    }
    return .miss;
}

fn cacheStore(key: []const u8, membership: CacheMembership, now: ngx_msec_t, ttl: ngx_msec_t) void {
    if (ttl == 0 or key.len == 0) return;

    var target: ?*CacheEntry = null;
    var oldest: ?*CacheEntry = null;

    for (&nftset_cache) |*entry| {
        if (!entry.valid) {
            target = entry;
            break;
        }
        if (entry.expires_at < now) {
            target = entry;
            break;
        }
        if (entry.key_len == key.len and std.mem.eql(u8, entry.key[0..entry.key_len], key)) {
            target = entry;
            break;
        }
        if (oldest == null or entry.last_used_at < oldest.?.last_used_at) oldest = entry;
    }

    const slot = target orelse oldest orelse return;
    slot.valid = true;
    slot.key_len = @intCast(key.len);
    @memcpy(slot.key[0..key.len], key);
    slot.membership = membership;
    slot.last_used_at = now;
    slot.expires_at = now + ttl;
}

// Query whether ip_bytes is a member of the named set in the named table.
//
// Protocol: send NFT_MSG_GETSETELEM | NLM_F_REQUEST | NLM_F_ACK.
// Responses (each a separate Netlink datagram):
//   element found  → NFT_MSG_NEWSETELEM, then NLMSG_ERROR(error=0)
//   element absent → NLMSG_ERROR(error=-ENOENT)   → not_in_set
//   other error    → NLMSG_ERROR(error=<negative>) → lookup_error
//
// Note: -ENOENT is also returned when the table or set does not exist.
// Operators must ensure table/set names are correct; misconfiguration
// will surface as "not_in_set" and trigger deny/allow according to the
// nftset_deny directive (which is the intended fail-safe behaviour).
fn nftset_ip_in_set(
    table: []const u8,
    set_name: []const u8,
    table_fam: u8,
    ip_bytes: []const u8,
) LookupResult {
    if (netlink_fd < 0) return .{ .lookup_error = -1 };

    var qbuf: [512]u8 = undefined;
    netlink_seq +%= 1;
    const msg_len = build_query(&qbuf, netlink_seq, table_fam, table, set_name, ip_bytes) orelse return .{ .lookup_error = -2 };

    const kernel_addr = SockaddrNl{ .family = AF_NETLINK_SOCK, .pad = 0, .pid = 0, .groups = 0 };

    const sent = sendto(netlink_fd, &qbuf, msg_len, 0, &kernel_addr, @sizeOf(SockaddrNl));
    if (sent < 0) return .{ .lookup_error = -3 };

    var rbuf: [4096]u8 = undefined;
    var found = false;

    // Receive loop: found case requires 2 datagrams (NEWSETELEM + ACK).
    // Socket has a 100 ms receive timeout set in init_process.
    var iters: u8 = 0;
    while (iters < 4) : (iters += 1) {
        const rcvd = recv(netlink_fd, &rbuf, rbuf.len, 0);
        if (rcvd <= 0) return .{ .lookup_error = -4 }; // timeout or socket error

        const rcvd_sz: usize = @intCast(rcvd);
        var off: usize = 0;

        while (off + NLMSG_HDR_SZ <= rcvd_sz) {
            const nlh = readStruct(Nlmsghdr, &rbuf, off);
            if (nlh.len < NLMSG_HDR_SZ) break;
            if (nlh.len > rcvd_sz - off) return .{ .lookup_error = -5 };

            const step = nla_align(@intCast(nlh.len));
            if (step == 0 or step > rcvd_sz - off) return .{ .lookup_error = -6 };

            if (nlh.seq != netlink_seq) {
                off += step;
                continue;
            }

            const msg_type = nlh.type_;

            if (msg_type == NLMSG_ERROR_TYPE) {
                if (off + NLMSG_HDR_SZ + 4 > rcvd_sz) return .{ .lookup_error = -7 };
                const err_val = read_i32_native(&rbuf, off + NLMSG_HDR_SZ);
                if (err_val == 0) {
                    // Explicit ACK (NLM_F_ACK response with error=0)
                    return if (found) .in_set else .not_in_set;
                }
                if (err_val == -2) {
                    // Raw NFT_MSG_GETSETELEM overloads ENOENT for both
                    // “element absent” and some missing-object cases. Keep the
                    // point-lookup path stable by treating ENOENT as not_in_set.
                    return .not_in_set;
                }
                return .{ .lookup_error = err_val };
            }

            const newsetelem_type: u16 = (NFNL_SUBSYS_NFTABLES << 8) | NFT_MSG_NEWSETELEM;
            if (msg_type == newsetelem_type) found = true;

            if (msg_type == NLMSG_DONE_TYPE) {
                return if (found) .in_set else .not_in_set;
            }

            off += step;
        }
    }

    return if (found) .in_set else .{ .lookup_error = -8 };
}

// ──────────────────────────────────────────────────────────────────────────
// Per-worker init / exit (open/close the Netlink socket once per worker)
// ──────────────────────────────────────────────────────────────────────────

fn nftset_init_process(cycle: [*c]core.ngx_cycle_t) callconv(.c) ngx_int_t {
    nftset_cache = std.mem.zeroes([NFTSET_CACHE_SIZE]CacheEntry);
    netlink_fd = socket(AF_NETLINK_SOCK, SOCK_RAW_C, NETLINK_NETFILTER_PROT);
    if (netlink_fd < 0) {
        // Socket failed (e.g. no CAP_NET_ADMIN) — module operates in
        // lookup_error mode; fail_open policy controls the outcome.
        ngx.log.ngz_log_error(ngx.log.NGX_LOG_ERR, cycle.*.log, 0, "nftset: failed to open netlink socket", .{});
        return NGX_OK;
    }

    // 100 ms receive timeout prevents hanging when the kernel is slow
    const tv = Timeval{ .tv_sec = 0, .tv_usec = 100_000 };
    if (setsockopt(netlink_fd, SOL_SOCKET_C, SO_RCVTIMEO_C, &tv, @sizeOf(Timeval)) < 0) {
        ngx.log.ngz_log_error(ngx.log.NGX_LOG_ERR, cycle.*.log, 0, "nftset: failed to set netlink receive timeout", .{});
    }

    var nl_addr = SockaddrNl{ .family = AF_NETLINK_SOCK, .pad = 0, .pid = 0, .groups = 0 };
    if (bind(netlink_fd, &nl_addr, @sizeOf(SockaddrNl)) < 0) {
        ngx.log.ngz_log_error(ngx.log.NGX_LOG_ERR, cycle.*.log, 0, "nftset: failed to bind netlink socket", .{});
        _ = close(netlink_fd);
        netlink_fd = -1;
    }

    return NGX_OK;
}

fn nftset_exit_process(_: [*c]core.ngx_cycle_t) callconv(.c) void {
    nftset_cache = std.mem.zeroes([NFTSET_CACHE_SIZE]CacheEntry);
    if (netlink_fd >= 0) {
        _ = close(netlink_fd);
        netlink_fd = -1;
    }
}

// ──────────────────────────────────────────────────────────────────────────
// Module configuration types
// ──────────────────────────────────────────────────────────────────────────

const nftset_loc_conf = extern struct {
    enabled: ngx_flag_t,
    // nftables table name (e.g. "filter")
    table: ngx_str_t,
    // nftables set name (e.g. "blocklist")
    set: ngx_str_t,
    // nftables table family: "inet", "ip", "ip6"; null = auto-detect
    family: ngx_str_t,
    // deny=1: block IPs found in set; deny=0: block IPs NOT in set (allowlist)
    deny: ngx_flag_t,
    // HTTP status code returned when blocking (default 403)
    status: ngx_int_t,
    // fail_open=1: allow on lookup error; fail_open=0: deny on lookup error
    fail_open: ngx_flag_t,
    // dryrun=1: log block decision but do not actually block
    dryrun: ngx_flag_t,
    // cache_ttl: how long to cache set membership per worker (ms, default 60000)
    cache_ttl: ngx_msec_t,
};

// Per-request context — carries the access decision and resolved family
const nftset_ctx = extern struct {
    result: ngx_str_t,
    // Resolved element family: "ip" or "ip6" (always auto-detected)
    client_family: ngx_str_t,
    matched_set: ngx_str_t,
};

const result_allow = ngx_string("allow");
const result_deny = ngx_string("deny");
const result_dryrun = ngx_string("dryrun");
const result_error = ngx_string("error");

fn make_matched_set(r: [*c]ngx_http_request_t, table: ngx_str_t, set_name: ngx_str_t) ngx_str_t {
    return concat_string_from_pool(&.{ table, set_name }, ":", r.*.pool) catch ngx_null_str;
}

fn set_ctx(r: [*c]ngx_http_request_t, result: ngx_str_t, client_family: ngx_str_t, matched_set: ngx_str_t) void {
    const ctx = core.ngz_pcalloc_c(nftset_ctx, r.*.pool) orelse return;
    ctx.*.result = result;
    ctx.*.client_family = client_family;
    ctx.*.matched_set = matched_set;
    r.*.ctx[ngx_http_nftset_module.ctx_index] = ctx;
}

// ──────────────────────────────────────────────────────────────────────────
// Access phase handler
// ──────────────────────────────────────────────────────────────────────────

fn ngx_http_nftset_access_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lcf = core.castPtr(
        nftset_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_nftset_module),
    ) orelse return NGX_DECLINED;

    if (lcf.*.enabled != 1) return NGX_DECLINED;

    // Element IP family: always derived from the actual client address.
    // "ip" for IPv4 (or IPv4-mapped IPv6), "ip6" for native IPv6.
    const elem_family = detect_client_family(r);
    const elem_fam_slice = elem_family.data[0..elem_family.len];
    const is_ipv6 = std.mem.eql(u8, elem_fam_slice, "ip6");

    // Table protocol family for the nfgenmsg header.
    // Uses the configured nftset_family; defaults to NFPROTO_INET when unset.
    const table_fam: u8 = if (lcf.*.family.data != null and lcf.*.family.len > 0)
        table_family_num(lcf.*.family.data[0..lcf.*.family.len])
    else
        NFPROTO_INET;

    ngx.log.ngz_log_debug(
        ngx.log.NGX_LOG_DEBUG_HTTP,
        r.*.connection.*.log,
        0,
        "nftset: client=%V elem_family=%V table=%V set=%V deny=%d dryrun=%d",
        .{ &r.*.connection.*.addr_text, &elem_family, &lcf.*.table, &lcf.*.set, lcf.*.deny, lcf.*.dryrun },
    );

    const table_slice: []const u8 = if (lcf.*.table.data != null) lcf.*.table.data[0..lcf.*.table.len] else "filter";
    const set_slice: []const u8 = if (lcf.*.set.data != null) lcf.*.set.data[0..lcf.*.set.len] else "blocklist";
    const configured_family = if (lcf.*.family.data != null and lcf.*.family.len > 0)
        lcf.*.family.data[0..lcf.*.family.len]
    else
        "inet";

    const family_mismatch = (std.mem.eql(u8, configured_family, "ip") and is_ipv6) or
        (std.mem.eql(u8, configured_family, "ip6") and !is_ipv6);
    if (family_mismatch) {
        ngx.log.ngz_log_error(
            ngx.log.NGX_LOG_ERR,
            r.*.connection.*.log,
            0,
            "nftset: client family %V does not match configured nftset_family=%V (table=%V set=%V)",
            .{ &elem_family, &lcf.*.family, &lcf.*.table, &lcf.*.set },
        );
        set_ctx(r, result_error, elem_family, ngx_null_str);
        if (lcf.*.fail_open == 1) return NGX_DECLINED;
        return lcf.*.status;
    }

    if (lcf.*.dryrun == 1) {
        // Dryrun mode: perform the lookup for diagnostic logging only; never enforce.
        var ip_buf: [16]u8 = undefined;
        if (get_client_ip_bytes(r, is_ipv6, &ip_buf)) |ip_bytes| {
            const lookup = nftset_ip_in_set(table_slice, set_slice, table_fam, ip_bytes);
            const matched_set = if (lookup == .in_set) make_matched_set(r, lcf.*.table, lcf.*.set) else ngx_null_str;
            const would_block = switch (lookup) {
                .in_set => lcf.*.deny == 1,
                .not_in_set => lcf.*.deny == 0,
                .lookup_error => false,
            };
            if (would_block) {
                ngx.log.ngz_log_error(
                    ngx.log.NGX_LOG_NOTICE,
                    r.*.connection.*.log,
                    0,
                    "nftset: dryrun would block %V (table=%V set=%V)",
                    .{ &r.*.connection.*.addr_text, &lcf.*.table, &lcf.*.set },
                );
            }
            set_ctx(r, result_dryrun, elem_family, matched_set);
            return NGX_DECLINED;
        }
        set_ctx(r, result_dryrun, elem_family, ngx_null_str);
        return NGX_DECLINED;
    }

    // Extract the binary IP from the request's remote address.
    var ip_buf: [16]u8 = undefined;
    const ip_bytes = get_client_ip_bytes(r, is_ipv6, &ip_buf) orelse {
        ngx.log.ngz_log_error(
            ngx.log.NGX_LOG_ERR,
            r.*.connection.*.log,
            0,
            "nftset: cannot extract client IP bytes (sa_family=%d)",
            .{@as(c_int, if (r.*.connection.*.sockaddr != null) @intCast(r.*.connection.*.sockaddr.?.*.sa_family) else 0)},
        );
        set_ctx(r, result_error, elem_family, ngx_null_str);
        if (lcf.*.fail_open == 1) return NGX_DECLINED;
        return lcf.*.status;
    };

    const now = ngx_current_msec;
    var key_buf: [NFTSET_CACHE_KEY_MAX]u8 = undefined;
    const cache_key = if (lcf.*.cache_ttl > 0)
        buildCacheKey(&key_buf, table_slice, set_slice, table_fam, ip_bytes)
    else
        null;

    const lookup = blk: {
        if (lcf.*.cache_ttl > 0) {
            if (cache_key) |key| {
                switch (cacheLookup(key, now)) {
                    .hit => |membership| {
                        ngx.log.ngz_log_debug(
                            ngx.log.NGX_LOG_DEBUG_HTTP,
                            r.*.connection.*.log,
                            0,
                            "nftset: cache hit client=%V table=%V set=%V",
                            .{ &r.*.connection.*.addr_text, &lcf.*.table, &lcf.*.set },
                        );
                        break :blk cacheMembershipToLookup(membership);
                    },
                    .miss => {},
                }
            }
        }

        const fresh = nftset_ip_in_set(table_slice, set_slice, table_fam, ip_bytes);
        if (lcf.*.cache_ttl > 0) {
            if (cache_key) |key| {
                if (lookupToCacheMembership(fresh)) |membership| {
                    cacheStore(key, membership, now, lcf.*.cache_ttl);
                }
            }
        }
        break :blk fresh;
    };

    if (lookup == .lookup_error) {
        const err_code = lookup.lookup_error;
        ngx.log.ngz_log_error(
            ngx.log.NGX_LOG_ERR,
            r.*.connection.*.log,
            0,
            "nftset: kernel lookup failed for %V (table=%V set=%V fail_open=%d err=%d)",
            .{ &r.*.connection.*.addr_text, &lcf.*.table, &lcf.*.set, lcf.*.fail_open, err_code },
        );
        set_ctx(r, result_error, elem_family, ngx_null_str);
        if (lcf.*.fail_open == 1) return NGX_DECLINED;
        return lcf.*.status;
    }

    // Determine if the request should be blocked.
    // deny=1 (blocklist): block if IP is in set
    // deny=0 (allowlist): block if IP is NOT in set
    const blocked = if (lookup == .in_set) lcf.*.deny == 1 else lcf.*.deny == 0;

    if (blocked) {
        ngx.log.ngz_log_error(
            ngx.log.NGX_LOG_NOTICE,
            r.*.connection.*.log,
            0,
            "nftset: blocking %V (table=%V set=%V status=%d)",
            .{ &r.*.connection.*.addr_text, &lcf.*.table, &lcf.*.set, lcf.*.status },
        );
        set_ctx(r, result_deny, elem_family, if (lookup == .in_set) make_matched_set(r, lcf.*.table, lcf.*.set) else ngx_null_str);
        return lcf.*.status;
    }

    set_ctx(r, result_allow, elem_family, if (lookup == .in_set) make_matched_set(r, lcf.*.table, lcf.*.set) else ngx_null_str);
    return NGX_DECLINED;
}

// ──────────────────────────────────────────────────────────────────────────
// $nftset_result variable getter
// ──────────────────────────────────────────────────────────────────────────

fn ngx_http_nftset_result_variable(
    r: [*c]ngx_http_request_t,
    v: [*c]ngx_http_variable_value_t,
    data: core.uintptr_t,
) callconv(.c) ngx_int_t {
    _ = data;
    const ctx = core.castPtr(nftset_ctx, r.*.ctx[ngx_http_nftset_module.ctx_index]) orelse {
        v.*.flags.not_found = true;
        return NGX_OK;
    };
    if (ctx.*.result.len == 0) {
        v.*.flags.not_found = true;
        return NGX_OK;
    }
    v.*.data = ctx.*.result.data;
    v.*.flags.len = @intCast(ctx.*.result.len);
    v.*.flags.valid = true;
    v.*.flags.no_cacheable = false;
    v.*.flags.not_found = false;
    return NGX_OK;
}

fn ngx_http_nftset_matched_set_variable(
    r: [*c]ngx_http_request_t,
    v: [*c]ngx_http_variable_value_t,
    data: core.uintptr_t,
) callconv(.c) ngx_int_t {
    _ = data;
    const ctx = core.castPtr(nftset_ctx, r.*.ctx[ngx_http_nftset_module.ctx_index]) orelse {
        v.*.flags.not_found = true;
        return NGX_OK;
    };
    if (ctx.*.matched_set.len == 0) {
        v.*.flags.not_found = true;
        return NGX_OK;
    }
    v.*.data = ctx.*.matched_set.data;
    v.*.flags.len = @intCast(ctx.*.matched_set.len);
    v.*.flags.valid = true;
    v.*.flags.no_cacheable = false;
    v.*.flags.not_found = false;
    return NGX_OK;
}

// ──────────────────────────────────────────────────────────────────────────
// Config callbacks
// ──────────────────────────────────────────────────────────────────────────

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    const lcf = core.ngz_pcalloc_c(nftset_loc_conf, cf.*.pool) orelse return null;
    lcf.*.enabled = conf.NGX_CONF_UNSET;
    lcf.*.deny = conf.NGX_CONF_UNSET;
    lcf.*.status = conf.NGX_CONF_UNSET;
    lcf.*.fail_open = conf.NGX_CONF_UNSET;
    lcf.*.dryrun = conf.NGX_CONF_UNSET;
    lcf.*.cache_ttl = conf.NGX_CONF_UNSET_MSEC;
    return lcf;
}

fn merge_loc_conf(
    cf: [*c]ngx_conf_t,
    parent: ?*anyopaque,
    child: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    const prev = core.castPtr(nftset_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const curr = core.castPtr(nftset_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (curr.*.enabled == conf.NGX_CONF_UNSET) {
        curr.*.enabled = if (prev.*.enabled == conf.NGX_CONF_UNSET) 0 else prev.*.enabled;
    }
    if (curr.*.deny == conf.NGX_CONF_UNSET) {
        curr.*.deny = if (prev.*.deny == conf.NGX_CONF_UNSET) 1 else prev.*.deny;
    }
    if (curr.*.status == conf.NGX_CONF_UNSET) {
        curr.*.status = if (prev.*.status == conf.NGX_CONF_UNSET) 403 else prev.*.status;
    }
    if (curr.*.fail_open == conf.NGX_CONF_UNSET) {
        curr.*.fail_open = if (prev.*.fail_open == conf.NGX_CONF_UNSET) 0 else prev.*.fail_open;
    }
    if (curr.*.dryrun == conf.NGX_CONF_UNSET) {
        curr.*.dryrun = if (prev.*.dryrun == conf.NGX_CONF_UNSET) 0 else prev.*.dryrun;
    }
    if (curr.*.cache_ttl == conf.NGX_CONF_UNSET_MSEC) {
        curr.*.cache_ttl = if (prev.*.cache_ttl == conf.NGX_CONF_UNSET_MSEC) 60000 else prev.*.cache_ttl;
    }
    conf.ngx_conf_merge_str_value(&curr.*.table, &prev.*.table, ngx_string("filter"));
    conf.ngx_conf_merge_str_value(&curr.*.set, &prev.*.set, ngx_string("blocklist"));
    // family: no hardcoded default — null signals auto-detect (use NFPROTO_INET).
    // Inherit from parent only if parent was explicitly set.
    if (curr.*.family.data == null and prev.*.family.data != null) {
        curr.*.family = prev.*.family;
    }

    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register $nftset_result and $nftset_matched_set variables
    var vs = [_]http.ngx_http_variable_t{
        http.ngx_http_variable_t{
            .name = ngx_string("nftset_result"),
            .set_handler = null,
            .get_handler = ngx_http_nftset_result_variable,
            .data = 0,
            .flags = http.NGX_HTTP_VAR_NOCACHEABLE,
            .index = 0,
        },
        http.ngx_http_variable_t{
            .name = ngx_string("nftset_matched_set"),
            .set_handler = null,
            .get_handler = ngx_http_nftset_matched_set_variable,
            .data = 0,
            .flags = http.NGX_HTTP_VAR_NOCACHEABLE,
            .index = 0,
        },
    };
    for (&vs) |*v| {
        if (http.ngx_http_add_variable(cf, &v.name, v.flags)) |x| {
            x.*.get_handler = v.get_handler;
            x.*.data = v.data;
        }
    }

    // Register access phase handler
    const cmcf = core.castPtr(
        ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    var handlers = NArray(ngx_http_handler_pt).init0(
        &cmcf[0].phases[http.NGX_HTTP_ACCESS_PHASE].handlers,
    );
    const h = handlers.append() catch return NGX_ERROR;
    h.* = ngx_http_nftset_access_handler;

    return NGX_OK;
}

// ──────────────────────────────────────────────────────────────────────────
// Directive table
// ──────────────────────────────────────────────────────────────────────────

// All directives accept http{} / server{} / location{} contexts so settings
// can be inherited: http → server → location via merge_loc_conf.
const CTX = conf.NGX_HTTP_MAIN_CONF | conf.NGX_HTTP_SRV_CONF | conf.NGX_HTTP_LOC_CONF;

export const ngx_http_nftset_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("nftset"),
        .type = CTX | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "enabled"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_table"),
        .type = CTX | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "table"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_set"),
        .type = CTX | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "set"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_family"),
        .type = CTX | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "family"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_deny"),
        .type = CTX | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "deny"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_status"),
        .type = CTX | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_num_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "status"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_fail_open"),
        .type = CTX | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "fail_open"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_dryrun"),
        .type = CTX | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "dryrun"),
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("nftset_cache_ttl"),
        .type = CTX | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_msec_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(nftset_loc_conf, "cache_ttl"),
        .post = null,
    },
    conf.ngx_null_command,
};

export const ngx_http_nftset_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

// Module export — set init_process/exit_process for the per-worker Netlink socket.
pub export var ngx_http_nftset_module = blk: {
    var m = ngx.module.make_module(
        @constCast(&ngx_http_nftset_commands),
        @constCast(&ngx_http_nftset_module_ctx),
    );
    m.init_process = nftset_init_process;
    m.exit_process = nftset_exit_process;
    break :blk m;
};
