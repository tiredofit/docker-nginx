FROM tiredofit/alpine:3.10
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set Nginx Version Number
ENV NGINX_VERSION=1.17.6 \
    NGINX_AUTH_LDAP_VERSION=master \
    NGINX_BROTLI_VERSION=e505dce68acc190cc5a1e780a3b0275e39f160ca \
    NGINX_USER=nginx \
    NGINX_GROUP=www-data \
    NGINX_WEBROOT=/www/html

### Install Nginx
RUN set -x && \
    CONFIG="\
      --prefix=/etc/nginx \
      --sbin-path=/usr/sbin/nginx \
      --modules-path=/usr/lib/nginx/modules \
      --conf-path=/etc/nginx/nginx.conf \
      --error-log-path=/var/log/nginx/error.log \
      --http-log-path=/var/log/nginx/access.log \
      --pid-path=/var/run/nginx.pid \
      --lock-path=/var/run/nginx.lock \
      --http-client-body-temp-path=/var/cache/nginx/client_temp \
      --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
      --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
      --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
      --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
      --user=nginx \
      --group=www-data \
      --with-http_addition_module \
      --with-http_auth_request_module \
      --with-http_dav_module \
      --with-http_flv_module \
      --with-http_geoip_module=dynamic \
      --with-http_gunzip_module \
      --with-http_gzip_static_module \
      --with-http_image_filter_module=dynamic \
      --with-http_mp4_module \
      --with-http_perl_module=dynamic \
      --with-http_random_index_module \
      --with-http_realip_module \
      --with-http_secure_link_module \
      --with-http_ssl_module \
      --with-http_stub_status_module \
      --with-http_sub_module \
      --with-http_xslt_module=dynamic \
      --with-threads \
      --with-stream \
      --with-stream_ssl_module \
      --with-stream_ssl_preread_module \
      --with-stream_realip_module \
      --with-stream_geoip_module=dynamic \
      --with-http_slice_module \
      --with-mail \
      --with-mail_ssl_module \
      --with-compat \
      --with-file-aio \
      --with-http_v2_module \
#     --with-http_v3_module \
#      --with-quiche=/usr/src/quiche \
      --add-module=/usr/src/headers-more-nginx-module \
      --add-module=/usr/src/nginx-brotli \
      --add-module=/usr/src/nginx-auth-ldap \
    " && \
    addgroup -S www-data && \
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G www-data nginx && \
    apk update && \
    apk upgrade && \
    apk add -t .nginx-build-deps \
                gcc \
                gd-dev \
                geoip-dev \
                gnupg \
                libc-dev \
                libressl-dev \
                libxslt-dev \
                linux-headers \
                make \
                pcre-dev \
                perl-dev \
                tar \
                zlib-dev \
                && \
    \
    apk add -t .brotli-build-deps \
                autoconf \
                automake \
                cmake \
                g++ \
                git \
                libtool \
                && \
    \
#    apk add -t .quiche-build-deps \
#                cargo \
#                go \
#                rust \
#                && \
#    \
    apk add -t .auth-ldap-build-deps \
                openldap-dev \
                && \
    \
    mkdir -p /www /var/log/nginx && \
    chown -R nginx:www-data /var/log/nginx && \
#    git clone --recursive https://github.com/cloudflare/quiche /usr/src/quiche && \
    git clone --recursive https://github.com/openresty/headers-more-nginx-module.git /usr/src/headers-more-nginx-module && \
    git clone --recursive https://github.com/google/ngx_brotli.git /usr/src/nginx-brotli && \
    cd /usr/src/nginx-brotli && \
    git checkout -b $NGINX_BROTLI_VERSION $NGINX_BROTLI_VERSION && \
    cd /usr/src && \
    git clone https://github.com/kvspb/nginx-auth-ldap /usr/src/nginx-auth-ldap && \
    mkdir -p /usr/src/nginx && \
    curl -sSL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/nginx && \
    cd /usr/src/nginx && \
    ./configure $CONFIG --with-debug && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    mv objs/nginx objs/nginx-debug && \
    mv objs/ngx_http_xslt_filter_module.so objs/ngx_http_xslt_filter_module-debug.so && \
    mv objs/ngx_http_image_filter_module.so objs/ngx_http_image_filter_module-debug.so && \
    mv objs/ngx_http_geoip_module.so objs/ngx_http_geoip_module-debug.so && \
    mv objs/ngx_http_perl_module.so objs/ngx_http_perl_module-debug.so && \
    mv objs/ngx_stream_geoip_module.so objs/ngx_stream_geoip_module-debug.so && \
    ./configure $CONFIG && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    rm -rf /etc/nginx/html/ && \
    mkdir -p /etc/nginx/conf.d/ && \
    mkdir -p /usr/share/nginx/html/ && \
    install -m644 html/index.html /usr/share/nginx/html/ && \
    install -m644 html/50x.html /usr/share/nginx/html/ && \
    install -m755 objs/nginx-debug /usr/sbin/nginx-debug && \
    install -m755 objs/ngx_http_xslt_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_xslt_filter_module-debug.so && \
    install -m755 objs/ngx_http_image_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_image_filter_module-debug.so && \
    install -m755 objs/ngx_http_geoip_module-debug.so /usr/lib/nginx/modules/ngx_http_geoip_module-debug.so && \
    install -m755 objs/ngx_http_perl_module-debug.so /usr/lib/nginx/modules/ngx_http_perl_module-debug.so && \
    install -m755 objs/ngx_stream_geoip_module-debug.so /usr/lib/nginx/modules/ngx_stream_geoip_module-debug.so && \
    ln -s ../../usr/lib/nginx/modules /etc/nginx/modules && \
    strip /usr/sbin/nginx* && \
    strip /usr/lib/nginx/modules/*.so && \
    \
    apk add -t .gettext \
        gettext && \
    mv /usr/bin/envsubst /tmp/ && \
    \
    runDeps="$( \
      scanelf --needed --nobanner /usr/sbin/nginx /usr/lib/nginx/modules/*.so /tmp/envsubst \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
    )" && \
    \
    apk add \
        $runDeps \
        apache2-utils \
        && \
    apk del .nginx-build-deps && \
    apk del .brotli-build-deps && \
    apk del .auth-ldap-build-deps && \
#    apk del .quiche-build-deps && \
    apk del .gettext && \
    mv /tmp/envsubst /usr/local/bin/ && \
    \
    rm -rf /etc/nginx/*.default /usr/src/* /var/tmp/* /var/cache/apk/*

### Networking Configuration
EXPOSE 80

### Files Addition
ADD install /
