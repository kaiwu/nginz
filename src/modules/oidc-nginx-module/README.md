## OpenID Connect Module

OpenID Connect Relying Party implementation for nginx SSO integration.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Auto-Discovery**: Fetch IdP configuration from .well-known/openid-configuration
- **Authorization Code Flow**: Standard OIDC authorization code flow
- **PKCE Support**: Proof Key for Code Exchange for public clients
- **Token Refresh**: Automatic access token refresh using refresh tokens
- **Session Management**: Cookie-based session with configurable storage
- **Claim Extraction**: Extract ID token claims into nginx variables
- **Multiple IdPs**: Support for Keycloak, Auth0, Okta, Azure AD, Google, etc.

### Planned Directives

#### oidc

*syntax:* `oidc on|off;`  
*default:* `oidc off;`  
*context:* `location`

Enable OIDC authentication for the location.

#### oidc_discovery

*syntax:* `oidc_discovery <url>;`  
*context:* `location`

URL to OIDC discovery document.

#### oidc_client_id

*syntax:* `oidc_client_id <id>;`  
*context:* `location`

OAuth 2.0 client ID.

#### oidc_client_secret

*syntax:* `oidc_client_secret <secret>;`  
*context:* `location`

OAuth 2.0 client secret.

#### oidc_redirect_uri

*syntax:* `oidc_redirect_uri <uri>;`  
*context:* `location`

Callback URI for authorization code.

#### oidc_scope

*syntax:* `oidc_scope <scopes>;`  
*default:* `oidc_scope "openid profile email";`  
*context:* `location`

OAuth 2.0 scopes to request.

### Planned Usage

```nginx
server {
    listen 443 ssl;
    server_name app.example.com;
    
    location / {
        oidc on;
        oidc_discovery https://keycloak.example.com/realms/myrealm/.well-known/openid-configuration;
        oidc_client_id my-nginx-client;
        oidc_client_secret my-client-secret;
        oidc_redirect_uri https://app.example.com/callback;
        oidc_scope "openid profile email";
        
        # Pass user info to backend
        proxy_set_header X-User-Email $oidc_claim_email;
        proxy_set_header X-User-Name $oidc_claim_name;
        proxy_set_header X-User-Sub $oidc_claim_sub;
        
        proxy_pass http://backend;
    }
    
    location /callback {
        # Handled internally by OIDC module
        oidc on;
    }
    
    location /logout {
        # Clear session and redirect to IdP logout
        oidc_logout;
    }
}
```

### References

- [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html)
- [lua-resty-openidc](https://github.com/zmartzone/lua-resty-openidc)
- [NGINX Plus OIDC](https://docs.nginx.com/nginx/deployment-guides/single-sign-on/)
