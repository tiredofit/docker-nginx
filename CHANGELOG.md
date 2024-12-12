## 6.5.10 2024-12-12 <dave at tiredofit dot ca>

   ### Added
      - Pin to tiredofit/alpine:7.10.27


## 6.5.9 2024-12-12 <dave at tiredofit dot ca>

   ### Added
      - Pin to tiredofit/alpine:7.10.26


## 6.5.8 2024-12-09 <dave at tiredofit dot ca>

   ### Added
      - Pin to tiredofit/alpine:7.10.25


## 6.5.7 2024-12-07 <dave at tiredofit dot ca>

   ### Added
      - Pin to tiredofit/alpine:7.10.24
      - Add Alpine 3.21 builds


## 6.5.6 2024-11-26 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.27.3


## 6.5.5 2024-11-07 <dave at tiredofit dot ca>

   ### Added
      - Pin to tiredofit/alpine:7.10.19


## 6.5.4 2024-10-22 <dave at tiredofit dot ca>

   ### Added
      - Pin to tiredofit/alpine:7.10.17


## 6.5.3 2024-10-02 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.27.2
      - Pin to tiredofit/alpine:7.10.15


## 6.5.2 2024-09-25 <dave at tiredofit dot ca>

   ### Changed
      - Pin to base image 7.10.14


## 6.5.1 2024-09-24 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.27.1
      - Nginx Auth LDAP pinned to 241200eac8e4acae74d353291bd27f79e5ca3dc4
      - Nginx Brotly pinned to 6e975bcb015f62e1f303054897783355e2a877dc
      - Nginx Cookie Flag pinned to c4ff449318474fbbb4ba5f40cb67ccd54dc595d4
      - Nginx More Headers pinned to f8f80997f19a41dc4181987544b9f3570cc3d6da


## 6.5.0 2024-08-07 <terryzwt>

   ### Added
      - Add NGINX_RESOLVER environment variable to use a specific resolver when looking up DNS hostnames in proxy mode

   ### Changed
      - Fix nginx reload configuration service to look for proper config folders


## 6.4.15 2024-05-29 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.27.0


## 6.4.14 2024-05-29 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.26.1


## 6.4.13 2024-05-23 <dave at tiredofit dot ca>

   ### Changed
      - Force Nginx version to be output when monitoring active to solve Zabbix version issues


## 6.4.12 2024-04-24 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.26.0


## 6.4.11 2024-04-16 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.25.5


## 6.4.10 2024-02-14 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.25.4


## 6.4.9 2024-01-23 <dave at tiredofit dot ca>

   ### Changed
      - Restore Alpine Edge builds


## 6.4.8 2024-01-23 <dave at tiredofit dot ca>

   ### Added
      - Add NGINX_SERVER_NAMES_HASH_BUCKET_SIZE environment variable


## 6.4.7 2023-12-08 <dave at tiredofit dot ca>

   ### Added
      - Add alpine 3.19 support


## 6.4.6 2023-11-10 <dave at tiredofit dot ca>

   ### Changed
      - Patchup to 6.4.5


## 6.4.5 2023-11-09 <dave at tiredofit dot ca>

   ### Added
      - Add NGINX_WEBROOT_SUFFIX to allow adding custom directories for the root command in nginx


## 6.4.4 2023-10-24 <dave at tiredofit dot ca>

   ### Changed
      - Restore Edge builds


## 6.4.3 2023-10-24 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.25.3


## 6.4.2 2023-09-21 <dave at tiredofit dot ca>

   ### Added
      - Turn on JIT for regex

   ### Changed
      - Allow secrets to work with basic authentication


## 6.4.1 2023-08-18 <fermion2020@github>

   ### Changed
      - Fix for 6.4.0


## 6.4.0 2023-08-16 <dave at tiredofit dot ca>

   ### Added
      - Introduce NGINX_ENABLE_PROXY_BUFFERING and associated environment variables for better upstream proxy support


## 6.3.5 2023-08-15 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.25.2


## 6.3.4 2023-07-15 <dave at tiredofit dot ca>

   ### Changed
      - Add LLNG Site configuration w/PHP-FPM statement


## 6.3.3 2023-06-13 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.25.1


## 6.3.2 2023-05-23 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.25.0


