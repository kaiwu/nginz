1. git submodule init
2. git submodule update
3. cd submodules/nginx \
    && ./auto/configure --with-http_ssl_module --with-debug
4. cp ./submodules/nginx/src/core/nginx.c ./submodules/nginx/objs/nginz.c \
    && patch ./submodules/nginx/objs/nginz.c < project/nginz.patch
