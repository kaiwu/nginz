## Circuit Breaker Module

Circuit breaker pattern implementation for nginx to protect backends from cascading failures.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Three States**: Closed (normal), Open (fail-fast), Half-Open (testing)
- **Configurable Thresholds**: Failure count before opening, successes before closing
- **Timeout Recovery**: Automatic transition to half-open after timeout
- **Per-Upstream Circuits**: Independent circuit state per upstream
- **Shared State**: Cross-worker circuit state via shared memory
- **Metrics Export**: Circuit state exposed as nginx variables

### Planned Directives

#### circuit_breaker

*syntax:* `circuit_breaker on|off;`  
*default:* `circuit_breaker off;`  
*context:* `location`

Enable circuit breaker for the location.

#### circuit_breaker_threshold

*syntax:* `circuit_breaker_threshold <failures>;`  
*default:* `circuit_breaker_threshold 5;`  
*context:* `location`

Number of failures before opening the circuit.

#### circuit_breaker_timeout

*syntax:* `circuit_breaker_timeout <time>;`  
*default:* `circuit_breaker_timeout 30s;`  
*context:* `location`

Time before transitioning from open to half-open state.

#### circuit_breaker_success_threshold

*syntax:* `circuit_breaker_success_threshold <successes>;`  
*default:* `circuit_breaker_success_threshold 2;`  
*context:* `location`

Number of successes in half-open state before closing the circuit.

### Planned Usage

```nginx
upstream backend {
    server 10.0.0.1:8080;
    server 10.0.0.2:8080;
}

location /api {
    circuit_breaker on;
    circuit_breaker_threshold 5;
    circuit_breaker_timeout 30s;
    circuit_breaker_success_threshold 2;
    
    proxy_pass http://backend;
}

# Expose circuit state for monitoring
location /circuit-status {
    return 200 "state: $circuit_breaker_state\nfailures: $circuit_breaker_failures";
}
```

### Circuit States

```
     failures >= threshold
  ┌─────────────────────────┐
  │                         ▼
┌─┴────┐  timeout    ┌──────────┐
│CLOSED│◄────────────│   OPEN   │
└──────┘             └────┬─────┘
  ▲                       │
  │  successes >=         │ timeout
  │  threshold            ▼
  │               ┌───────────┐
  └───────────────│ HALF-OPEN │
       success    └───────────┘
```

### References

- [Circuit Breaker Pattern](https://martinfowler.com/bliki/CircuitBreaker.html)
- [Netflix Hystrix](https://github.com/Netflix/Hystrix)