## 6.3.1 2023-05-09 <dave at tiredofit dot ca>

   ### Added
      - Drop Alpine 3.17 builds and Introduce Alpine 3.18 build


## 6.3.0 2023-04-26 <dave at tiredofit dot ca>

   ### Added
      - Add support for _FILE environment variables


## 6.2.22 2023-04-11 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.24.0


## 6.2.21 2023-03-28 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.23.4


## 6.2.20 2023-03-26 <dave at tiredofit dot ca>

   ### Changed
      - Stop building from tiredofit/alpine:develop


## 6.2.19 2023-03-25 <dave at tiredofit dot ca>

   ### Added
      - Add libldap to alpine Dockerfile


## 6.2.18 2023-03-23 <dave at tiredofit dot ca>

   ### Changed
      - Fix for NGINX_ENABLE_SERVER_TOKENS
      - Fix for NGINX_FORCE_RESET_PERMISSIONS


## 6.2.17 2023-02-17 <radarsymphony@github>

   ### Changed
      - Fix for LLNG_AUTHENTICATION_TYPE not sending correct header variables


## 6.2.16 2023-01-24 <dave at tiredofit dot ca>

   ### Changed
      - Update "proxy" redirect template to support WS/WSS
      - Fix for 'NGINX_ENABLE_FASTCGI_HTTPS' not working (credit joergmschulz@github)


## 6.2.15 2022-12-24 <dave at tiredofit dot ca>

   ### Changed
      - Tweak site_optimization configuration file to serve "text/plain" and allow .well-known responses


## 6.2.14 2022-12-20 <dave at tiredofit dot ca>

   ### Changed
      - Fix NGINX_PROXY_URL and NGINX_MAINTENANCE_PROXY_URL if host is https


## 6.2.13 2022-12-20 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.23.3

   ### Changed
      - Fix issue with NGINX_MAINTENANCE_PROXY_URL
      - Fix issue with NGINX_MAINTENANCE_REDIRECT_URL


## 6.2.12 2022-12-05 <dave at tiredofit dot ca>

   ### Changed
      - Big warning when using Basic Authentication
      - Indent some nginx configuration


## 6.2.11 2022-11-29 <dave at tiredofit dot ca>

   ### Changed
      - Bugfix


## 6.2.10 2022-11-29 <dave at tiredofit dot ca>

   ### Changed
      - Rework HTTPs switch in fastcgi_params


## 6.2.9 2022-11-23 <dave at tiredofit dot ca>

   ### Added
      - Introduce Alpine 3.17 support


## 6.2.8 2022-11-21 <dave at tiredofit dot ca>

   ### Changed
      - Fix for LDAP authentication not configuring (credit radarsymphony@github)


## 6.2.7 2022-11-15 <dave at tiredofit dot ca>

   ### Changed
      - Fix spelling mistake with update_template for NGINX_MODE=REDIRECT


## 6.2.6 2022-10-19 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.23.2


## 6.2.5 2022-10-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix path for update_template


## 6.2.4 2022-10-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix legacy Webroot configuration check


## 6.2.3 2022-10-04 <dave at tiredofit dot ca>

   ### Changed
      - Fix an issue with Brotli module not pulling submodules


## 6.2.2 2022-10-01 <dave at tiredofit dot ca>

   ### Changed
      - Silence legacy check for webroot/listen_port if there are no files in directory


## 6.2.1 2022-10-01 <dave at tiredofit dot ca>

   ### Changed
      - Fix not including backslash when configuring default site


## 6.2.0 2022-10-01 <dave at tiredofit dot ca>

   ### Added
      - Introduce NGINX_MAINTENANCE_MODE variable to redirect, or proxy an external site when in maintenance mode

   ### Changed
      - Switched configuration from hacky seds to use 'update_template' function
      - Alerted users of legacy template usage, request to have them move from <TAG> to {{TAG}} format
      - Fix issue with GZIP compression not working


## 6.1.11 2022-08-18 <dave at tiredofit dot ca>

   ### Changed
      - Fix for default site getting two sets of authentication directives


## 6.1.10 2022-08-17 <dave at tiredofit dot ca>

   ### Changed
      - Use exec calls when launching process


## 6.1.9 2022-07-31 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.23.1


## 6.1.8 2022-07-29 <dave at tiredofit dot ca>

   ### Changed
      - Fix for broken maintenance script


