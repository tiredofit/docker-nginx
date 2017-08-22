# hub.docker.com/tiredofit/nginx

# Introduction

This will build a container for [Nginx](https://www.nginx.org) 

*    Tracks Mainline release channel
*    Includes Zabbix Monitoring (nginx status) on port 73
*    Logrotate Included to roll over log files at 23:59, compress and retain for 7 days
*    Compile Options:
*    --with-threads
        --with-http_ssl_module 
        --with-http_realip_module 
        --with-http_addition_module 
        --with-http_sub_module 
        --with-http_dav_module 
        --with-http_flv_module 
        --with-http_mp4_module 
        --with-http_gunzip_module 
        --with-http_gzip_static_module 
        --with-http_random_index_module 
        --with-http_secure_link_module 
        --with-http_stub_status_module 
        --with-http_auth_request_module 
        --with-http_xslt_module=dynamic 
        --with-http_image_filter_module=dynamic 
        --with-http_geoip_module=dynamic 
        --with-http_perl_module=dynamic 
        --with-threads 
        --with-stream 
        --with-stream_ssl_module 
        --with-stream_ssl_preread_module 
        --with-stream_realip_module 
        --with-stream_geoip_module=dynamic 
        --with-http_slice_module 
        --with-mail 
        --with-mail_ssl_module 
        --with-compat 
        --with-file-aio 
        --with-http_v2_module 
        
This Container uses [tiredofit:alpine:3.4](https://hub.docker.com/r/tiredofit/alpine) as a base.


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy] [https://github.com/tiredofit]

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

None


# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/tiredofit/nginx) and is the recommended method of installation.


```bash
docker pull hub.docker.com/tiredofit/nginx
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

Below is the complete list of available options that can be used to customize your installation.


| Parameter        | Description                            |
|------------------|----------------------------------------|
|`UPLOAD_MAX_SIZE` | Maximum Upload Size for Nginx (e.g 2G) |

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80`      | HTTP        |
| `443`     | HTTPS       |


# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. nginx) bash
```

# References

* https://nginx.org/




