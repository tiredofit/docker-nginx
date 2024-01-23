# github.com/tiredofit/docker-nginx


[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-nginx?style=flat-square)](https://github.com/tiredofit/docker-nginx/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-nginx/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-nginx/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/nginx.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/nginx/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/nginx.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/nginx/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

* * *

## About

This will build a Docker image for [Nginx](https://www.nginx.org), for serving websites

*    Tracks Mainline release channel
*    Many options configurable including compression, performance
*    Includes Monitoring (nginx status) on port 73
*    Includes [Nginx Ultimate Bad Bot Blocker](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker)
*    Logrotate Included to roll over log files at 23:59, compress and retain for 7 days
*    Ability to Password Protect (Basic), LDAP Authenticate or use LemonLDAP:NG Handler

## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Authentication Options](#authentication-options)
    - [Bot Blocking Options](#bot-blocking-options)
    - [Logging Options](#logging-options)
    - [Compression Options](#compression-options)
    - [DDoS Options](#ddos-options)
    - [Reverse Proxy Options](#reverse-proxy-options)
    - [Container Options](#container-options)
    - [Functionality Options](#functionality-options)
  - [Maintenance Options](#maintenance-options)
    - [Performance Options](#performance-options)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)

## Installation

### Build from Source
Clone this repository and build the image with `docker build <arguments> (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/nginx)

```
docker pull docker.io/tiredofit/nginx):(imagetag)
```

Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/docker-nginx/pkgs/container/docker-nginx)

```
docker pull ghcr.io/tiredofit/docker-nginx:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Alpine Base | Tag            | Debian Base | Tag                 |
| ----------- | -------------- | ----------- | ------------------- |
| latest      | `:latest`      | latest      | `:debian`           |
| latest      | `:alpine`      | Bookworm    | `:debian-bookworm ` |
| edge        | `:alpine-edge` | Bullseye    | `:debian-bullseye`  |
| 3.19        | `:alpine-3.19` | Buster      | `:debian-buster`    |
| 3.18        | `:alpine-3.18` |             |                     |
| 3.16        | `:alpine-3.16` |             |                     |
| 3.15        | `:alpine-3.15` |             |                     |
| 3.12        | `:alpine-3.12` |             |                     |
| 3.9         | `:alpine-3.9`  |             |                     |
| 3.7         | `:alpine-3.7`  |             |                     |
| 3.5         | `:alpine-3.5`  |             |                     |

```bash
docker pull docker.io/tiredofit/nginx:(imagetag)
```
#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary

The container starts up and reads from `/etc/nginx/nginx.conf` for some basic configuration and to listen on port 73 internally for Nginx Status responses. Configuration of websites are done in `/etc/services.available` with the filename pattern of `site.conf`. You must set an environment variable for `NGINX_SITE_ENABLED` if you have more than one configuration in there if you only want to enable one of the configurartions, otherwise it will enable all of them. Use `NGINX_SITE_ENABLED=null` to break a parent image declaration.

Use this as a starting point for your site configurations:
````nginx
  server {
      ### Don't Touch This
      listen {{NGINX_LISTEN_PORT}};
      server_name localhost;
      root {{NGINX_WEBROOT}};
      ###

      ### Populate your custom directives here
      index  index.html index.htm;

      location / {
      #
      }

      ### Don't edit past here

      include /etc/nginx/snippets/site_optimization.conf;
      include /etc/nginx/snippets/exploit_protection.conf;
}
````

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory   | Description                                                 |
| ----------- | ----------------------------------------------------------- |
| `/www/html` | Drop your Datafiles in this Directory to be served by Nginx |
| `/www/logs` | Logfiles for Nginx error and Access                         |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) or [Debian Linux](https://hub.docker.com/r/tiredofit/debian) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`, `nano`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [OS Base](https://github.com/tiredofit/docker-debian/) | Customized Image based on Debian Linux |

#### Authentication Options

You can choose to request visitors be authenticated before accessing your site. Options are below.

| Parameter                                   | Description                                                                                 | Default             | `_FILE` |
| ------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------- | ------- |
| `NGINX_AUTHENTICATION_TYPE`                 | Protect the site with `BASIC`, `LDAP`, `LLNG`                                               | `NONE`              |         |
| `NGINX_AUTHENTICATION_TITLE`                | Challenge response when visiting protected site                                             | `Please login`      |         |
| `NGINX_AUTHENTICATION_BASIC_USER1`          | If `BASIC` chosen enter this for the username to protect site                               | `admin`             | x       |
| `NGINX_AUTHENTICATION_BASIC_PASS1`          | If `BASIC` chosen enter this for the password to protect site                               | `password`          | x       |
| `NGINX_AUTHENTICATION_BASIC_USER2`          | As above, increment for more users                                                          |                     | x       |
| `NGINX_AUTHENTICATION_BASIC_PASS2`          | As above, increment for more users                                                          |                     | x       |
| `NGINX_AUTHENTICATION_LDAP_HOST`            | Hostname and port number of LDAP Server - eg  `ldap://ldapserver:389`                       |                     | x       |
| `NGINX_AUTHENTICATION_LDAP_BIND_DN`         | User to Bind to LDAP - eg   `cn=admin,dc=orgname,dc=org`                                    |                     | x       |
| `NGINX_AUTHENTICATION_LDAP_BIND_PW`         | Password for Above Bind User - eg   `password`                                              |                     | x       |
| `NGINX_AUTHENTICATION_LDAP_BASE_DN`         | Base Distringuished Name - eg `dc=hostname,dc=com`                                          |                     | x       |
| `NGINX_AUTHENTICATION_LDAP_ATTRIBUTE`       | Unique Identifier Attrbiute -ie  `uid`                                                      |                     |         |
| `NGINX_AUTHENTICATION_LDAP_SCOPE`           | LDAP Scope for searching - eg  `sub`                                                        |                     |         |
| `NGINX_AUTHENTICATION_LDAP_FILTER`          | Define what object that is searched for (ie  `objectClass=person`)                          |                     |         |
| `NGINX_AUTHENTICATION_LDAP_GROUP_ATTRIBUTE` | If searching inside of a group what is the Group Attribute - eg  `uniquemember`             |                     |         |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_HOST`    | If `LLNG` chosen use hostname and port of handler. Add multiple by seperating with comments | `llng-handler:2884` | x       |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_PORT`    | If `LLNG` chosen use this port for handler                                                  | `2884`              | x       |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1`      | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below                           |                     |         |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2`      | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below                           |                     |         |

When working with `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2` you will need to omit any `$` chracters from your string. It will be added in upon container startup. Example:
`NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1=HTTP_AUTH_USER,uid,upstream_http_uid` will get converted into `HTTP_AUTH_USER,$uid,$upstream_http_uid` and get placed in the appropriate areas in the configuration.

#### Bot Blocking Options

| Parameter                           | Description                                                                                                                                                                                                    | Default                                             |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| `NGINX_BLOCK_BOTS_WHITELIST_DOMAIN` | Domains to whitelist from blocking comma seperated e.g. `example1.com,example2.com`                                                                                                                            |                                                     |
| `NGINX_BLOCK_BOTS_WHITELIST_IP`     | IP Addresses/Networks to Whitelist from Blocking comma seperated                                                                                                                                               | `127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/24` |
| `NGINX_BLOCK_BOTS`                  | Bots to Block `ALL` `AOL` `BING` `DOCOMO` `DUCKDUCKGO` `FACEBOOK` `GOOGLE` `LINKEDIN` `MISC` `MSN` `SAMSUNG` `SLACK` `SLURP` `TWITTER` `WORDPRESS` `YAHOO` or `yourcustom-useragent` in Comma Seperated values |                                                     |
| `NGINX_ENABLE_BLOCK_BOTS`           | Block Bots and Crawlers                                                                                                                                                                                        | `FALSE`                                             |

For more details on how Bot Blocking works please visit [Nginx Ultimate Bad Bot Blocker](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker)

#### Logging Options

| Parameter                    | Description                               | Default           |
| ---------------------------- | ----------------------------------------- | ----------------- |
| `NGINX_LOG_ACCESS_FILE`      | Nginx websites access logs                | `access.log`      |
| `NGINX_LOG_ACCESS_LOCATION`  | Location inside container for saving logs | `/www/logs/nginx` |
| `NGINX_LOG_ACCESS_FORMAT`    | Log Format `standard` or `json`           | `standard`        |
| `NGINX_LOG_BLOCKED_FILE`     | If exploit protection `TRUE`              | `access.log`      |
| `NGINX_LOG_BLOCKED_LOCATION` | Location inside container for saving logs | `/www/logs/nginx` |
| `NGINX_LOG_BLOCKED_FORMAT`   | Log Format `standard` or `json`           | `standard`        |
| `NGINX_LOG_ERROR_FILE`       | Nginx server and websites error log name  | `error.log`       |
| `NGINX_LOG_ERROR_LOCATION`   | Location inside container for saving logs | `/www/logs/nginx` |
| `NGINX_LOG_LEVEL_ERROR`      | How much verbosity to use with error logs | `warn`            |

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

| Parameter                                | Description                                                                                                      | Default     |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------- |
| `NGINX_ENABLE_APPLICATION_CONFIGURATION` | Don't automatically setup /etc/nginx/sites.available files - Useful for volume mapping/overriding                | `TRUE`      |
| `NGINX_ENABLE_CREATE_SAMPLE_HTML`        | If no index.html found - create a sample one to prove container works                                            | `TRUE`      |
| `NGINX_ENABLE_SITE_OPTIMIZATIONS`        | Deny access to some files and URLs, send caching tags                                                            | `TRUE`      |
| `NGINX_INCLUDE_CONFIGURATION`            | Include configuration in your website application file. eg `/www/website/nginx.conf`                             |             |
| `NGINX_RELOAD_ON_CONFIG_CHANGE`          | Automatically reload nginx on configuration file change                                                          | `FALSE`     |
| `NGINX_LISTEN_PORT`                      | Nginx listening port                                                                                             | `80`        |
| `NGINX_POST_INIT_SCRIPT`                 | If you wish to run a bash script before the nginx process runs enter the path here, seperate multiple by commas. |             |
| `NGINX_WEBROOT`                          | Where to serve content from inside the container                                                                 | `/www/html` |
| `NGINX_WEBROOT_SUFFIX`                   | Append a suffix onto the nginx configuration to serve files from a subfolder e.g. `/public`                      |             |

#### Functionality Options

| Parameter                       | Description                                                                           | Default    |
| ------------------------------- | ------------------------------------------------------------------------------------- | ---------- |
| `NGINX_FORCE_RESET_PERMISSIONS` | Force setting Nginx files ownership to web server user                                | `TRUE`     |
| `NGINX_MODE`                    | Set to `NORMAL`, `MAINTENANCE` , `PROXY`, `REDIRECT`                                  | `NORMAL`   |
| `NGINX_REDIRECT_URL`            | If `REDIRECT` set enter full url to forward all traffic to eg `https://example.com`   |            |
| `NGINX_PROXY_URL`               | If `REDIRECT` set enter full url to proxy all traffic to eg `https://example.com:443` |            |
| `NGINX_SITE_ENABLED`            | What sites to enable in `/etc/nginx/sites.available` Don't use `.conf` suffix         | `ALL`      |
| `NGINX_USER`                    | What user to run nginx as inside container                                            | `nginx`    |
| `NGINX_GROUP`                   | What group to run nginx as inside container                                           | `www-data` |

If set to `MAINTNENANCE` a single page will show visitors that the server is being worked on.

### Maintenance Options
| Parameter                        | Description                                                                                                   | Default                     |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------- | --------------------------- |
| `NGINX_MAINTENANCE_TYPE`         | Serve `local` file or `redirect` or `proxy` to a URL                                                          | `local`                     |
| `NGINX_MAINTENANCE_PATH`         | (local) Path where the maintenance page resides                                                               | `/assets/nginx/maintenance` |
| `NGINX_MAINTENANCE_FILE`         | (local) File to load while in maintenance mode                                                                | `index.html`                |
| `NGINX_MAINTENANCE_REMOTE_URL`   | (local) If you wish to download an html file from a remote location to overwrite the above enter the URL here |                             |
| `NGINX_MAINTENANCE_PROXY_URL`    | What url eg `https://example.com` to transparently proxy for the user when they visit the site                | `http://maintenance`        |
| `NGINX_MAINTENANCE_REDIRECT_URL` | What url eg `https://example.com` to redirect in a uers browser when they visit the site                      |                             |

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
| `NGINX_ENABLE_UPSTREAM_KEEPALIVE`        | Reuse connections when using upstream (LLNG Auth, FastCGI etc)                          | `TRUE`   |
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
| `NGINX_ENABLE_PROXY_BUFFERING`           | Enable Proxy Buffering                                                                  | `TRUE`   |
| `NGINX_PROXY_BUFFERS`                    | Proxy Buffers                                                                           | `4 256k` |
| `NGINX_PROXY_BUFFER_SIZE`                | Proxy Buffer Size                                                                       | `128k`   |
| `NGINX_PROXY_BUSY_BUFFERS_SIZE`          | Proxy Busy Buffers Size                                                                 | `256k`   |
| `NGINX_CLIENT_BODY_BUFFER_SIZE`          | Client Buffer size                                                                      | `16k`    |
| `NGINX_UPSTREAM_KEEPALIVE`               | Keepalive connections to utilize for upstream                                           | `32`     |
| `NGINX_FASTCGI_BUFFERS`                  | Amount of FastCGI Buffers                                                               | `16 16k` |
| `NGINX_FASTCGI_BUFFER_SIZE`              | FastCGI Buffer Size                                                                     | `32k`    |
| `NGINX_SERVER_NAMES_HASH_BUCKET_SIZE`    | Server names hash size (`256`` if `NGINX_ENABLE_BLOCK_BOTS=TRUE`)                       | `32`     |

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- [Sponsor me](https://tiredofit.ca/sponsor) for personalized support
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- [Sponsor me](https://tiredofit.ca/sponsor) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- [Sponsor me](https://tiredofit.ca/sponsor) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.
## References

* https://nginx.org/
