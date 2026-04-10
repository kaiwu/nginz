## Web Application Firewall Module

Native web application firewall for nginx with SQL injection and XSS attack detection.

### Status

**Implemented** - Native SQLi/XSS detection, libinjection-backed checks, and a small file-driven ModSecurity-like subset

### Features

- **SQL Injection Detection**: Pattern-based SQLi detection covering:
  - Comment-based attacks (`'--`, `/*`, `*/`)
  - Boolean-based attacks (`' or 1=1`, `or '1'='1`)
  - Union-based attacks (`union select`)
  - Keyword-based attacks (`select`, `insert`, `update`, `delete`, `drop`)
  - Time-based attacks (`sleep(`, `waitfor delay`, `benchmark(`)

- **XSS Detection**: Cross-site scripting attack prevention covering:
  - Script tags (`<script>`, `</script>`)
  - JavaScript/VBScript protocols (`javascript:`, `vbscript:`)
  - Event handlers (`onerror=`, `onclick=`, `onload=`, etc.)
  - DOM manipulation (`document.cookie`, `document.write`, `.innerhtml`)
  - Script functions (`alert(`, `eval(`, `prompt(`)
  - HTML injection vectors (`<img`, `<svg`, `<iframe`, etc.)

- **URL Decoding**: Automatically decodes URL-encoded payloads (`%27` → `'`)
- **Case Insensitive**: Matches patterns regardless of case
- **libinjection Integration**: Uses vendored `libinjection` for stronger SQLi and XSS detection before falling back to native substring signatures
- **Request Body Inspection**: Optional scanning of POST/PUT/PATCH request bodies
- **Modes**: Detection-only (log) or prevention (block) mode

### Directives

#### waf

*syntax:* `waf on|off;`
*default:* `waf off;`
*context:* `location`

Enable or disable the WAF for this location.

#### waf_mode

*syntax:* `waf_mode detect|block;`
*default:* `waf_mode block;`
*context:* `location`

WAF operation mode:
- `detect`: Log attacks but allow requests to pass
- `block`: Block requests and return 403 Forbidden with JSON error

#### waf_sqli

*syntax:* `waf_sqli on|off;`
*default:* `waf_sqli on;`
*context:* `location`

Enable or disable SQL injection detection.

#### waf_xss

*syntax:* `waf_xss on|off;`
*default:* `waf_xss on;`
*context:* `location`

Enable or disable XSS detection.

#### waf_check_body

*syntax:* `waf_check_body on|off;`
*default:* `waf_check_body off;`
*context:* `location`

Enable request body inspection for POST/PUT/PATCH requests.

#### waf_rules_file

*syntax:* `waf_rules_file <path>;`
*default:* none
*context:* `location`

Load a native ModSecurity-like rule file at config load time.

Current supported subset:

- one rule per line starting with `SecRule`
- targets: `REQUEST_URI`, `ARGS`, `REQUEST_BODY`, `REQUEST_HEADERS`, `REQUEST_COOKIES`, `REQUEST_METHOD`, `REMOTE_ADDR`
- scoped selectors on:
  - `ARGS:name`
  - `REQUEST_HEADERS:Header-Name`
  - `REQUEST_COOKIES:cookie_name`
- operators:
  - `@contains <needle>`
  - `@streq <value>` / `@eq <value>`
  - `@rx <pattern>`
  - `@libinjection_sqli`
  - `@libinjection_xss`
- actions subset: `id:<n>`, `phase:1|2`, `msg:'...'`, plus tolerated `deny`, `log`, `t:none`
  - `status:<code>`

Example:

```nginx
location /api {
    waf on;
    waf_mode block;
    waf_sqli off;
    waf_xss off;
    waf_rules_file /etc/nginz/waf/basic.rules;
}
```

Example rule file:

```text
SecRule ARGS "@contains union select" "id:1001,phase:1,msg:'basic SQLi needle'"
SecRule REQUEST_BODY "@contains <script" "id:1002,phase:2,msg:'basic body XSS needle'"
SecRule REQUEST_HEADERS "@contains x-api-key: bad-value" "id:1003,phase:1,msg:'header needle'"
SecRule ARGS "@libinjection_sqli" "id:2001,phase:1,msg:'libinjection SQLi rule'"
SecRule REQUEST_BODY "@libinjection_xss" "id:2002,phase:2,msg:'libinjection XSS rule'"
SecRule REQUEST_HEADERS:X-Scoped-Header "@contains secret-value" "id:2003,phase:1,msg:'scoped header rule'"
SecRule ARGS:role "@contains admin" "id:2004,phase:1,msg:'scoped arg rule'"
SecRule REQUEST_METHOD "@streq patch" "id:2004,phase:1,msg:'exact method rule'"
SecRule REQUEST_URI "@rx regex-path-[0-9]+" "id:2005,phase:1,msg:'regex path rule'"
SecRule REQUEST_URI "@contains blocked-api" "id:2006,phase:1,status:406,msg:'custom status rule'"
```

