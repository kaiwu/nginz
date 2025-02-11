## Nginz

nginz is a `nginx` module writer, which allows one to write nginx modules in `zig`. so far it 
is based on official nginx release 1.27.4 and zig 0.13. nginz is tested with linux only.

A typical scenario is following: 

```
$ git submodule init
$ git submodule update
$ zig build
$ zig build test
```

One might need to first address the system library dependencies, a requirement for nginx development.
specifically they are.
  
  * -lz
  * -lcrypt
  * -lcrypto
  * -lpcre
  * -lssl
  * -lgd

> [!NOTE]
> The SSL zig bindings are generated with `OpenSSL 3`.

To ease the development. A `nginz` binary is built as an artifact along with the module objects.
It is a nginx wrapper, and by default built with

`./auto/configure --with-http_ssl_module --with-debug` 

nginz also has built-in `ngx_http_js_module` with quickjs engine, excluding all the `xml/xslt` related features.

A module `echoz` is provided as an example, it is a tribute to @[agentzh][2] and his [echo][1] module. `echoz`
so far is a simplified version of `echo` and it misses some of the directives.

By all means, deploy the module objects with your own binary building toolchains.



[1]: https://github.com/openresty/echo-nginx-module "echo"
[2]: https://github.com/agentzh "agentzh"
