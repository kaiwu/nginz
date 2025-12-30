## Prometheus Metrics Module

Native Prometheus metrics exporter for nginx.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Request Metrics**: Total requests, requests by status code, method
- **Latency Histograms**: Request duration with configurable buckets
- **Connection Metrics**: Active connections, accepted, handled
- **Upstream Metrics**: Upstream response times, failures
- **Custom Labels**: Add custom labels from nginx variables
- **Shared Memory**: Cross-worker metrics aggregation

### Planned Metrics

```
# Request metrics
nginx_http_requests_total{method="GET",status="200",host="example.com"} 1234
nginx_http_request_duration_seconds_bucket{le="0.01"} 100
nginx_http_request_duration_seconds_bucket{le="0.1"} 500
nginx_http_request_duration_seconds_sum 123.45
nginx_http_request_duration_seconds_count 1234

# Connection metrics  
nginx_connections_active 50
nginx_connections_accepted_total 10000
nginx_connections_handled_total 10000

# Upstream metrics
nginx_upstream_requests_total{upstream="backend",server="10.0.0.1:8080"} 500
nginx_upstream_response_duration_seconds_sum{upstream="backend"} 45.67
```

### Planned Directives

#### prometheus

*syntax:* `prometheus on|off;`  
*default:* `prometheus off;`  
*context:* `http`

Enable Prometheus metrics collection.

#### prometheus_metrics

*syntax:* `prometheus_metrics;`  
*context:* `location`

Expose /metrics endpoint at this location.

#### prometheus_labels

*syntax:* `prometheus_labels <label=variable ...>;`  
*context:* `location`

Add custom labels from nginx variables.

#### prometheus_histogram_buckets

*syntax:* `prometheus_histogram_buckets <bucket1> <bucket2> ...;`  
*default:* `prometheus_histogram_buckets 0.005 0.01 0.025 0.05 0.1 0.25 0.5 1 2.5 5 10;`  
*context:* `http`

Configure histogram bucket boundaries.

### Planned Usage

```nginx
http {
    prometheus on;
    prometheus_histogram_buckets 0.01 0.05 0.1 0.5 1 5;
    
    server {
        listen 8080;
        
        location /metrics {
            prometheus_metrics;
            
            # Optional: restrict access
            allow 10.0.0.0/8;
            deny all;
        }
        
        location /api {
            prometheus_labels "service=api,version=$http_x_api_version";
            proxy_pass http://backend;
        }
    }
}
```

### References

- [Prometheus Exposition Format](https://prometheus.io/docs/instrumenting/exposition_formats/)
- [nginx-prometheus-exporter](https://github.com/nginxinc/nginx-prometheus-exporter)
- [NGINX Plus Prometheus Integration](https://docs.nginx.com/nginx/admin-guide/monitoring/prometheus/)
