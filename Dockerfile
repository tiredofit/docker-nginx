ARG ALPINE_VERSION=3.16

FROM docker.io/tiredofit/alpine:${ALPINE_VERSION}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Set Nginx Version Number
ENV NGINX_VERSION=1.23.1 \
    NGINX_AUTH_LDAP_VERSION=master \
    NGINX_BROTLI_VERSION=9aec15e2aa6feea2113119ba06460af70ab3ea62 \
    NGINX_USER=nginx \
    NGINX_GROUP=www-data \
    NGINX_WEBROOT=/www/html \
    IMAGE_NAME="tiredofit/nginx" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-nginx/"

### Install Nginx
RUN set -x && \
    sed -i "/www-data/d" /etc/group* && \
    addgroup -S -g 82 www-data && \
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G www-data -g "nginx" -u 80 nginx && \
    apk update && \
    apk upgrade && \
    apk add -t .nginx-build-deps \
                gcc \
                gd-dev \
                geoip-dev \
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
    apk add -t .auth-ldap-build-deps \
                openldap-dev \
                && \
    \
    mkdir -p /www /var/log/nginx && \
    chown -R nginx:www-data /var/log/nginx && \
    git clone --recursive https://github.com/openresty/headers-more-nginx-module.git /usr/src/headers-more-nginx-module && \
    git clone --recursive https://github.com/google/ngx_brotli.git /usr/src/nginx-brotli && \
    git clone --recursive https://github.com/AirisX/nginx_cookie_flag_module /usr/src/nginx_cookie_flag_module && \
    cd /usr/src/nginx-brotli && \
    git checkout -b $NGINX_BROTLI_VERSION $NGINX_BROTLI_VERSION && \
    cd /usr/src && \
    git clone https://github.com/kvspb/nginx-auth-ldap /usr/src/nginx-auth-ldap && \
    mkdir -p /usr/src/nginx && \
    curl -sSL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/nginx && \
    cd /usr/src/nginx && \
    ./configure --prefix=/etc/nginx \
      --sbin-path=/usr/sbin/nginx \
      --modules-path=/usr/lib/nginx/modules \
      --conf-path=/etc/nginx/nginx.conf \
      --error-log-path=/dev/null \
      --http-log-path=/dev/null \
      --pid-path=/var/run/nginx.pid \
      --lock-path=/var/run/nginx.lock \
      --http-client-body-temp-path=/var/cache/nginx/client_temp \
      --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
      --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
      --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
      --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
      --user=nginx \
      --group=www-data \
      --add-module=/usr/src/headers-more-nginx-module \
      --add-module=/usr/src/nginx-auth-ldap \
      --add-module=/usr/src/nginx-brotli \
      --add-module=/usr/src/nginx_cookie_flag_module \
      ## GCC 11.2 fix https://github.com/google/ngx_brotli/issues/124
      --with-cc-opt='-Wno-vla-parameter' \
      --with-compat \
      --with-file-aio \
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
      --with-http_slice_module \
      --with-http_ssl_module \
      --with-http_stub_status_module \
      --with-http_sub_module \
      --with-http_v2_module \
      --with-http_xslt_module=dynamic \
      --with-mail \
      --with-mail_ssl_module \
      --with-stream \
      --with-stream_geoip_module=dynamic \
      --with-stream_realip_module \
      --with-stream_ssl_module \
      --with-stream_ssl_preread_module \
      --with-threads \
#      --with-quiche=/usr/src/quiche \
#     --with-http_v3_module \
    && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    rm -rf /etc/nginx/html/ && \
    mkdir -p /etc/nginx/sites.enabled && \
    mkdir -p /etc/nginx/sites.available && \
    mkdir -p /usr/share/nginx/html/ && \
    install -m644 html/index.html /usr/share/nginx/html/ && \
    install -m644 html/50x.html /usr/share/nginx/html/ && \
    ln -s ../../usr/lib/nginx/modules /etc/nginx/modules && \
    strip /usr/sbin/nginx* && \
    strip /usr/lib/nginx/modules/*.so && \
    \
    runDeps="$( \
      scanelf --needed --nobanner /usr/sbin/nginx /usr/lib/nginx/modules/*.so /tmp/envsubst \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
    )" && \
    \
    apk add -t .nginx-run-deps \
        $runDeps \
        apache2-utils \
        inotify-tools \
        && \
    \
    mkdir -p /etc/nginx/snippets/blockbots && \
    mkdir -p /etc/nginx/snippets/blockbots-custom && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/bad-referrer-words.conf -o /etc/nginx/snippets/blockbots/bad-referrer-words.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/bad-referrers.conf -o /etc/nginx/snippets/blockbots/bad-referrers.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blacklist-ips.conf -o /etc/nginx/snippets/blockbots/blacklist-ips.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blacklist-user-agents.conf -o /etc/nginx/snippets/blockbots/blacklist-user-agents.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf -o /etc/nginx/snippets/blockbots/blockbots.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/custom-bad-referrers.conf -o /etc/nginx/snippets/blockbots/custom-bad-referrers.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf -o /etc/nginx/snippets/blockbots/ddos.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-domains.conf -o /etc/nginx/snippets/blockbots/whitelist-domains.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-ips.conf -o /etc/nginx/snippets/blockbots/whitelist-ips.conf && \
    curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -o /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    sed -i "s|/etc/nginx/bots.d/|/etc/nginx/snippets/blockbots/|g" /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    sed -i "s|/etc/nginx/snippets/blockbots/bad-referrer-words.conf|/etc/nginx/snippets/blockbots-custom/bad-referrer-words.conf|g" /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    sed -i "s|/etc/nginx/snippets/blockbots/blacklist-ips.conf|/etc/nginx/snippets/blockbots-custom/blacklist-ips.conf|g" /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    sed -i "s|/etc/nginx/snippets/blockbots/blacklist-user-agents.conf|/etc/nginx/snippets/blockbots-custom/blacklist-user-agents.conf|g" /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    sed -i "s|/etc/nginx/snippets/blockbots/whitelist-domains.conf|/etc/nginx/snippets/blockbots-custom/whitelist-domains.conf|g" /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    sed -i "s|/etc/nginx/snippets/blockbots/whitelist-ips.conf|/etc/nginx/snippets/blockbots-custom/whitelist-ips.conf|g" /etc/nginx/snippets/blockbots/globalblacklist.conf && \
    # Cleanup
    apk del .nginx-build-deps \
            .brotli-build-deps \
            .auth-ldap-build-deps \
            && \
    \
    rm -rf /etc/nginx/*.default /usr/src/* /var/tmp/* /var/cache/apk/*

### Networking Configuration
EXPOSE 80

### Files Addition
ADD install /
