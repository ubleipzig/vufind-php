# Changelog

## {7.2,7.1,5.6}-8
### Added
* ability to clone via ssh from unknown hosts -- #2
* vufind- and cach-folders are made world-readable -- #1 [debug]

## {7.2,7.1,5.6}-7, {7.2,7.1,5.6}-6
### Fixed
* removed usage of internal npm-repository

## {7.2,7.1,5.6}-5, {7.2,7.1,5.6}-4
### Added
* vufind-folder and vufind-cache as external volumes
* composer-cache and npm-cache as external volumes -- [debug]

## {7.2,7.1,5.6}-3, vufind1-5.3-3
### Fixed
* chown www-data homedir -- [debug]
* removed message for setting uid and gid -- [debug]
* added first tests

## {7.2,7.1,5.6}-2, vufind1-5.3-2
### Added
* base image for all php-versions > 5.3 is now alpine v3.7

### Broken
* www-data homedir is not chown'd

## {7.2,7.1,5.6}-1, vufind1-5.3-1
### initial release