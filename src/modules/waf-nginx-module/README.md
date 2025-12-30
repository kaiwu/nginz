## Web Application Firewall Module

Native web application firewall for nginx with common attack detection.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **SQL Injection Detection**: Pattern-based SQLi detection
- **XSS Detection**: Cross-site scripting attack prevention
- **Command Injection**: Shell command injection detection
- **Path Traversal**: LFI/RFI attack prevention
- **Custom Rules**: Regex-based custom rule support
- **OWASP CRS Compatible**: Support for OWASP Core Rule Set format
- **Modes**: Detection-only or prevention mode
- **IP Reputation**: Optional IP blocklist integration

### Planned Directives

#### waf

*syntax:* `waf on|off;`  
*default:* `waf off;`  
*context:* `location`

Enable or disable the WAF.

#### waf_mode

*syntax:* `waf_mode detect|prevent;`  
*default:* `waf_mode detect;`  
*context:* `location`

WAF operation mode - log only or actively block.

#### waf_rules

*syntax:* `waf_rules <file>;`  
*context:* `location`

Load custom rules from file.

#### waf_sqli

*syntax:* `waf_sqli on|off;`  
*default:* `waf_sqli on;`  
*context:* `location`

Enable SQL injection detection.

#### waf_xss

*syntax:* `waf_xss on|off;`  
*default:* `waf_xss on;`  
*context:* `location`

Enable XSS detection.

### Planned Usage

```nginx
http {
    server {
        location /api {
            waf on;
            waf_mode prevent;
            waf_sqli on;
            waf_xss on;
            
            proxy_pass http://backend;
        }
        
        location /admin {
            waf on;
            waf_mode prevent;
            waf_rules /etc/nginx/waf/admin-rules.conf;
            
            proxy_pass http://admin-backend;
        }
    }
}
```

### References

- [ModSecurity](https://modsecurity.org/)
- [OWASP Core Rule Set](https://coreruleset.org/)
- [lua-resty-waf](https://github.com/p0pr0ck5/lua-resty-waf)
