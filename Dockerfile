ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.19

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG NGINX_VERSION

ENV NGINX_VERSION=${NGINX_VERSION:-"1.26.0"} \
    NGINX_AUTH_LDAP_VERSION=master \
    NGINX_BROTLI_VERSION=6e975bcb015f62e1f303054897783355e2a877dc \
    NGINX_USER=nginx \
    NGINX_GROUP=www-data \
    NGINX_WEBROOT=/www/html \
    IMAGE_NAME="tiredofit/nginx" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-nginx/"

RUN case "$(cat /etc/os-release | grep VERSION_ID | cut -d = -f 2 | cut -d . -f 1,2 | cut -d _ -f 1)" in \
        3.5 | 3.6 | 3.7 | 3.8 | 3.9 | 3.10 | 3.11 | 3.12 | 3.13 | 3.14 | 3.15 | 3.16 ) alpine_ssl=libressl ;; \
        3.17* | 3.18* | 3.19* | 3.20* ) alpine_ssl=openssl ;; \
        *) : ;; \
    esac ; \
    source /assets/functions/00-container && \
    set -x && \
    sed -i "/www-data/d" /etc/group* && \
    addgroup -S -g 82 ${NGINX_GROUP} && \
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G ${NGINX_GROUP} -g "${NGINX_USER}" -u 80 ${NGINX_USER} && \
    package update && \
    package upgrade && \
    package install .nginx-build-deps \
                    gcc \
                    gd-dev \
                    geoip-dev \
                    libc-dev \
                    ${alpine_ssl}-dev \
                    libxslt-dev \
                    linux-headers \
                    make \
                    pcre-dev \
                    perl-dev \
                    tar \
                    zlib-dev \
                    && \
    \
    package install .brotli-build-deps \
                    autoconf \
                    automake \
                    cmake \
                    g++ \
                    git \
                    libtool \
                    && \
    \
    package install .auth-ldap-build-deps \
                    openldap-dev \
                    && \
    \
    mkdir -p /www /var/log/nginx && \
    chown -R ${NGINX_USER}:${NGINX_GROUP} /var/log/nginx && \
    clone_git_repo https://github.com/openresty/headers-more-nginx-module && \
    clone_git_repo https://github.com/kvspb/nginx-auth-ldap ${NGINX_LDAP_VERSION} && \
    clone_git_repo https://github.com/AirisX/nginx_cookie_flag_module && \
    clone_git_repo https://github.com/google/ngx_brotli ${NGINX_BROTLI_VERSION} && \
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
      --user=${NGINX_USER} \
      --group=${NGINX_GROUP} \
      --add-module=${GIT_REPO_SRC_NGINX_AUTH_LDAP} \
      --add-module=${GIT_REPO_SRC_NGX_BROTLI} \
      --add-module=${GIT_REPO_SRC_NGINX_COOKIE_FLAG_MODULE} \
      --add-module=${GIT_REPO_SRC_HEADERS_MORE_NGINX_MODULE} \
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
        | xargs -r package info --installed \
        | sort -u \
    )" && \
    \
    package install .nginx-run-deps \
                    $runDeps \
                    apache2-utils \
                    inotify-tools \
                    libldap \
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
    \
    package remove \
            .nginx-build-deps \
            .brotli-build-deps \
            .auth-ldap-build-deps \
            && \
    \
    package cleanup && \
    \
    rm -rf \
            /etc/nginx/*.default \
            /usr/src/* \
            /var/tmp/*

EXPOSE 80

COPY install /