### Detection stack

When `waf_sqli on;` or `waf_xss on;` is enabled, the module currently applies detection in this order:

1. URL-decode the inspected input
2. Run `libinjection` on the decoded value
3. Fall back to the module's native lowercase substring signatures

This keeps the native fast-path checks while improving detection for obfuscated payloads that the original substring matcher missed.

Inside `waf_rules_file`, `@libinjection_sqli` and `@libinjection_xss` can now be used explicitly as rule operators in the supported native subset.

#### waf_ban_threshold

*syntax:* `waf_ban_threshold <n>;`
*default:* `0`
*context:* `location`

Enable temporary IP bans after `<n>` WAF detections within the configured ban window.

#### waf_ban_window

*syntax:* `waf_ban_window <seconds>;`
*default:* `60`
*context:* `location`

Time window in seconds for counting repeated WAF detections toward a temporary ban.

#### waf_ban_duration

*syntax:* `waf_ban_duration <seconds>;`
*default:* `300`
*context:* `location`

Temporary ban duration in seconds once the threshold is reached.

### Practical policy note

Static IP allow/deny policy should continue to use nginx's built-in access controls (`allow` / `deny`).

`ngx_http_waf` is now focused on dynamic inspection, rule-driven blocking, and temporary shared-memory bans rather than duplicating nginx's coarse static IP ACL layer.

### Response Format

When a request is blocked, the module returns HTTP 403 with a JSON body:

```json
{"error":"waf_blocked","rule":"sqli"}
```

or

```json
{"error":"waf_blocked","rule":"xss"}
```

### Usage

```nginx
http {
    server {
        # Block both SQLi and XSS attacks
        location /api {
            waf on;
            waf_mode block;
            waf_sqli on;
            waf_xss on;
            waf_check_body on;

            proxy_pass http://backend;
        }

        # Detection-only mode for monitoring
        location /legacy {
            waf on;
            waf_mode detect;

            proxy_pass http://legacy-backend;
        }

        # Only check for SQLi (skip XSS)
        location /database-api {
            waf on;
            waf_sqli on;
            waf_xss off;

            proxy_pass http://db-backend;
        }

        # Disable WAF for trusted endpoints
        location /internal {
            waf off;

            proxy_pass http://internal-backend;
        }
    }
}
```

### Limitations

- Native pattern-based detection may still have false positives for certain legitimate inputs
- Limited to a small native subset of operators and actions; this is still far smaller than full ModSecurity syntax
- Request body inspection limited to 8KB for performance
- Temporary bans are shared-memory-based fixed-size counters keyed by client IP, not a full reputation engine yet
- `libinjection` improves SQLi/XSS coverage but does not make the module full ModSecurity or CRS compatible
- `waf_rules_file` currently supports only a small native ModSecurity-like subset, not full ModSecurity or CRS compatibility

### Future Enhancements

- OWASP Core Rule Set compatibility
- IP blocklist/allowlist integration
- Response body filtering
- Anomaly scoring mode

### References

- [OWASP SQL Injection Prevention](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)
- [OWASP XSS Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)

### Documentation Audit Checklist

- [x] Audit date: 2026-04-10
- [x] Bun integration coverage exists at `tests/waf/`.
- [x] Bun integration coverage now verifies nested child-location inheritance of detect mode, selective SQLi/XSS toggles, URL-decoded payloads, POST/PUT/PATCH body inspection, and detect-vs-block behavior.
- [x] Gap fixed in this audit pass: child locations under a parent `waf_mode detect` configuration now inherit detect mode correctly instead of silently falling back to block behavior.
- [x] Initial native ModSecurity-like subset is now implemented via `waf_rules_file`, with Bun coverage for file-driven `SecRule` matches on `REQUEST_URI`, `ARGS`, `REQUEST_BODY`, `REQUEST_HEADERS`, `REQUEST_COOKIES`, `REQUEST_METHOD`, and `REMOTE_ADDR` using `@contains` plus `phase` parsing.
- [x] `libinjection` is now vendored and compiled in-tree, and Bun coverage verifies improved detection of obfuscated SQLi/XSS payloads beyond the original substring signatures.
- [x] `waf_rules_file` now supports explicit `@libinjection_sqli` and `@libinjection_xss` operators with Bun coverage for file-driven rule execution.
- [x] `waf_rules_file` now supports `@rx`, equals-style operators, and scoped `REQUEST_HEADERS:<name>` / `REQUEST_COOKIES:<name>` selectors.
- [x] Shared-memory temporary IP bans are now supported via `waf_ban_threshold`, `waf_ban_window`, and `waf_ban_duration`, with Bun coverage for threshold, active ban, and expiry behavior.
- [x] `waf_rules_file` now supports `ARGS:name` selectors and per-rule `status:<code>` actions for more practical application-facing policies.
- [x] Static IP allow/deny remains intentionally delegated to nginx's built-in access controls rather than being reimplemented in the WAF module.
- [x] No additional documentation gaps were identified in this audit pass.
