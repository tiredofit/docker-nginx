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
