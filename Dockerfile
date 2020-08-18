FROM tiredofit/debian:buster
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set Nginx Version Number
ENV NGINX_VERSION=1.19.2 \
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
      --error-log-path=/dev/null \
      --http-log-path=/dev/null.log \
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
 #     --with-pcre=/usr/src/pcre \
 #     --with-pcre-jit \
 #     --with-zlib=/usr/src/zlib \
 #     --with-openssl=/usr/src/openssl \
 #     --with-openssl-opt=no-nextprotoneg \
#     --with-http_v3_module \
#      --with-quiche=/usr/src/quiche \
      --add-module=/usr/src/headers-more-nginx-module \
      --add-module=/usr/src/nginx-brotli \
      --add-module=/usr/src/nginx-auth-ldap \
      --add-module=/usr/src/nginx-ext-dav \
    " && \
    adduser --disabled-password --system --home /var/cache/nginx --shell /sbin/nologin --ingroup www-data nginx && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
                    build-essential \
                    git \
                    software-properties-common \
                    inotify-tools \
                    perl \
                    libperl-dev \
                    libgd3 \
                    libgd-dev \
                    libgeoip1 \
                    libgeoip-dev \
                    geoip-bin \
                    libxml2 \
                    libxml2-dev \
                    libxslt1.1 \
                    libxslt1-dev \
                    libpcre3 \ 
                    libpcre3-dev \ 
                    zlib1g \ 
                    zlib1g-dev \ 
                    openssl \ 
                    libssl-dev \ 
                    libldap2-dev \
                    && \
    \
    mkdir -p /www /var/log/nginx && \
    chown -R nginx:www-data /var/log/nginx && \
#    mkdir -p /usr/src/pcre && \
#    curl -ssL https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz | tar xvfz - --strip 1 -C /usr/src/pcre && \
#    mkdir -p /usr/src/zlib && \
#    curl -ssL https://www.zlib.net/zlib-1.2.11.tar.gz | tar xvfz - --strip 1 -C /usr/src/zlib && \
#    mkdir -p /usr/src/openssl && \
#    curl -ssL https://www.openssl.org/source/openssl-1.1.1c.tar.gz | tar xvfz - --strip 1 -C /usr/src/openssl && \
#    git clone --recursive https://github.com/cloudflare/quiche /usr/src/quiche && \
    git clone --recursive https://github.com/openresty/headers-more-nginx-module.git /usr/src/headers-more-nginx-module && \
    git clone --recursive https://github.com/google/ngx_brotli.git /usr/src/nginx-brotli && \
    cd /usr/src/nginx-brotli && \
    git checkout -b $NGINX_BROTLI_VERSION $NGINX_BROTLI_VERSION && \
    cd /usr/src && \
    git clone https://github.com/arut/nginx-dav-ext-module/ /usr/src/nginx-ext-dav && \
    git clone https://github.com/kvspb/nginx-auth-ldap /usr/src/nginx-auth-ldap && \
    mkdir -p /usr/src/nginx && \
    curl -sSL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/nginx && \
    cd /usr/src/nginx && \
    ./configure $CONFIG && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    rm -rf /etc/nginx/html/ && \
    mkdir -p /etc/nginx/conf.d/ && \
    mkdir -p /usr/share/nginx/html/ && \
    install -m644 html/index.html /usr/share/nginx/html/ && \
    install -m644 html/50x.html /usr/share/nginx/html/ && \
    ln -s ../../usr/lib/nginx/modules /etc/nginx/modules && \
    mkdir -p /var/log/nginx && \
    apt-get purge -y  build-essential \
                      git \
                      libgd-dev \
                      libgeoip-dev \
                      libldap2-dev \
                      libperl-dev \
                      libpcre3-dev \ 
                      libssl-dev \ 
                      libxml2-dev \
                      libxslt1-dev \
                      zlib1g-dev \ 
                      && \
    apt-get autoremove -y && \
    rm -rf /etc/nginx/*.default /usr/src/* /var/tmp/* /var/lib/apt/lists/*

### Networking Configuration
EXPOSE 80

### Files Addition
ADD install /
