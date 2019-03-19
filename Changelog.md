# Changelog


## 2019-03-18
### {{7.2,7.1,5.6}-10}, 7.3-2
#### Added
* `error_reporting = E_ALL` -#3 [debug]

### 7.3-2
#### Changed
* stable xdebug

## 2019-01-09
### 7.3-1
#### initial release, is now `latest` and `7`

### {{7.2,7.1,5.6}-9}
#### Changed
* base-image to version `{7.2,7.1,5.6}-fpm-alpine3.8

## 2018-06-11
### {7.2,7.1,5.6}-8
#### Added
* ability to clone via ssh from unknown hosts -- #2
* vufind- and cach-folders are made world-readable -- #1 [debug]

## 2018-06-04
### {7.2,7.1,5.6}-7, {7.2,7.1,5.6}-6
#### Fixed
* removed usage of internal npm-repository

## 2018-05-29
### {7.2,7.1,5.6}-5, {7.2,7.1,5.6}-4
#### Added
* vufind-folder and vufind-cache as external volumes
* composer-cache and npm-cache as external volumes -- [debug]

## 2018-05-29
### {7.2,7.1,5.6}-3, vufind1-5.3-3
#### Fixed
* chown www-data homedir -- [debug]
* removed message for setting uid and gid -- [debug]
* added first tests

## 2018-05-28
### {7.2,7.1,5.6}-2, vufind1-5.3-2
#### Added
* base image for all php-versions > 5.3 is now alpine v3.7

#### Broken
* www-data homedir is not chown'd

## 2018-04-24
### {7.2,7.1,5.6}-1, vufind1-5.3-1
#### initial release