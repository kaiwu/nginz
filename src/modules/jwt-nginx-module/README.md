## JWT Authentication Module

Native JWT (JSON Web Token) authentication for nginx, providing token validation without external services.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Algorithm Support**: HS256, HS384, HS512, RS256, RS384, RS512, ES256, ES384, ES512
- **Token Sources**: Authorization header (Bearer), query parameter, cookie
- **Claims Validation**: exp, nbf, iss, aud, sub
- **Variable Export**: Extract claims into nginx variables for use in proxy headers
- **Key Management**: Static secrets, JWKS endpoints, public key files

### Planned Directives

#### jwt

*syntax:* `jwt on|off;`  
*default:* `jwt off;`  
*context:* `location`

Enable or disable JWT validation for the location.

#### jwt_secret

*syntax:* `jwt_secret <secret>;`  
*context:* `location`

Set the secret key for HMAC-based algorithms (HS256/384/512).

#### jwt_key_file

*syntax:* `jwt_key_file <path>;`  
*context:* `location`

Path to public key file for RSA/ECDSA algorithms.

#### jwt_claim_set

*syntax:* `jwt_claim_set $variable <claim>;`  
*context:* `location`

Extract a JWT claim into an nginx variable.

### Planned Usage

```nginx
location /api {
    jwt on;
    jwt_secret "your-256-bit-secret";
    jwt_claim_set $jwt_sub sub;
    
    proxy_set_header X-User-ID $jwt_sub;
    proxy_pass http://backend;
}
```

### References

- [RFC 7519 - JSON Web Token](https://tools.ietf.org/html/rfc7519)
- [NGINX Plus JWT Authentication](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-jwt-authentication/)
