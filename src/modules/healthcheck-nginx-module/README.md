## Health Check Module

Health status endpoints for Kubernetes probes and load balancer health checks.

### Status

**Implemented** - Basic functionality complete

### Features

- **Health Status**: JSON endpoint with health metrics and status
- **Liveness Probe**: Kubernetes-compatible `/healthz` endpoint
- **Readiness Probe**: Kubernetes-compatible `/ready` endpoint
- **JSON Responses**: Machine-readable health information

### Directives

#### health_status

*syntax:* `health_status;`
*context:* `location`

Enable detailed health status endpoint. Returns JSON with health metrics.

#### health_liveness

*syntax:* `health_liveness;`
*context:* `location`

Enable liveness probe endpoint. Always returns 200 if nginx is running.

#### health_readiness

*syntax:* `health_readiness;`
*context:* `location`

Enable readiness probe endpoint. Returns 200 when ready to serve traffic, 503 otherwise.

### Usage

```nginx
http {
    server {
        listen 8080;

        # Detailed health status
        location /health {
            health_status;
        }

        # Kubernetes liveness probe
        location /healthz {
            health_liveness;
        }

        # Kubernetes readiness probe
        location /ready {
            health_readiness;
        }

        # Application endpoints
        location / {
            proxy_pass http://backend;
        }
    }
}
```

### Response Examples

**health_status:**
```json
{
  "status": "healthy",
  "healthy": true,
  "ready": true,
  "requests": 12345,
  "failed": 5,
  "success_rate": 99
}
```

**health_liveness:**
```json
{"status": "alive"}
```

**health_readiness:**
```json
{"status": "ready"}
```

### Kubernetes Configuration

```yaml
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: nginx
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 5
```

### Load Balancer Configuration

**AWS ALB:**
```
Health check path: /health
Healthy threshold: 2
Unhealthy threshold: 3
Interval: 30 seconds
```

### Limitations

Current implementation has these limitations:

- **No Active Probing**: Does not actively probe upstream servers
- **Per-Worker State**: Health state is per-worker, not shared
- **No Upstream Integration**: Does not mark upstream servers up/down

### Future Enhancements

- **Active Health Checks**: Periodic probes to upstream servers
- **Upstream Integration**: Mark servers healthy/unhealthy based on probes
- **Shared State**: Cross-worker health state using shared memory
- **Custom Match Rules**: Validate response body/headers
- **Slow Start**: Gradually increase traffic to recovered servers

### References

- [Kubernetes Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [NGINX Plus Health Checks](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-health-check/)
