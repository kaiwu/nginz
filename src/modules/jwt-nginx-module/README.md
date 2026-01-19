## JWT Authentication Module

JWT (JSON Web Token) validation for nginx access control.

### Status

**Implemented** - Basic functionality complete (HS256)

### Features

- **HS256 Validation**: HMAC-SHA256 signature verification
- **Bearer Token**: Extracts token from Authorization header
- **Claims Validation**: Checks `exp` (expiration) and `nbf` (not before)
- **Access Phase**: Runs in nginx access phase before content handlers

### Directives

#### jwt

*syntax:* `jwt;`
*context:* `location`

Enable JWT validation for this location. Requests without a valid token receive 401 Unauthorized.

#### jwt_secret

*syntax:* `jwt_secret <secret>;`
*context:* `location`

Set the HMAC secret key for HS256 signature validation. Can be inherited from parent locations.

### Usage

```nginx
http {
    server {
        listen 8080;

        # Protected API
        location /api {
            jwt;
            jwt_secret "your-secret-key-here";
            
            proxy_pass http://backend;
        }

        # Nested locations inherit secret
        location /admin {
            jwt_secret "admin-secret-key";
            
            location /admin/users {
                jwt;
                proxy_pass http://backend;
            }
            
            location /admin/public {
                # No jwt; directive - public access
                proxy_pass http://backend;
            }
        }

        # Public endpoints
        location /public {
            proxy_pass http://backend;
        }
    }
}
```

### Token Format

The module expects tokens in the Authorization header:

```http
GET /api/users HTTP/1.1
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyMTIzIiwiZXhwIjoxNzA1MDAwMDAwfQ.signature
```

### Token Structure

Standard JWT with three base64url-encoded parts:

```
header.payload.signature
```

**Header:**
```json
{"alg": "HS256", "typ": "JWT"}
```

**Payload (Claims):**
```json
{
  "sub": "user123",
  "exp": 1705000000,
  "nbf": 1704900000,
  "iat": 1704900000
}
```

### Claims Validation

| Claim | Description | Validation |
|-------|-------------|------------|
| `exp` | Expiration time (Unix timestamp) | Token rejected if current time > exp |
| `nbf` | Not before (Unix timestamp) | Token rejected if current time < nbf |

Tokens without `exp` or `nbf` claims pass validation (no time check).

### Response Codes

| Status | Reason |
|--------|--------|
| 200 | Valid token, access granted |
| 401 | Missing Authorization header |
| 401 | Invalid token format |
| 401 | Invalid signature |
| 401 | Token expired (exp) |
| 401 | Token not yet valid (nbf) |

### Limitations

Current implementation has these limitations:

- **HS256 Only**: Only HMAC-SHA256 algorithm supported
- **No RS256/ES256**: RSA and ECDSA algorithms not yet implemented
- **No Claims Extraction**: Claims not exposed as nginx variables
- **No Issuer Validation**: `iss` claim not validated
- **No Audience Validation**: `aud` claim not validated

### Future Enhancements

- **RS256/RS384/RS512**: RSA signature validation with public keys
- **ES256/ES384/ES512**: ECDSA signature validation
- **Claims as Variables**: Expose `$jwt_sub`, `$jwt_claim_xxx` variables
- **Issuer/Audience**: Validate `iss` and `aud` claims
- **JWK Support**: Fetch keys from JWKS endpoint
- **Token Refresh**: Automatic token refresh handling

### Generating Test Tokens

**Node.js:**
```javascript
const jwt = require('jsonwebtoken');
const token = jwt.sign(
  { sub: 'user123', exp: Math.floor(Date.now()/1000) + 3600 },
  'your-secret-key'
);
```

**Python:**
```python
import jwt
import time
token = jwt.encode(
    {'sub': 'user123', 'exp': int(time.time()) + 3600},
    'your-secret-key',
    algorithm='HS256'
)
```

### References

- [RFC 7519 - JSON Web Token](https://tools.ietf.org/html/rfc7519)
- [jwt.io](https://jwt.io/) - JWT debugger and library list
- [nginx-jwt-module](https://github.com/TeslaGov/ngx-http-auth-jwt-module)