## 6.1.7 2022-07-18 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Proxy mode using LLNG Authentication


## 6.1.6 2022-07-07 <dave at tiredofit dot ca>

   ### Changed
      - Cleanup nginx_site_enable and nginx_site_disable functions


## 6.1.5 2022-07-07 <dave at tiredofit dot ca>

   ### Changed
      - Fix sed statement breaking NGINX_MODE=REDIRECT


## 6.1.4 2022-07-06 <dave at tiredofit dot ca>

   ### Changed
      - Debian: Load proper OS


## 6.1.3 2022-07-06 <dave at tiredofit dot ca>

   ### Changed
      - Fix when NGINX_ENABLE_BLOCK_BOTS enabled looking for missing file


## 6.1.2 2022-07-04 <dave at tiredofit dot ca>

   ### Changed
      - Add nullglob checking for *.conf files


## 6.1.1 2022-07-04 <dave at tiredofit dot ca>

   ### Changed
      - Add ARGs to support easier version switching in Dockerfile


## 6.1.0 2022-06-27 <dave at tiredofit dot ca>

   ### Added
      - Add ability to put authentication in front of NGINX_MODE=PROXY


## 6.0.4 2022-06-27 <dave at tiredofit dot ca>

   ### Changed
      - Change from sites.available to sites.enabled


## 6.0.3 2022-06-27 <dave at tiredofit dot ca>

   ### Changed
      - Fixes for environment value buster NGINX_SITE_ENABLED


## 6.0.2 2022-06-26 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Proxy mode hosting multiple configurations


## 6.0.1 2022-06-26 <dave at tiredofit dot ca>

   ### Added
      - Add null for value of NGINX_SITE_ENABLED to bust parent image declarations
      - Cleanup with site-enabled and post-init function


## 6.0.0 2022-06-23 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.23.0
      - Rewrote image and seperated into functions for discrete configuration when there is multiple websites or configurations available
      - Nginx Maintenance mode path has been moved, yet is customizable and volumes can be mapped to the folder
      - Alternatively, NGINX_MAINTENANCE_REMOTE_URL also works to pull an html file from the web/intranet and take the place of the baked in maintenance page
      - /etc/nginx/conf.d is being retired. Now drop your custom site configuration into /etc/nginx/sites.available. Also set NGINX_SITE_ENABLED=(config file, without the .conf extension) to have the automation work for things like authentication, blocking bots. You can seperate it via commas to have the image work on multiple configuration files. If the system detects /etc/nginx/conf.d it will move them automatically yet give a warning into /etc/nginx/sites.available and make them ALL enabled at the end of the container initialization, this may not be what you want, but is an attempt to add some backwards compatibility.
      - /etc/nginx/nginx.conf.d has been renamed to /etc/nginx/snippets, however this shouldn't affect anyone unless they have modified the image extensively.
      - Last version where we are building 3.14, 3.13, 3.11, 3.10, 3.8 and 3.6 Alpine variants as there is no point for PHP-FPM


## 5.17.6 2022-05-24 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.22.0


## 5.17.5 2022-05-24 <dave at tiredofit dot ca>

   ### Added
      - Introduce Alpine 3.16 support


## 5.17.4 2022-03-11 <dave at tiredofit dot ca>

   ### Changed
      - Sanity checks to be able to survive "warm" container restarts


## 5.17.3 2022-03-04 <dave at tiredofit dot ca>

   ### Changed
      - Move upstream blocks to dedicated section to nginx.conf as opposed to default.conf


## 5.17.2 2022-03-02 <dave at tiredofit dot ca>

   ### Added
      - Add NGINX_POST_INIT_COMMAND to execute before nginx process starts


## 5.17.1 2022-03-02 <dave at tiredofit dot ca>

   ### Added
      - Add NGINX_POST_INIT_SCRIPT environment variable to execute a custom script before starting process


## 5.17.0 2022-02-23 <dave at tiredofit dot ca>

   ### Added
      - Implement multiple upstream hosts for LLNG Authentication
      - Implement Keepalive for upstreams for better performance

   ### Changed
      - Cleanup code, properly quote variables, and rename filenames for consistency


## 5.16.4 2022-02-18 <dave at tiredofit dot ca>

   ### Changed
      - Stop notifying us of disabling a feature all the time


