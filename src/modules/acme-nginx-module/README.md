## ACME/Let's Encrypt Module

Automatic SSL certificate provisioning and renewal using the ACME protocol.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Automatic Provisioning**: Request certificates automatically on first request
- **Auto-Renewal**: Background certificate renewal before expiration
- **Challenge Types**: HTTP-01, DNS-01, TLS-ALPN-01
- **Multiple Providers**: Let's Encrypt, ZeroSSL, BuyPass, custom ACME servers
- **Wildcard Support**: DNS-01 challenge for wildcard certificates
- **Account Management**: Automatic ACME account creation and storage

### Planned Directives

#### acme

*syntax:* `acme on|off;`  
*default:* `acme off;`  
*context:* `http`

Enable ACME certificate management.

#### acme_server

*syntax:* `acme_server <url>;`  
*default:* `acme_server https://acme-v02.api.letsencrypt.org/directory;`  
*context:* `http`

ACME directory URL.

#### acme_email

*syntax:* `acme_email <email>;`  
*context:* `http`

Account email for certificate notifications.

#### acme_domain

*syntax:* `acme_domain <domain>;`  
*context:* `server`

Domain to obtain certificate for.

#### acme_storage

*syntax:* `acme_storage <path>;`  
*default:* `acme_storage /etc/nginx/acme;`  
*context:* `http`

Path to store certificates and account data.

### Planned Usage

```nginx
http {
    acme on;
    acme_server https://acme-v02.api.letsencrypt.org/directory;
    acme_email admin@example.com;
    acme_storage /etc/nginx/acme;
    
    server {
        listen 443 ssl;
        server_name example.com www.example.com;
        
        acme_domain example.com;
        acme_domain www.example.com;
        
        # Certificates managed automatically
        ssl_certificate $acme_cert;
        ssl_certificate_key $acme_key;
    }
    
    server {
        listen 80;
        server_name example.com www.example.com;
        
        # ACME challenge location handled automatically
        location / {
            return 301 https://$host$request_uri;
        }
    }
}
```

### References

- [RFC 8555 - ACME Protocol](https://tools.ietf.org/html/rfc8555)
- [lua-resty-auto-ssl](https://github.com/auto-ssl/lua-resty-auto-ssl)
- [Let's Encrypt](https://letsencrypt.org/)
