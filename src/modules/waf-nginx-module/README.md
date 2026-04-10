## Web Application Firewall Module

Native web application firewall for nginx with SQL injection and XSS attack detection.

### Status

**Implemented** - Pattern-based SQLi and XSS detection

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
- operator: `@contains <needle>`
- actions subset: `id:<n>`, `phase:1|2`, `msg:'...'`, plus tolerated `deny`, `log`, `t:none`

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
```

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

- Pattern-based detection may have false positives for certain legitimate inputs
- Limited to predefined patterns (no custom regex support yet)
- Request body inspection limited to 8KB for performance
- No IP reputation or rate limiting integration
- `waf_rules_file` currently supports only a small native ModSecurity-like subset, not full ModSecurity or CRS compatibility

### Future Enhancements

- Custom rule support with regex patterns
- OWASP Core Rule Set compatibility
- IP blocklist/allowlist integration
- Request header inspection
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
- [x] No additional documentation gaps were identified in this audit pass.