## 5.16.3 2022-02-09 <dave at tiredofit dot ca>

   ### Changed
      - Rework to support new base image


## 5.16.2 2022-02-09 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.6


## 5.16.1 2022-01-04 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.5


## 5.16.0 2021-12-06 <dave at tiredofit dot ca>

   ### Changed
      - Change the way that Zabbix monitoring is performed - switch to a more modern template


## 5.15.3 2021-11-30 <dave at tiredofit dot ca>

   ### Changed
      - Fix for building with GCC 11.2


## 5.15.2 2021-11-02 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.4


## 5.15.1 2021-09-25 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.3


## 5.15.0 2021-09-24 <dave at tiredofit dot ca>

   ### Changed
      - Pin nginx user to '80' from a randomly generated UID during build process


## 5.14.7 2021-09-06 <dave at tiredofit dot ca>

   ### Changed
      - For for NGINX_AUTHENTICATION_TYPE


## 5.14.6 2021-09-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Error Logs
      - Fix for Fluent-bit Log Parsers


## 5.14.5 2021-09-05 <dave at tiredofit dot ca>

   ### Changed
      - Blocked logs configuration fix


## 5.14.4 2021-09-04 <dave at tiredofit dot ca>

   ### Changed
      - Customizable Blocked file and further parsing of logrotation files


## 5.14.3 2021-09-04 <dave at tiredofit dot ca>

   ### Changed
      - Change the way that logrotat files are utilized


## 5.14.2 2021-09-03 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.2


## 5.14.1 2021-08-30 <dave at tiredofit dot ca>

   ### Changed
      - Add two new logformats to support LLNG Authentication


## 5.14.0 2021-08-29 <dave at tiredofit dot ca>

   ### Added
      - Option to output json for access log

   ### Changed
      - Reworked fluent bit log parsing regex
      - Changed output format of access logs
      - Split logging into its own configuration file
      - Reworked "blocked" log_format
      - Renamed "Zabbix" functionality to "Monitoring"


## 5.13.7 2021-08-25 <dave at tiredofit dot ca>

   ### Added
      - Add parsers for fluent-bit log shipping


## 5.13.6 2021-08-04 <dave at tiredofit dot ca>

   ### Added
      - Change the way logrotate operates


## 5.13.5 2021-07-12 <dave at tiredofit dot ca>

   ### Changed
      - Skip LLNG authentication routines if it detects downstream php-fpm image being used


## 5.13.4 2021-07-11 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.1


## 5.13.3 2021-07-05 <dave at tiredofit dot ca>

   ### Changed
      - Support upstream image changes


## 5.13.2 2021-06-17 <dave at tiredofit dot ca>

   ### Changed
      - Fix issues with Alpine 3.14 and Edge builds


## 5.13.1 2021-05-25 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.21.0


## 5.13.0 2021-05-08 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.20.0


## 5.12.10 2021-04-20 <dave at tiredofit dot ca>

   ### Added
      - Update LemonLDAP:NG configuration to suppoprt CDA domains


## 5.12.9 2021-04-07 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.9


## 5.12.8 2021-03-11 <dave at tiredofit dot ca>

   ### Added
      - Update Brotli to 1.09
      - Nginx 1.19.8


## 5.12.7 2021-02-22 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.7


## 5.12.6 2021-01-15 <dave at tiredofit dot ca>

      - Switch main base to alpine 3.13

## 5.12.5 2021-01-03 <jesper at github>

   ### Fixed
      - LDAP Configuration was generating bad configuration files. Fix whitespace and Carriage Returns


## 5.12.4 2020-12-22 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.6


## 5.12.3 2020-11-30 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.5


## 5.12.2 2020-11-14 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.4


## 5.12.1 2020-10-26 <dave at tiredofit dot ca>

   ### Changed
      - Fix when NGINX_ENABLE_BLOCK_BOTS=FALSE throws errors


## 5.12.0 2020-10-25 <dave at tiredofit dot ca>

   ### Added
      - Add Nginx Ultimate Bad Bot Blocker to issue 444s to crawlers and bad referrers


## 5.11.7 2020-10-01 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.3


## 5.11.6 2020-09-07 <dave at tiredofit dot ca>

   ### Changed
      - Change to LLNG Authentication method to address CVE


