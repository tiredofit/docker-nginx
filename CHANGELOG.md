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
