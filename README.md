# hub.docker.com/r/tiredofit/nginx

[![Build Status](https://img.shields.io/docker/build/tiredofit/nginx.svg)](https://hub.docker.com/r/tiredofit/nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/nginx.svg)](https://hub.docker.com/r/tiredofit/nginx)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/nginx.svg)](https://hub.docker.com/r/tiredofit/nginx)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/nginx.svg)](https://microbadger.com/images/tiredofit/nginx)

## Introduction

This will build a container for [Nginx](https://www.nginx.org)

*    Tracks Mainline release channel
*    Many options configurable including compression, performance
*    Includes Zabbix Monitoring (nginx status) on port 73
*    Logrotate Included to roll over log files at 23:59, compress and retain for 7 days
*    Ability to Password Protect (Basic), LDAP Authenticate or use LemonLDAP:NG Handler

This Container uses [tiredofit/alpine](https://hub.docker.com/r/tiredofit/alpine) as a base.

[Changelog](CHANGELOG.md)

## Authors

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [Introduction](#introduction)
- [Authors](#authors)
- [Table of Contents](#table-of-contents)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Start](#quick-start)
- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Environment Variables](#environment-variables)
    - [Authentication Options](#authentication-options)
    - [Logging Options](#logging-options)
    - [Compression Options](#compression-options)
    - [DDoS Options](#ddos-options)
    - [Reverse Proxy Options](#reverse-proxy-options)
    - [Container Options](#container-options)
    - [Functionality Options](#functionality-options)
    - [Performance Options](#performance-options)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [References](#references)

## Prerequisites

This image assumes that you are using a reverse proxy such as
[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy
Companion @
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)
in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.

## Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/nginx) and is the recommended method of installation.

```bash
docker pull tiredofit/nginx
```

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary

## Configuration

### Data-Volumes

The container starts up and reads from `/etc/nginx/nginx.conf` for some basic configuration and to listen on port 73 internally for Nginx Status responses. `/etc/nginx/conf.d` contains a sample configuration file that can be used to customize a nginx server block.

The following directories are used for configuration and can be mapped for persistent storage.

| Directory   | Description                                                 |
| ----------- | ----------------------------------------------------------- |
| `/www/html` | Drop your Datafiles in this Directory to be served by Nginx |
| `/www/logs` | Logfiles for Nginx error and Access                         |


### Environment Variables


Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

#### Authentication Options

You can choose to request visitors be authenticated before accessing your site. Options are below.

| Parameter                                   | Description                                                                     | Default        |
| ------------------------------------------- | ------------------------------------------------------------------------------- | -------------- |
| `NGINX_AUTHENTICATION_TYPE`                 | Protect the site with `BASIC`, `LDAP`, `LLNG`                                   | `NONE`         |
| `NGINX_AUTHENTICATION_TITLE`                | Challenge response when visiting protected site                                 | `Please login` |
| `NGINX_AUTHENTICATION_BASIC_USER1`          | If `BASIC` chosen enter this for the username to protect site                   | `admin`        |
| `NGINX_AUTHENTICATION_BASIC_PASS1`          | If `BASIC` chosen enter this for the password to protect site                   | `password`     |
| `NGINX_AUTHENTICATION_BASIC_USER2`          | As above, increment for more users                                              |                |
| `NGINX_AUTHENTICATION_BASIC_PASS2`          | As above, increment for more users                                              |                |
| `NGINX_AUTHENTICATION_LDAP_HOST`            | Hostname and port number of LDAP Server - eg  `ldap://ldapserver:389`           |                |
| `NGINX_AUTHENTICATION_LDAP_BIND_DN`         | User to Bind to LDAP - eg   `cn=admin,dc=orgname,dc=org`                        |                |
| `NGINX_AUTHENTICATION_LDAP_BIND_PW`         | Password for Above Bind User - eg   `password`                                  |                |
| `NGINX_AUTHENTICATION_LDAP_BASE_DN`         | Base Distringuished Name - eg `dc=hostname,dc=com`                              |                |
| `NGINX_AUTHENTICATION_LDAP_ATTRIBUTE`       | Unique Identifier Attrbiute -ie  `uid`                                          |                |
| `NGINX_AUTHENTICATION_LDAP_SCOPE`           | LDAP Scope for searching - eg  `sub`                                            |                |
| `NGINX_AUTHENTICATION_LDAP_FILTER`          | Define what object that is searched for (ie  `objectClass=person`)              |                |
| `NGINX_AUTHENTICATION_LDAP_GROUP_ATTRIBUTE` | If searching inside of a group what is the Group Attribute - eg  `uniquemember` |                |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_HOST`    | If `LLNG` chosen use hostname of handler                                        | `llng-handler` |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_PORT`    | If `LLNG` chosen use this port for handler                                      | `2884`         |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1`      | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below               |                |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2`      | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below               |                |

When working with `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2` you will need to omit any `$` chracters from your string. It will be added in upon container startup. Example:
`NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1=HTTP_AUTH_USER,uid,upstream_http_uid` will get converted into `HTTP_AUTH_USER,$uid,$upstream_http_uid` and get placed in the appropriate areas in the configuration.


#### Logging Options

| Parameter                   | Description                               | Default           |
| --------------------------- | ----------------------------------------- | ----------------- |
| `NGINX_LOG_ACCESS_FILE`     | Nginx websites access logs                | `access.log`      |
| `NGINX_LOG_ACCESS_LOCATION` | Location inside container for saving logs | `/www/logs/nginx` |
| `NGINX_LOG_ERROR_FILE`      | Nginx server and websites error log name  | `error.log`       |
| `NGINX_LOG_ERROR_LOCATION`  | Location inside container for saving logs | `/www/logs/nginx` |
| `NGINX_LOG_LEVEL_ERROR`     | How much verbosity to use with error logs | `warn`            |

#### Compression Options

Presently you can compress your served content with gzip and brotli. More compression options to come in future..

| Parameter                             | Description                                  | Default                                                                                                  |
| ------------------------------------- | -------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `NGINX_ENABLE_COMPRESSION_BROTLI`     | Enable Brotli Compression                    | `TRUE`                                                                                                   |
| `NGINX_COMPRESSION_BROTLI_LEVEL`      | Compression Level for Brotli                 | `6`                                                                                                      |
| `NGINX_COMPRESSION_BROTLI_MIN_LENGTH` | Minimum length of content before compressing | `20`                                                                                                     |
| `NGINX_COMPRESSION_BROTLI_TYPES`      | What filetypes to compress                   | `text/plain text/css text/xml text/javascript application/x-javascript application/json application/xml` |
| `NGINX_COMPRESSION_BROTLI_WINDOW`     |                                              | `512k`                                                                                                   |
| `NGINX_ENABLE_COMPRESSION_GZIP`       | Enable GZIP Compression                      | `TRUE`                                                                                                   |
| `NGINX_COMPRESSION_GZIP_BUFFERS`      |                                              | `16 8k`                                                                                                  |
| `NGINX_COMPRESSION_GZIP_DISABLE`      | Don't compress for these user agents         | `MSIE [1-6].(?!.*SV1)`                                                                                   |
| `NGINX_COMPRESSION_GZIP_HTTP_VERSION` |                                              | `1.1`                                                                                                    |
| `NGINX_COMPRESSION_GZIP_LEVEL`        | Compression Level                            | `6`                                                                                                      |
| `NGINX_COMPRESSION_GZIP_MIN_LENGTH`   | Minimum length of content before compressing | `10240`                                                                                                  |
| `NGINX_COMPRESSION_GZIP_PROXIED`      |                                              | `expired no-cache no-store private auth`                                                                 |
| `NGINX_COMPRESSION_GZIP_TYPES`        | Types of content to compress                 | `text/plain text/css text/xml text/javascript application/x-javascript application/json application/xml` |
| `NGINX_COMPRESSION_GZIP_VARY`         |                                              | `TRUE`                                                                                                   |

#### DDoS Options

| Parameter                       | Description                        | Default |
| ------------------------------- | ---------------------------------- | ------- |
| `NGINX_ENABLE_DDOS_PROTECTION`  | Enable simple DDoS Protection      | `FALSE` |
| `NGINX_DDOS_CONNECTIONS_PER_IP` | Limit amount of connections per IP | `10m`   |
| `NGINX_DDOS_REQUESTS_PER_IP`    | Limit amount of requests per IP    | `5r/s`  |

#### Reverse Proxy Options

| Parameter                    | Description                                                       | Default           |
| ---------------------------- | ----------------------------------------------------------------- | ----------------- |
| `NGINX_ENABLE_FASTCGI_HTTPS` | Set fastcgi_param HTTPS 'on'                                      | `FALSE`           |
| `NGINX_ENABLE_REVERSE_PROXY` | Helpers for when behind a reverse proxy                           | `TRUE`            |
| `NGINX_REAL_IP_HEADER`       | What is the header passed containing the visitors IP              | `X-Forwarded-For` |
| `NGINX_SET_REAL_IP_FROM`     | Set the network of your Docker Network if having IP lookup issues | `172.16.0.0/12`   |

#### Container Options

| Parameter                                | Description                                                                              | Default     |
| ---------------------------------------- | ---------------------------------------------------------------------------------------- | ----------- |
| `NGINX_ENABLE_APPLICATION_CONFIGURATION` | Don't automatically setup /etc/nginx/conf.d files - Useful for volume mapping/overriding | `TRUE`      |
| `NGINX_ENABLE_CREATE_SAMPLE_HTML`        | If no index.html found - create a sample one to prove container works                    | `TRUE`      |
| `NGINX_ENABLE_SITE_OPTIMIZATIONS`        | Deny access to some files and URLs, send caching tags                                    | `TRUE`      |
| `NGINX_INCLUDE_CONFIGURATION`            | Include configuration in your website application file. eg `/www/website/nginx.conf`     |             |
| `NGINX_RELOAD_ON_CONFIG_CHANGE`          | Automatically reload nginx on configuration file change                                  | `FALSE`     |
| `NGINX_LISTEN_PORT`                      | Nginx listening port                                                                     | `80`        |
| `NGINX_WEBROOT`                          | Where to serve content from inside the container                                         | `/www/html` |

#### Functionality Options

| Parameter                 | Description                                                                           | Default    |
| ------------------------- | ------------------------------------------------------------------------------------- | ---------- |
| `FORCE_RESET_PERMISSIONS` | Force setting Nginx files ownership to web server user                                | `TRUE`     |
| `NGINX_MODE`              | Set to `NORMAL`, `MAINTENANCE` , `PROXY`, `REDIRECT`                                  | `NORMAL`   |
| `NGINX_REDIRECT_URL`      | If `REDIRECT` set enter full url to forward all traffic to eg `https://example.com`   |            |
| `NGINX_PROXY_URL`         | If `REDIRECT` set enter full url to proxy all traffic to eg `https://example.com:443` |            |
| `NGINX_USER`              | What user to run nginx as inside container                                            | `nginx`    |
| `NGINX_GROUP`             | What group to run nginx as inside container                                           | `www-data` |

If set to `MAINTNENANCE` a single page will show visitors that the server is being worked on.

You can also enter into the container and type `maintenance ARG`, where ARG is either `ON`,`OFF`, or `SLEEP (seconds)` which will temporarily place the site in maintenance mode and then restore it back to normal after time has passed.

#### Performance Options

| Parameter                                | Description                                                                             | Default  |
| ---------------------------------------- | --------------------------------------------------------------------------------------- | -------- |
| `NGINX_CLIENT_BODY_TIMEOUT`              | Request timed out                                                                       | `60`     |
| `NGINX_ENABLE_EPOLL`                     | Optmized to serve many clients with each thread, essential for linux                    | `TRUE`   |
| `NGINX_ENABLE_MULTI_ACCEPT`              | Accept as many connections as possible, may flood worker connections if set too low     | `TRUE`   |
| `NGINX_ENABLE_RESET_TIMEDOUT_CONNECTION` | Allow the server to close connection on non responding client, this will free up memory | `TRUE`   |
| `NGINX_ENABLE_SENDFILE`                  | Copies data between one FD and other from within the kernel                             | `TRUE`   |
| `NGINX_ENABLE_SERVER_TOKENS`             | Show Nginx version on responses                                                         | `FALSE`  |
| `NGINX_ENABLE_TCPNODELAY`                | Don't buffer data sent, good for small data bursts in real time                         | `TRUE`   |
| `NGINX_ENABLE_TCPNOPUSH`                 | Send headers in one peace, its better then sending them one by one                      | `TRUE`   |
| `NGINX_KEEPALIVE_REQUESTS`               | Number of requests client can make over keep-alive                                      | `100000` |
| `NGINX_KEEPALIVE_TIMEOUT`                | Server will close connection after this time                                            | `75`     |
| `NGINX_SEND_TIMEOUT`                     | If client stop responding, free up memory                                               | `60`     |
| `NGINX_UPLOAD_MAX_SIZE`                  | Maximum Upload Size                                                                     | `2G`     |
| `NGINX_WORKER_CONNECTIONS`               | Determines how much clients will be served per worker                                   | `1024`   |
| `NGINX_WORKER_PROCESSES`                 | How many processes to spawn                                                             | `auto`   |
| `NGINX_WORKER_RLIMIT_NOFILE`             | Number of file descriptors used for nginx                                               | `100000` |
| `NGINX_ENABLE_OPEN_FILE_CACHE`           | Cache informations about FDs, frequently accessed files                                 | `TRUE`   |
| `NGINX_ENABLE_OPEN_FILE_CACHE_ERRORS`    | Cache errors like 404                                                                   | `TRUE`   |
| `NGINX_OPEN_FILE_CACHE_INACTIVE`         | Stop caching after inactive                                                             | `5m`     |
| `NGINX_OPEN_FILE_CACHE_MAX`              | Maximum files to cache                                                                  | `200000` |
| `NGINX_OPEN_FILE_CACHE_MIN_USES`         | Minimum uses of file before cashing                                                     | `2`      |
| `NGINX_OPEN_FILE_CACHE_VALID`            | Cache a file if has been accessed within this window                                    | `2m`     |
| `NGINX_CLIENT_BODY_BUFFER_SIZE`          | Client Buffer size                                                                      | `16k`    |
| `NGINX_FASTCGI_BUFFERS`                  | Amount of FastCGI Buffers                                                               | `16 16k` |
| `NGINX_FASTCGI_BUFFER_SIZE`              | FastCGI Buffer Size                                                                     | `32k`    |

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is ie  nginx) bash
```

## References

* https://nginx.org/