## 5.11.5 2020-08-29 <dave at tiredofit dot ca>

   ### Added
      - Add ENABLE_NGINX variable


## 5.11.4 2020-08-18 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.2


## 5.11.3 2020-08-12 <dave at tiredofit dot ca>

   ### Added
      - Add NGINX_CLIENT_BODY_BUFFER_SIZE environment variable


## 5.11.2 2020-07-15 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.19.1

   ### Changed
      - Code cleanup as per bash shellcheck warnings


## 5.11.1 2020-06-11 <dave at tiredofit dot ca>

   ### Changed
      - Fix for logrotate if Access Logs and Error Logs are in same location


## 5.11.0 2020-06-09 <dave at tiredofit dot ca>

   ### Added
      - Update to support tiredofit/alpine 5.0.0 base image

## 5.10.1 2020-05-17 <dave at tiredofit dot ca>

   ### Changed
      - Remove Site Optimizations when using PROXY mode


## 5.10.0 2020-05-17 <dave at tiredofit dot ca>

   ### Added
      - Introduced Reverse Proxy Feature set by NGINX_MODE=PROXY and NGINX_PROXY_URL


## 5.9.4 2020-05-09 <dave at tiredofit dot ca>

   ### Changed
      - Remove faulty access log statement in site_optimization.conf


## 5.9.3 2020-04-22 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.18.0


## 5.9.2 2020-04-18 <dave at tiredofit dot ca>

   ### Added
      - Update to support tiredofit/alpine 4.5.1 release


## 5.9.1 2020-04-15 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.17.10


## 5.9.0 2020-03-09 <dave at tiredofit dot ca>

   ### Added
      - Add NGINX_RELOAD_ON_CONFIG_CHANGE environment variable to automatically reload nginx configuration if main configuration files are changed or the value of NGINX_INCLUDE_CONFIGURATION

   ### Changed
      - Fixed `NGINX_ENABLE_FASTCGI_HTTPS` that didn't do anything

## 5.8.3 2020-03-04 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.17.9


## 5.8.2 2020-02-25 <dave at tiredofit dot ca>

   ### Changed
      - Fix extra semicolon in default environment variable


## 5.8.1 2020-02-25 <dave at tiredofit dot ca>

   ### Changed
      - Spelling mistake for fastcgi_buffer_size


## 5.8.0 2020-02-25 <dave at tiredofit dot ca>

   ### Added
      - Add FastCGI Buffers and FastCGI Buffer Size environment variables


## 5.7.2 2020-01-22 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.17.8


## 5.7.1 2020-01-03 <dave at tiredofit dot ca>

   ### Changed
      - Cleanup LLNG Authentication routines


## 5.7.1 2020-01-02 <dave at tiredofit dot ca>

   ### Changed
      - Additional Changes to support new tiredofit/alpine base image


## 5.7.0 2019-12-31 <dave at tiredofit dot ca>

   ### Added
      - Split defaults to /assets/functions

   ### Changed
      - Change Warnings to Notices


## 5.6.1 2019-12-29 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.17.7


## 5.6.0 2019-12-29 <dave at tiredofit dot ca>

   ### Added
      - Refactored image to support new tiredofit/alpine base image
      - Added FORCE_RESET_PERMISSIONS env variable (credit juanluisbaptiste@github)


## 5.5.0 2019-12-20 <dave at tiredofit dot ca>

   ### Added
      - Alpine 3.11 Base Image


## 5.4.4 2019-12-16 <dave at tiredofit dot ca>

   ### Changed
      - Change Sed Command to properly escape slashes


## 5.4.3 2019-12-16 <dave at tiredofit dot ca>

   ### Added
      - Add Default Variable to pass for LLNG


## 5.4.2 2019-12-16 <dave at tiredofit dot ca>

   ### Changed
      - Tweaks to LLNG Authentication


## 5.4.1 2019-12-12 <dave at tiredofit dot ca>

   ### Changed
      - Fix Basic Authentication Passwords


## 5.4.0 2019-12-12 <dave at tiredofit dot ca>

   ### Added
      - Add default `NGINX_USER` and `NGINX_GROUP` variables


## 5.3.0 2019-12-09 <dave at tiredofit dot ca>

   ### Added
      - Add functionality to set fastcgi_param HTTPS 'on' or 'off'


