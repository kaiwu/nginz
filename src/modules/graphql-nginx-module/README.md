## GraphQL Gateway Module

GraphQL-aware proxy with query validation, depth limiting, and caching.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Query Parsing**: Parse and analyze GraphQL queries
- **Depth Limiting**: Prevent deeply nested query attacks
- **Complexity Analysis**: Calculate and limit query complexity
- **Introspection Control**: Enable/disable schema introspection
- **Query Caching**: Cache query results with automatic invalidation
- **Field Authorization**: Role-based field access control
- **Persisted Queries**: Support for Apollo-style persisted queries

### Planned Directives

#### graphql

*syntax:* `graphql on|off;`  
*default:* `graphql off;`  
*context:* `location`

Enable GraphQL gateway features.

#### graphql_max_depth

*syntax:* `graphql_max_depth <number>;`  
*default:* `graphql_max_depth 10;`  
*context:* `location`

Maximum allowed query depth.

#### graphql_max_complexity

*syntax:* `graphql_max_complexity <number>;`  
*default:* `graphql_max_complexity 100;`  
*context:* `location`

Maximum allowed query complexity score.

#### graphql_introspection

*syntax:* `graphql_introspection on|off;`  
*default:* `graphql_introspection on;`  
*context:* `location`

Allow or block introspection queries.

#### graphql_cache

*syntax:* `graphql_cache <zone> [ttl];`  
*context:* `location`

Enable query result caching.

### Planned Usage

```nginx
http {
    graphql_cache_zone zone=gql:10m;
    
    server {
        location /graphql {
            graphql on;
            graphql_max_depth 5;
            graphql_max_complexity 50;
            graphql_introspection off;  # Disable in production
            graphql_cache gql 60s;
            
            proxy_pass http://graphql-backend;
        }
        
        location /graphql/admin {
            graphql on;
            graphql_introspection on;  # Allow for admin
            
            proxy_pass http://graphql-backend;
        }
    }
}
```

### References

- [GraphQL Specification](https://spec.graphql.org/)
- [Apollo Server](https://www.apollographql.com/docs/apollo-server/)
- [GraphQL Security Best Practices](https://www.apollographql.com/blog/graphql/security/why-you-should-disable-graphql-introspection-in-production/)
