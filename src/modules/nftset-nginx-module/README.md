## nftset-nginx-module

Zero-latency IP blocking for nginx using Linux nftables named sets.

### Status

**Implemented with limitations** — The module performs request-time kernel lookup via raw Netlink `NFT_MSG_GETSETELEM`, exposes `$nftset_result`, and enforces `nftset_deny`, `nftset_status`, `nftset_fail_open`, and `nftset_dryrun`. Live nftables membership coverage now runs in Docker-isolated tests so host nftables never needs to be touched. Remaining work is around broader feature depth and longer-term hardening, not the core membership path.

See [GitHub issue #5](https://github.com/kaiwu/nginz/issues/5) for the original feature request.

---

### Detected Issues

- **Fixed in this audit:** the README had drifted behind the implementation. It still described kernel lookup as unimplemented and claimed a `libnftables` build/runtime dependency even though the module now uses a raw Netlink path and `build.zig` does not link `libnftables`.
- **Fixed in this audit:** the raw Netlink request path had unsafe unaligned packet-buffer access. The lookup code now uses byte-copy helpers instead of typed writes into unaligned buffers, which stopped nginx worker crashes on the first enabled request.
- **Fixed in this audit:** the raw Netlink exchange now uses the correct nfnetlink subsystem/message constants, sends explicitly to the kernel, correlates replies by `nlmsg_seq`, and rejects malformed/truncated frames as lookup errors instead of trusting them.
- **Fixed in this audit:** positive and negative membership behavior is now covered against live nftables sets in a Docker-isolated test namespace instead of relying only on fail-open / fail-closed fallback coverage.
- **Still open:** `nftset_cache_ttl` is parsed and inherited, but there is no per-worker cache implementation yet.

#### Motivation

Traditional IP blocking via `deny` directives or `geo` maps requires a full nginx reload to take effect. Linux nftables sets are kernel-side hash tables that can be updated atomically at runtime with `nft add element`. This lets an operator or security daemon block a crawling IP in < 1 ms without touching nginx configuration at all.

#### Architecture

```
Request
  │
  ▼
ACCESS phase handler (ngx_http_nftset_access_handler)
  │
  ├─ disabled → NGX_DECLINED
  │
  ├─ extract remote IP bytes from r->connection->sockaddr
  │
  ├─ query nftables named set via raw Netlink `NFT_MSG_GETSETELEM`
  │   ├─ nftset_deny on  → IP in set → 403 Forbidden
  │   └─ nftset_deny off → IP not in set → 403 Forbidden  (allowlist mode)
  │
  └─ NGX_DECLINED (pass through)
```

#### IP Lookup Strategy

Two implementation approaches were considered:

| Approach | Latency | Complexity | Notes |
|---|---|---|---|
| **libnftables** (`libnftables.so`) | ~10–50 µs | Medium | High-level C API; handles parsing; requires `libnftables-dev` |
| **Netlink socket** (raw) | ~1–5 µs | High | Direct kernel ABI; no extra deps; portable across distros |

The current module uses the raw Netlink path. `libnftables` remains a possible future fallback if the raw ABI path proves too brittle across kernels or capabilities.

The relevant Netlink message type is `NFT_MSG_GETSETELEM` on `NFNL_SUBSYS_NFTABLES`. The lookup is a point query (single IP → present/absent) so it does not iterate the full set.

#### nftables Set Requirements

The target nftables set must be of type `ipv4_addr` (for `inet`/`ip` families) or `ipv6_addr` (for `ip6`). Example setup:

```bash
# Create table and set
nft add table inet filter
nft add set inet filter blocklist { type ipv4_addr \; flags dynamic,timeout \; }

# Block an IP at runtime (no nginx reload needed)
nft add element inet filter blocklist { 1.2.3.4 }

# Remove a block
nft delete element inet filter blocklist { 1.2.3.4 }
```

The module reads the set at request time; it does not cache membership yet. This keeps the implementation simple and means set changes take effect immediately for the next request.

---

### Directives

#### nftset

*syntax:* `nftset on|off;`
*default:* `nftset off;`
*context:* `http, server, location`

Enable or disable nftset IP checking for this location.

#### nftset_table

*syntax:* `nftset_table <name>;`
*default:* `nftset_table filter;`
*context:* `http, server, location`

nftables table name to query.

#### nftset_set

*syntax:* `nftset_set <name>;`
*default:* `nftset_set blocklist;`
*context:* `http, server, location`

nftables set name inside the table.

#### nftset_family

*syntax:* `nftset_family inet|ip|ip6;`
*default:* `nftset_family inet;`
*context:* `http, server, location`

nftables address family. Use `inet` for dual-stack, `ip` for IPv4-only, `ip6` for IPv6-only.

#### nftset_deny

*syntax:* `nftset_deny on|off;`
*default:* `nftset_deny on;`
*context:* `http, server, location`

- `on` — **blocklist** mode: IPs found in the set are denied.
- `off` — **allowlist** mode: IPs *not* found in the set are denied.

#### nftset_status

*syntax:* `nftset_status <code>;`
*default:* `nftset_status 403;`
*context:* `http, server, location`

HTTP status code returned when a request is blocked. Common values: `403` (Forbidden), `429` (Too Many Requests), `503` (Service Unavailable), `444` (nginx connection-close).

#### nftset_fail_open

*syntax:* `nftset_fail_open on|off;`
*default:* `nftset_fail_open off;`
*context:* `http, server, location`

Controls behaviour when the nftables kernel lookup itself fails (e.g. set does not exist, permission denied).

- `off` — deny the request (fail closed, secure default).
- `on` — allow the request through (fail open, prefer availability).

#### nftset_dryrun

*syntax:* `nftset_dryrun on|off;`
*default:* `nftset_dryrun off;`
*context:* `http, server, location`

When enabled, the module logs what it would block but never actually blocks. `$nftset_result` is set to `dryrun`. Useful for validating set membership before enabling enforcement.

#### nftset_cache_ttl

*syntax:* `nftset_cache_ttl <time>;`
*default:* `nftset_cache_ttl 60s;`
*context:* `http, server, location`

How long to cache the set membership result per worker process. Reduces kernel calls at high request rates. Set to `0` to disable caching. (*Cache implementation is pending; field is parsed and stored.*)

---

### Usage

#### Blocklist (deny crawlers)

```nginx
location / {
    nftset         on;
    nftset_table   filter;
    nftset_set     blocklist;
    nftset_family  inet;
    nftset_deny    on;

    proxy_pass http://backend;
}
```

Block an abusive IP without reloading nginx:

```bash
nft add element inet filter blocklist { 203.0.113.42 }
```

#### Allowlist (internal API)

```nginx
location /internal/api {
    nftset         on;
    nftset_table   filter;
    nftset_set     trusted;
    nftset_family  inet;
    nftset_deny    off;   # deny anyone NOT in the set

    proxy_pass http://internal;
}
```

---

### Build

```bash
zig build

# Integration tests (config/inheritance + Docker-isolated live nftables coverage)
bun test tests/nftset/
```

The current implementation uses raw Netlink syscalls from Zig and does **not** link `libnftables` in `build.zig`.

The nftset test directory now contains two layers of coverage:

- `tests/nftset/nftset.test.js` validates directive parsing, inheritance, fail-open / fail-closed handling, and `$nftset_result` behavior without needing live nftables state.
- `tests/nftset/nftset.container.test.js` provisions real nftables tables/sets inside a disposable Docker container and verifies hit/miss behavior there, so no host nftables rules are modified.

---

### Limitations

- Linux only (nftables is a Linux kernel subsystem).
- Requires the nginx worker process to be able to complete nftables Netlink lookups. When lookup fails, `nftset_fail_open` controls whether the request passes through or is denied.
- IPv4-mapped IPv6 addresses are normalized onto the IPv4 lookup path, but broader family / set-type interoperability still needs more real-kernel coverage.
- No caching: every request performs a kernel lookup. For extremely high-traffic locations this may become a bottleneck; a per-worker LRU cache can be added later.
- `NFT_MSG_GETSETELEM` returns `ENOENT` for both “element absent” and some missing-object cases; the raw path still needs more hardening/documented policy around that ambiguity.

---

### Gaps vs. ngx_http_nftset_access (reference module)

Comparison against the [GetPageSpeed nftset-access module](https://nginx-extras.getpagespeed.com/modules/nftset-access/).

#### Directive design

| Area | Reference | Ours | Status |
|---|---|---|---|
| Set spec format | `table:setname` combined token | Separate `nftset_table` / `nftset_set` directives | Open — our form is more explicit; `table:set` syntax not yet supported |
| Multiple sets | `nftset_blacklist t:s1 t:s2 …` (OR logic, variadic) | One set per location | Open — multi-set OR logic not implemented |
| Blocklist/allowlist naming | Distinct `nftset_blacklist` and `nftset_whitelist` | Single `nftset_deny on\|off` toggle | Open — naming less discoverable |
| Directive context | `http`, `server` (inherited down) | ~~`location` only~~ → **`http`, `server`, `location`** | ✅ Fixed |
| IP family | Auto-detected from client address | `nftset_family` is optional — auto-detected from `sockaddr->sa_family`; IPv4-mapped IPv6 normalised to `ip` | ✅ Fixed |

#### Directives

| Directive | Reference semantics | Status |
|---|---|---|
| `nftset_status <code>` | HTTP status on block (403/429/503/444) | ✅ Implemented |
| `nftset_cache_ttl <time>` | Per-worker result cache, default 60 s | ✅ Parsed & stored — cache logic pending kernel lookup |
| `nftset_fail_open on\|off` | Allow/deny on lookup error | ✅ Implemented |
| `nftset_dryrun on\|off` | Log decision, never block | ✅ Implemented |
| `nftset_ratelimit …` | Per-IP rate limit with optional auto-ban | Open |
| `nftset_autoadd table:set …` | Honeypot: auto-add client IP to a set | Open |
| `nftset_stats` | JSON stats endpoint | Open |
| `nftset_metrics` | Prometheus endpoint | Open (overlaps with prometheus module) |
| `nftset_challenge` / `nftset_challenge_difficulty` | JS PoW challenge | Open — significant complexity |

#### Nginx variables

| Variable | Meaning | Status |
|---|---|---|
| `$nftset_result` | `allow` / `deny` / `dryrun` / `error` | ✅ Implemented |
| `$nftset_matched_set` | `table:setname` of the matching set | Open |

#### Missing features

- **CIDR subnet matching** — requires `ipv4_addr` set with prefix flag or a separate CIDR path.
- **Entry timeouts** — per-element expiry useful for temporary blocks (`nftset_autoadd timeout=N`).

---

### Remaining Work (hard)

1. **Per-worker LRU cache** — once lookup behavior is better characterized, add a fixed-size array cache keyed on IP string hash with `cache_ttl` expiry.
2. ~~**Auto-detect IP family**~~ ✅ Done — handler reads `r->connection->sockaddr->sa_family`; IPv4-mapped IPv6 (`::ffff:x.x.x.x`) normalised to `ip`; `nftset_family` becomes an optional override.
3. **`$nftset_matched_set`** — store the `table:set` string that triggered the match in `nftset_ctx`; expose via a second variable getter.
4. **Multi-set OR logic** — accept variadic `nftset_blacklist table:set …` syntax; iterate sets until first match.
5. **`nftset_autoadd`** — honeypot directive: on location access, call `nft add element` to insert client IP into a named set (with optional timeout).
6. **CIDR matching** — use nftables prefix sets or add a userspace CIDR trie alongside the exact-IP lookup.

### Documentation Audit Checklist

- [x] Audit date: 2026-04-21
- [x] Bun integration coverage exists at `tests/nftset/`.
- [x] Gap fixed in this audit pass: README now reflects that kernel lookup is implemented via raw Netlink rather than still being a stub or a `libnftables`-linked path.
- [x] Gap fixed in this audit pass: the raw Netlink request path no longer performs unsafe unaligned struct access into packet buffers.
- [x] Gap fixed in this audit pass: the raw Netlink lookup now uses the correct nfnetlink subsystem/message constants, which made live nftables membership checks work instead of failing with `EINVAL`.
- [x] Bun integration coverage now verifies fail-open inheritance, fail-closed custom-status behavior, `$nftset_result` on lookup failure, dryrun behavior, directive inheritance across `server` / `location` blocks, and live membership hit/miss behavior in Docker-isolated nftables tests.
