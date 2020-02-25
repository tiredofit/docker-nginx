# hub.docker.com/r/tiredofit/nginx

[![Build Status](https://img.shields.io/docker/build/tiredofit/nginx.svg)](https://hub.docker.com/r/tiredofit/nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/nginx.svg)](https://hub.docker.com/r/tiredofit/nginx)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/nginx.svg)](https://hub.docker.com/r/tiredofit/nginx)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/nginx.svg)](https://microbadger.com/images/tiredofit/nginx)

# Introduction

This will build a container for [Nginx](https://www.nginx.org) 

*    Tracks Mainline release channel
*    Many options configurable including compression, performance
*    Includes Zabbix Monitoring (nginx status) on port 73
*    Logrotate Included to roll over log files at 23:59, compress and retain for 7 days
*    Ability to Password Protect (Basic), LDAP Authenticate or use LemonLDAP:NG Handler
        
This Container uses [tiredofit/alpine:3.11](https://hub.docker.com/r/tiredofit/alpine) as a base.

[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

This image assumes that you are using a reverse proxy such as 
[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy 
Companion @ 
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) 
in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.

# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/nginx) and is the recommended method of installation.

```bash
docker pull tiredofit/nginx
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary

# Configuration

### Data-Volumes

The container starts up and reads from `/etc/nginx/nginx.conf` for some basic configuration and to listen on port 73 internally for Nginx Status responses. `/etc/nginx/conf.d` contains a sample configuration file that can be used to customize a nginx server block.

The following directories are used for configuration and can be mapped for persistent storage.

| Directory    | Description                                                 |
|--------------|-------------------------------------------------------------|
|  `/www/html` | Drop your Datafiles in this Directory to be served by Nginx |
|  `/www/logs` | Logfiles for Nginx error and Access                         |
      

### Environment Variables


Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

*Authentication Options*

You can choose to request visitors be authenticated before accessing your site. Options are below.

| Parameter | Description |
|-----------|-------------|
| `NGINX_AUTHENTICATION_TYPE` | Protect the site with `BASIC`, `LDAP`, `LLNG` - Default `NONE` |
| `NGINX_AUTHENTICATION_TITLE` |  Challenge response when visiting protected site - Default `Please login` |
| `NGINX_AUTHENTICATION_BASIC_USER1` | If `BASIC` chosen enter this for the username to protect site - Default `admin` |
| `NGINX_AUTHENTICATION_BASIC_PASS1` | If `BASIC` chosen enter this for the password to protect site - Default `password` |
| `NGINX_AUTHENTICATION_BASIC_USER2` | As above, increment for more users |
| `NGINX_AUTHENTICATION_BASIC_PASS2` | As above, increment for more users |
| `NGINX_AUTHENTICATION_LDAP_HOST` | Hostname and port number of LDAP Server - ie `ldap://ldapserver:389` |
| `NGINX_AUTHENTICATION_LDAP_BIND_DN` | User to Bind to LDAP - ie  `cn=admin,dc=orgname,dc=org` |
| `NGINX_AUTHENTICATION_LDAP_BIND_PW` | Password for Above Bind User - ie  `password` |
| `NGINX_AUTHENTICATION_LDAP_BASE_DN` | Base Distringuished Name - eg `dc=hostname,dc=com` |
| `NGINX_AUTHENTICATION_LDAP_ATTRIBUTE` | Unique Identifier Attrbiute -ie  `uid` |
| `NGINX_AUTHENTICATION_LDAP_SCOPE` |LDAP Scope for searching - ie `sub` |
| `NGINX_AUTHENTICATION_LDAP_FILTER` | Define what object that is searched for (ie  `objectClass=person`) |
| `NGINX_AUTHENTICATION_LDAP_GROUP_ATTRIBUTE` | If searching inside of a group what is the Group Attribute - ie `uniquemember` |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_HOST` | If `LLNG` chosen use hostname of handler - Default `llng-handler` |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_PORT` | If `LLNG` chosen use this port for handler - Default `2884` |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1` | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2` | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below |

When working with `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2` you will need to omit any `$` chracters from your string. It will be added in upon container startup. Example:
`NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1=HTTP_AUTH_USER,uid,upstream_http_uid` will get converted into `HTTP_AUTH_USER,$uid,$upstream_http_uid` and get placed in the appropriate areas in the configuration.


*Logging Options*

| Parameter | Description |
|-----------|-------------|
| `NGINX_LOG_ACCESS_FILE` | Nginx websites access logs - Default `access.log` |
| `NGINX_LOG_ACCESS_LOCATION` | Location inside container for saving logs - Default `/www/logs/nginx` |
| `NGINX_LOG_ERROR_FILE` | Nginx server and websites error log name - Default `error.log` |
| `NGINX_LOG_ERROR_LOCATION` | Location inside container for saving logs - Default `/www/logs/nginx` |
| `NGINX_LOG_LEVEL_ERROR` | How much verbosity to use with error logs - Default `warn` |

*Compression Options*

Presently you can compress your served content with gzip and brotli. More compression options to come in future..

| Parameter | Description |
|-----------|-------------|
| `NGINX_ENABLE_COMPRESSION_BROTLI` | Enable Brotli Compression - Default `TRUE` |
| `NGINX_COMPRESSION_BROTLI_LEVEL` | Compression Level for Brotli - Default `6` |
| `NGINX_COMPRESSION_BROTLI_MIN_LENGTH` | Minimum length of content before compressing - Default `20` |
| `NGINX_COMPRESSION_BROTLI_TYPES` | What filetypes to compress - Default `text/plain text/css text/xml text/javascript application/x-javascript application/json application/xml` |
| `NGINX_COMPRESSION_BROTLI_WINDOW` |  - Default `512k` |
| `NGINX_ENABLE_COMPRESSION_GZIP` | Enable GZIP Compression - Default `TRUE` |
| `NGINX_COMPRESSION_GZIP_BUFFERS` |  - Default `16 8k` |
| `NGINX_COMPRESSION_GZIP_DISABLE` | Don't compress for these user agents - Default `MSIE [1-6].(?!.*SV1)` |
| `NGINX_COMPRESSION_GZIP_HTTP_VERSION` |  - Default `1.1` |
| `NGINX_COMPRESSION_GZIP_LEVEL` | Compression Level - Default `6` |
| `NGINX_COMPRESSION_GZIP_MIN_LENGTH` | Minimum length of content before compressing - Default `10240` |
| `NGINX_COMPRESSION_GZIP_PROXIED` |  - Default `expired no-cache no-store private auth` |
| `NGINX_COMPRESSION_GZIP_TYPES` | Types of content to compress - Default `text/plain text/css text/xml text/javascript application/x-javascript application/json application/xml` |
| `NGINX_COMPRESSION_GZIP_VARY` |  - Default `TRUE` |

*DDoS Options*

| Parameter | Description |
|-----------|-------------|
| `NGINX_ENABLE_DDOS_PROTECTION` | Enable simple DDoS Protection - Default `FALSE` | 
| `NGINX_DDOS_CONNECTIONS_PER_IP` | Limit amount of connections per IP - Default `10m` | 
| `NGINX_DDOS_REQUESTS_PER_IP` | Limit amount of requests per IP - Default `5r/s` | 

*Reverse Proxy Options*

| Parameter | Description |
|-----------|-------------|
| `NGINX_ENABLE_FASTCGI_HTTPS` | Set fastcgi_param HTTPS 'on' - Default `FALSE` |
| `NGINX_ENABLE_REVERSE_PROXY` | Helpers for when behind a reverse proxy - Default `TRUE` | 
| `NGINX_REAL_IP_HEADER` | What is the header passed containing the visitors IP - Default `X-Forwarded-For` | 
| `NGINX_SET_REAL_IP_FROM` | Set the network of your Docker Network if having IP lookup issues - Default `172.16.0.0/12` | 

*Container Options*

| Parameter | Description |
|-----------|-------------|
| `NGINX_ENABLE_APPLICATION_CONFIGURATION` | Don't automatically setup /etc/nginx/conf.d files - Useful for volume mapping/overriding - Default `TRUE` | 
| `NGINX_ENABLE_CREATE_SAMPLE_HTML` | If no index.html found - create a sample one to prove container works - Default `TRUE` | 
| `NGINX_ENABLE_SITE_OPTIMIZATIONS` | Deny access to some files and URLs, send caching tags - Default `TRUE` |
| `NGINX_INCLUDE_CONFIGURATION` | Include configuration in your website application file. e.g. `/www/website/nginx.conf`
| `NGINX_LISTEN_PORT` |  Nginx listening port - Default `80` | 
| `NGINX_WEBROOT` | Where to serve content from inside the container - Default `/www/html` | 

*Functionality Options*

| Parameter | Description |
|-----------|-------------|
| `FORCE_RESET_PERMISSIONS` | Force setting Nginx files ownership to web server user - Default `TRUE` | 
| `NGINX_MODE` | Set to `NORMAL`, `MAINTENANCE` , `REDIRECT` - Default `NORMAL` |
| `NGINX_REDIRECT_URL` | If `REDIRECT` set enter full url to forward all traffic to e.g. `https://example.com` |
| `NGINX_USER` | What user to run nginx as inside container - Default `nginx` |
| `NGINX_GROUP` | What group to run nginx as inside container - Default `www-data` |

If set to `MAINTNENANCE` a single page will show visitors that the server is being worked on.

You can also enter into the container and type `maintenance ARG`, where ARG is either `ON`,`OFF`, or `SLEEP (seconds)` which will temporarily place the site in maintenance mode and then restore it back to normal after time has passed. 

*Performance Options*

| Parameter | Description |
|-----------|-------------|
| `NGINX_CLIENT_BODY_TIMEOUT` | Request timed out - Default `60` | 
| `NGINX_ENABLE_EPOLL` | Optmized to serve many clients with each thread, essential for linux - Default `TRUE` | 
| `NGINX_ENABLE_MULTI_ACCEPT` | Accept as many connections as possible, may flood worker connections if set too low - Default `TRUE` | 
| `NGINX_ENABLE_RESET_TIMEDOUT_CONNECTION` | Allow the server to close connection on non responding client, this will free up memory - Default `TRUE` | 
| `NGINX_ENABLE_SENDFILE` | Copies data between one FD and other from within the kernel - Default `TRUE` | 
| `NGINX_ENABLE_SERVER_TOKENS` | Show Nginx version on responses - Default `FALSE` | 
| `NGINX_ENABLE_TCPNODELAY` | Don't buffer data sent, good for small data bursts in real time - Default `TRUE` | 
| `NGINX_ENABLE_TCPNOPUSH` | Send headers in one peace, its better then sending them one by one - Default `TRUE` | 
| `NGINX_KEEPALIVE_REQUESTS` | Number of requests client can make over keep-alive - Default `100000` | 
| `NGINX_KEEPALIVE_TIMEOUT` | Server will close connection after this time - Default `75` | 
| `NGINX_SEND_TIMEOUT` | If client stop responding, free up memory - Default `60` | 
| `NGINX_UPLOAD_MAX_SIZE` | Maximum Upload Size - Default `2G` | 
| `NGINX_WORKER_CONNECTIONS` | Determines how much clients will be served per worker - Default `1024` | 
| `NGINX_WORKER_PROCESSES` | How many processes to spawn - Default `auto` | 
| `NGINX_WORKER_RLIMIT_NOFILE` | Number of file descriptors used for nginx - Default `100000` | 
| `NGINX_ENABLE_OPEN_FILE_CACHE` | Cache informations about FDs, frequently accessed files - Default `TRUE` | 
| `NGINX_ENABLE_OPEN_FILE_CACHE_ERRORS` | Cache errors like 404 - Default `TRUE` | 
| `NGINX_OPEN_FILE_CACHE_INACTIVE` | Stop caching after inactive - Default `5m` | 
| `NGINX_OPEN_FILE_CACHE_MAX` | Maximum files to cache - Default `200000` | 
| `NGINX_OPEN_FILE_CACHE_MIN_USES` | Minimum uses of file before cashing - Default `2` | 
| `NGINX_OPEN_FILE_CACHE_VALID` | Cache a file if has been accessed within this window - Default `2m` | 
| `NGINX_FASTCGI_BUFFERS` | Amount of FastCGI Buffers - Default `16 16k` |
| `NGINX_FASTCGI_BUFFER_SIZE` | FastCGI Buffer Size - Default `32k`|

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80`      | HTTP        |

# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is ie  nginx) bash
```

# References

* https://nginx.org/