## 5.2.0 2019-12-09 <dave at tiredofit dot ca>

   ### Added
      - Add `NGINX_INCLUDE_CONFIGURATION` to include additional .conf files from the filesystem for applications

## 5.1.0 2019-12-09 <dave at tiredofit dot ca>

   ### Added
      - Added NGINX_MODE environment variable to allow Redirection to remote URLs

   ### Changed
      - Moved around maintenance functionality
      - Minor cleanup to code


## 5.0.0 2019-12-04 <dave at tiredofit dot ca>

   ### Added
      - Nginx 1.17.6
      - Rewrote entire image
      - Added many new environment variables for customization
      - Enabled Brotli Compression
      - Enabled Gzip Compression
      - Broke out configuration into seperate files
      - Integrated tiredofit/nginx-ldap functionality
      - Cleaned up code
      - Tuned for performance

## 4.2.1 2019-11-18 <dave at tiredofit dot ca>

   ### Added
      - Update to Nginx 1.17.5


## 4.2 2019-06-30 <dave at tiredofit dot ca>

* Nginx 1.17.0
* Cleanup Build Process

## 4.1 2019-06-19 <dave at tiredofit dot ca>

* Change Alpine Base Image to 3.10

## 4.0.5 2019-04-28 <dave at tiredofit dot ca>

* Bump to Nginx 1.16.0

## 4.0.4 2019-03-26 <dave at tiredofit dot ca>

* Bump to Nginx 1.15.10

## 4.0.3 2019-02-08 <dave at tiredofit dot ca>

* Bump to Nginx 1.15.8

## 4.0.2 2018-12-10 <dave at tiredofit dot ca>

* Bump to Nginx 1.15.7

## 4.0.2 2018-10-23 <dave at tiredofit dot ca>

* Bump to Nginx 1.15.5

## 4.0.1 2018-09-24 <dave at tiredofit dot ca>

* Bump to Nginx 1.15.3

## 4.0 2018-04-28 <dave at tiredofit dot ca>

* Ability to protect service via basic authentication or using LemonLDAP:NG Handlers

## 3.8 2018-04-14 <dave at tiredofit dot ca>

* Bump Version, Clean Code

## 3.7 2018-04-02 <dave at tiredofit dot ca>

* Added MAINTENANCE environment variable to move system to maintenance mode. Also maintenance script (off/on/sleep 60) inside container.

## 2018-02-20 3.6 <dave at tiredofit dot ca>

* Fix startup Issues with Logfiles

## 2018-02-20 3.5 <dave at tiredofit dot ca>

* Add Reverse Proxy Detection

## 2018-01-29 3.4 <dave at tiredofit dot ca>

* Rebase

## 2018-01-29 3.3 <dave at tiredofit dot ca>

* Nginx 1.13.8
* Update Zabbix Scripts

## 2017-12-01 3.2 <dave at tiredofit dot ca>

* Update Base to Alpine 3.7
* Nginx 1.13.7

## 3.1 2017-09-27 <dave at tiredofit dot ca>

* Fix Build Issues
* Nginx 1.13.5

## 3.0 2017-08-27 <dave at tiredofit dot ca>

* Major Version Bump to support Base Image Changes

## 2.3 2017-07-13 <dave at tiredofit dot ca>

* Cleaned up Initialization Routes with cont-init.d

## 2.2 2017-07-03 <dave at tiredofit dot ca>

* Added Logrotate

## 2.1 2017-07-02 <dave at tiredofit dot ca>

* S6 Init Script Sanity Check

## 2.0 2017-06-23 <dave at tiredofit dot ca>

* New S6 Container Processes
* Implemented conf.d folder
* Changed Zabbix run process
* Moved Status Checks to Port 73

## 1.3 2017-05-20 <dave at tiredofit dot ca>

* Nginx 1.13.0
* Enabled Extra Modules to Match Upstream nginx image

## 1.2 2017-04-07 <dave at tiredofit dot ca>

* Rebase
* Nginx 1.1.13

## 1.1 2017-03-11 <dave at tiredofit dot ca>

* Move Data Directory to follow SelfDesign Paths
* Simplify nginx.conf

## 1.0 2017-02-20 <dave at tiredofit dot ca>

* Initial Release - Nginx Mainline w/Alpine 3.4
* Zabbix Status Monitoring Included
