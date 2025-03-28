.PHONY: copy clean all

all: ./submodules/nginx/objs/nginz.c

./submodules/nginx/objs/ngx_modules.c:
	cd submodules/nginx && ./auto/configure --with-http_ssl_module --with-http_xslt_module --with-debug
	cd submodules/njs && ./configure

copy: ./submodules/nginx/src/core/nginx.c ./submodules/nginx/objs/ngx_modules.c
	cp ./submodules/nginx/src/core/nginx.c ./submodules/nginx/objs/nginz.c

./submodules/nginx/objs/nginz.c: copy
	patch ./submodules/nginx/objs/nginz.c < project/nginz.patch

clean:
	rm -f ./submodules/nginx/objs/ngx_modules.c ./submodules/nginx/objs/nginz.c
