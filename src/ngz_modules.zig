const ngx = @import("ngx/nginx.zig");
const ngx_module_t = ngx.module.ngx_module_t;

extern var ngx_core_module: ngx_module_t;
extern var ngx_errlog_module: ngx_module_t;
extern var ngx_conf_module: ngx_module_t;
extern var ngx_openssl_module: ngx_module_t;
extern var ngx_openssl_cache_module: ngx_module_t;
extern var ngx_regex_module: ngx_module_t;
extern var ngx_events_module: ngx_module_t;
extern var ngx_event_core_module: ngx_module_t;
extern var ngx_epoll_module: ngx_module_t;
extern var ngx_http_module: ngx_module_t;
extern var ngx_http_core_module: ngx_module_t;
extern var ngx_http_log_module: ngx_module_t;
extern var ngx_http_upstream_module: ngx_module_t;
extern var ngx_http_static_module: ngx_module_t;
extern var ngx_http_autoindex_module: ngx_module_t;
extern var ngx_http_index_module: ngx_module_t;
extern var ngx_http_mirror_module: ngx_module_t;
extern var ngx_http_try_files_module: ngx_module_t;
extern var ngx_http_auth_basic_module: ngx_module_t;
extern var ngx_http_access_module: ngx_module_t;
extern var ngx_http_limit_conn_module: ngx_module_t;
extern var ngx_http_limit_req_module: ngx_module_t;
extern var ngx_http_geo_module: ngx_module_t;
extern var ngx_http_map_module: ngx_module_t;
extern var ngx_http_split_clients_module: ngx_module_t;
extern var ngx_http_referer_module: ngx_module_t;
extern var ngx_http_rewrite_module: ngx_module_t;
extern var ngx_http_ssl_module: ngx_module_t;
extern var ngx_http_proxy_module: ngx_module_t;
extern var ngx_http_fastcgi_module: ngx_module_t;
extern var ngx_http_uwsgi_module: ngx_module_t;
extern var ngx_http_scgi_module: ngx_module_t;
extern var ngx_http_memcached_module: ngx_module_t;
extern var ngx_http_empty_gif_module: ngx_module_t;
extern var ngx_http_browser_module: ngx_module_t;
extern var ngx_http_upstream_hash_module: ngx_module_t;
extern var ngx_http_upstream_ip_hash_module: ngx_module_t;
extern var ngx_http_upstream_least_conn_module: ngx_module_t;
extern var ngx_http_upstream_random_module: ngx_module_t;
extern var ngx_http_upstream_keepalive_module: ngx_module_t;
extern var ngx_http_upstream_zone_module: ngx_module_t;
extern var ngx_http_write_filter_module: ngx_module_t;
extern var ngx_http_header_filter_module: ngx_module_t;
extern var ngx_http_chunked_filter_module: ngx_module_t;
extern var ngx_http_range_header_filter_module: ngx_module_t;
extern var ngx_http_gzip_filter_module: ngx_module_t;
extern var ngx_http_postpone_filter_module: ngx_module_t;
extern var ngx_http_ssi_filter_module: ngx_module_t;
extern var ngx_http_charset_filter_module: ngx_module_t;
extern var ngx_http_xslt_filter_module: ngx_module_t;
extern var ngx_http_userid_filter_module: ngx_module_t;
extern var ngx_http_headers_filter_module: ngx_module_t;
extern var ngx_http_copy_filter_module: ngx_module_t;
extern var ngx_http_range_body_filter_module: ngx_module_t;
extern var ngx_http_not_modified_filter_module: ngx_module_t;

extern var ngx_http_js_module: ngx_module_t;
extern var ngx_http_echoz_module: ngx_module_t;
extern var ngx_http_echoz_filter_module: ngx_module_t;
extern var ngx_http_wechatpay_module: ngx_module_t;
extern var ngx_http_wechatpay_filter_module: ngx_module_t;
extern var ngx_http_pgrest_module: ngx_module_t;

