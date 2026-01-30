## Prometheus Metrics Module

Native Prometheus metrics exporter for nginx.

### Status

**Implemented** - Core functionality complete with histograms

### Features

- **Request Counters**: Total requests, requests by status code class (1xx-5xx)
- **Latency Histogram**: Request duration with standard buckets (5ms to 10s)
- **Metrics Endpoint**: Exposes `/metrics` in Prometheus exposition format
- **Self-Exclusion**: Metrics endpoint requests are not counted

### Metrics Exposed

```
# HELP nginx_up Whether nginx is up
# TYPE nginx_up gauge
nginx_up 1

# HELP nginx_http_requests_total Total number of HTTP requests
# TYPE nginx_http_requests_total counter
nginx_http_requests_total 12345

# HELP nginx_http_requests_by_status HTTP requests by status code class
# TYPE nginx_http_requests_by_status counter
nginx_http_requests_by_status{status="1xx"} 0
nginx_http_requests_by_status{status="2xx"} 10000
nginx_http_requests_by_status{status="3xx"} 500
nginx_http_requests_by_status{status="4xx"} 800
nginx_http_requests_by_status{status="5xx"} 45

# HELP nginx_http_request_duration_seconds Request duration in seconds
# TYPE nginx_http_request_duration_seconds histogram
nginx_http_request_duration_seconds_bucket{le="0.005"} 5000
nginx_http_request_duration_seconds_bucket{le="0.01"} 7500
nginx_http_request_duration_seconds_bucket{le="0.025"} 9000
nginx_http_request_duration_seconds_bucket{le="0.05"} 10500
nginx_http_request_duration_seconds_bucket{le="0.1"} 11200
nginx_http_request_duration_seconds_bucket{le="0.25"} 11800
nginx_http_request_duration_seconds_bucket{le="0.5"} 12100
nginx_http_request_duration_seconds_bucket{le="1"} 12300
nginx_http_request_duration_seconds_bucket{le="2.5"} 12340
nginx_http_request_duration_seconds_bucket{le="5"} 12344
nginx_http_request_duration_seconds_bucket{le="10"} 12345
nginx_http_request_duration_seconds_bucket{le="+Inf"} 12345
nginx_http_request_duration_seconds_sum 125.432
nginx_http_request_duration_seconds_count 12345
```

### Directives

#### prometheus_metrics

*syntax:* `prometheus_metrics;`
*context:* `location`

Expose the `/metrics` endpoint at this location. Returns metrics in Prometheus text exposition format.

### Usage

```nginx
http {
    server {
        listen 8080;

        # Your application endpoints
        location / {
            proxy_pass http://backend;
        }

        # Prometheus metrics endpoint
        location /metrics {
            prometheus_metrics;

            # Optional: restrict access to monitoring systems
            allow 10.0.0.0/8;
            allow 127.0.0.1;
            deny all;
        }
    }
}
```

### Prometheus Configuration

Add to your `prometheus.yml`:

```yaml
scrape_configs:
  - job_name: 'nginx'
    static_configs:
      - targets: ['nginx-server:8080']
    metrics_path: '/metrics'
```

### Limitations

Current implementation has these limitations:

- **Per-Worker Counters**: Metrics are per-worker process and reset on reload/restart
- **No Shared Memory**: Counters are not aggregated across workers

For production use with multiple workers, consider using a single worker or external aggregation.

### Future Enhancements

- **Shared Memory**: Cross-worker metrics aggregation using nginx shared zones
- **Connection Metrics**: Active connections, accepted, handled
- **Upstream Metrics**: Upstream response times, failures
- **Custom Labels**: Add labels from nginx variables
- **Configurable Buckets**: Custom histogram bucket boundaries

### References

- [Prometheus Exposition Format](https://prometheus.io/docs/instrumenting/exposition_formats/)
- [nginx-prometheus-exporter](https://github.com/nginxinc/nginx-prometheus-exporter)