export const ngx_modules = [_][*c]ngx_module_t{
    &ngx_core_module,
    &ngx_errlog_module,
    &ngx_conf_module,
    &ngx_openssl_module,
    &ngx_openssl_cache_module,
    &ngx_regex_module,
    &ngx_events_module,
    &ngx_event_core_module,
    &ngx_epoll_module,
    &ngx_http_module,
    &ngx_http_core_module,
    &ngx_http_log_module,
    &ngx_http_upstream_module,
    &ngx_http_static_module,
    &ngx_http_autoindex_module,
    &ngx_http_index_module,
    &ngx_http_mirror_module,
    &ngx_http_try_files_module,
    &ngx_http_auth_basic_module,
    &ngx_http_access_module,
    &ngx_http_limit_conn_module,
    &ngx_http_limit_req_module,
    &ngx_http_geo_module,
    &ngx_http_map_module,
    &ngx_http_split_clients_module,
    &ngx_http_referer_module,
    &ngx_http_rewrite_module,
    &ngx_http_ssl_module,
    &ngx_http_proxy_module,
    &ngx_http_fastcgi_module,
    &ngx_http_uwsgi_module,
    &ngx_http_scgi_module,
    &ngx_http_memcached_module,
    &ngx_http_empty_gif_module,
    &ngx_http_js_module,
    &ngx_http_echoz_module,
    &ngx_http_wechatpay_module,
    &ngx_http_pgrest_module,
    &ngx_http_browser_module,
    &ngx_http_upstream_hash_module,
    &ngx_http_upstream_ip_hash_module,
    &ngx_http_upstream_least_conn_module,
    &ngx_http_upstream_random_module,
    &ngx_http_upstream_keepalive_module,
    &ngx_http_upstream_zone_module,
    &ngx_http_write_filter_module,
    &ngx_http_header_filter_module,
    &ngx_http_chunked_filter_module,
    &ngx_http_range_header_filter_module,
    &ngx_http_gzip_filter_module,
    &ngx_http_postpone_filter_module,
    &ngx_http_ssi_filter_module,
    &ngx_http_charset_filter_module,
    &ngx_http_xslt_filter_module,
    &ngx_http_userid_filter_module,
    &ngx_http_echoz_filter_module,
    &ngx_http_wechatpay_filter_module,
    &ngx_http_headers_filter_module,
    &ngx_http_copy_filter_module,
    &ngx_http_range_body_filter_module,
    &ngx_http_not_modified_filter_module,
    ngx.core.nullptr(ngx_module_t),
};

export const ngx_module_names = [_][*c]const u8{
    "ngx_core_module",
    "ngx_errlog_module",
    "ngx_conf_module",
    "ngx_openssl_module",
    "ngx_openssl_cache_module",
    "ngx_regex_module",
    "ngx_events_module",
    "ngx_event_core_module",
    "ngx_epoll_module",
    "ngx_http_module",
    "ngx_http_core_module",
    "ngx_http_log_module",
    "ngx_http_upstream_module",
    "ngx_http_static_module",
    "ngx_http_autoindex_module",
    "ngx_http_index_module",
    "ngx_http_mirror_module",
    "ngx_http_try_files_module",
    "ngx_http_auth_basic_module",
    "ngx_http_access_module",
    "ngx_http_limit_conn_module",
    "ngx_http_limit_req_module",
    "ngx_http_geo_module",
    "ngx_http_map_module",
    "ngx_http_split_clients_module",
    "ngx_http_referer_module",
    "ngx_http_rewrite_module",
    "ngx_http_ssl_module",
    "ngx_http_proxy_module",
    "ngx_http_fastcgi_module",
    "ngx_http_uwsgi_module",
    "ngx_http_scgi_module",
    "ngx_http_memcached_module",
    "ngx_http_empty_gif_module",
    "ngx_http_js_module",
    "ngx_http_echoz_module",
    "ngx_http_wechatpay_module",
    "ngx_http_pgrest_module",
    "ngx_http_browser_module",
    "ngx_http_upstream_hash_module",
    "ngx_http_upstream_ip_hash_module",
    "ngx_http_upstream_least_conn_module",
    "ngx_http_upstream_random_module",
    "ngx_http_upstream_keepalive_module",
    "ngx_http_upstream_zone_module",
    "ngx_http_write_filter_module",
    "ngx_http_header_filter_module",
    "ngx_http_chunked_filter_module",
    "ngx_http_range_header_filter_module",
    "ngx_http_gzip_filter_module",
    "ngx_http_postpone_filter_module",
    "ngx_http_ssi_filter_module",
    "ngx_http_charset_filter_module",
    "ngx_http_xslt_filter_module",
    "ngx_http_userid_filter_module",
    "ngx_http_echoz_filter_module",
    "ngx_http_wechatpay_filter_module",
    "ngx_http_headers_filter_module",
    "ngx_http_copy_filter_module",
    "ngx_http_range_body_filter_module",
    "ngx_http_not_modified_filter_module",
    ngx.core.nullptr(u8),
};
