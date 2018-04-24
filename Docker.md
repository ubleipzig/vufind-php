# vufind-php

*PHP* is the application server of [VuFind] and executes all progam logic. The Webserver passes through requests on dynamic content to the application server. The application server then processes these requests and responds with the dynamic content to the webserver. The webserver then passes the content to the user.

The image extends the fpm-variant of the [official PHP-Image] and all tags `5` and `7`. `latest` is also `5`, additionally there is always a `-debug` variant, see [debug](#debug).

I created a new *entrypoint* which makes shure that the [VuFind]-Sources are found in the folder defined by environment variable `VUFIND_APPLICATION_PATH`, by default `/usr/local/vufind`.
Also it creates the [VuFind] cache-folder, defined by environment variable `VUFIND_CACHE_DIR`, by default `/var/cache/vufind`.
At last it chowns all files within these folders to *www-data* to ensure *php* hase write-access to all VuFind-Sources.


## Supported Tags

* 7.2-*, 7.2, 7, latest ([7.2/Dockerfile])
* 7.1-*, 7.1 ([7.1/Dockerfile])
* 7.0-*, 7.0 ([7.0/Dockerfile])
* 5.6-*, 5.6, 5 ([5.6/Dockerfile])

## Usage of the Image

Usage makes sense only in connection with a VuFind-webserver, either [vufind-httpd] or [vufind-nginx]. These Services connect to *php* on port 9000, which is what this image is set up for.

You can configure the application server via environment-variables as follows:

* `VUFIND_CACHE_DIR=/var/cache/vufind`: specifies the cache folder, which is used to write the [VuFind]-cache. The folder will be created at container startup if it doesnt exist.
* `VUFIND_APPLICATION_PATH=/usr/local/vufind`: specifies the folder where the [VuFind]-sourcecode resides. The folder must exist at container startup. Container-start will fail, if the folder does not exist.
* `VUFIND_LOCAL_DIR=/usr/local/vufind/local`: specifies the folder with [VuFind]-configuration. The folder must exist at container startup.
* `VUFIND_LOCAL_MODULES=`: specifies additional modules to load in [VuFind]
* `VUFIND_ENV=production`: specifies the environment [VuFind] is executed. This influences [VuFind]s behaviour regarding Exceptions.

the following php-extensions are compiled in:

* mysqli
* pdo_pgsql
* pdo_mysql
* gd
* xsl
* mcrypt
* intl
* soap
* xdebug (nur `-debug`-Variante)

To Start the container do as follows:

```bash
$ docker run \
    -v /path/to/vufind:/usr/local/vufind \
    -v /path/to/cache:/var/cache/vufind \
    -e VUFIND_LOCAL_DIR=/usr/local/vufind/local/staging
    ubleipzig/vufind-php:5.6
```

### Debug

There exists a debug-variant of the image which additionally includes the php-extension *xdebug* configured for automatic start when a debug-session is initiated.

Furthermore all files and folders are created with UID/GID of the developer. The according UID and GID is taken from the bind-mounted [VuFind]-folder which most certainly is the developers [VuFind]-sourcecode in development environments. This gives the developer the ability to modify and delete files created by PHP.

Also the environment variables `VUFIND_ENV` and `NODE_ENV` are set to `development`, so that Exeptions are not suppressed.

### phing

The build-tool Phing is installed in the image. This adds the ability to execute [VuFind]s Phing-tasks, most notably *composer*. This tool installs [VuFind]s composer-module dependencies. Also more developertools come with resolving the dependencies and allow further Phing-tasks such as:

* phpcs
* php-cs-fixer
* phpunit
* phpdoc
* phpcpd
* phpmd
* pdepend
* phploc

Use *phing* to execute the default [VuFind]-tasks:

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      phing composer

_installs [FuFind]s composer-dependencies_

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      phing phpunit

_executes *phpunit*-tests_

    docker run --rm -ti \
      -v /path/to/vufind:/usr/local/vufind \
      services.ub.uni-leipzig.de:10443/bdd_dev/vufind/util:latest \
      phing phpcs-console

_executes the code sniffer_

### autoconfig

[autoconfig] is a tool to configure [VuFind] based on provided commandline parameters and/or environment-variables. It was developed as deploy-tool and is therefore also capable of creating the [VuFind]-Database, install composer-dependencies and running grunt to compile the css-files.

However, This tool expects an existing default-configuration in a folder built from the `VUFIND_BASE_DIR` - defaulting to `/usr/local/vufind` - and the `VUFIND_SITE` - required, for example `local` -, resulting in folder `/usr/local/vufind/local`.
It then creates a new folder based on the environment variable `VUFIND_INSTANCE` - required, for example `staging` -, resulting in `/usr/local/vufind/local/staging`, which will hold the final configuration and has do be provided to the application server via the environement variable `VUFIND_LOCAL_DIR`, see [Usage of the Image].

```bash
$ docker run --rm -ti \
    -v /path/to/vufind:/usr/local/vufind \
    -e VUFIND_SITE=local \
    -e VUFIND_INSTANCE=staging \
    -e VF_config_ini__Database__database=mysql://vufind:vufindpw@db/vufind \
    -e VF_config_ini__Authentication__hash_passwords=true \
    -e VF_config_ini__Authentication__encrypt_ils_password=true \
    ubleipzig/vufind-php:5.6 \
    autoconfig vufind deploy
```
_this creates a new configuration under `/usr/local/vufind/local/staging` which inherits from the default configuration under `/usr/local/vufind/local` and adds additional settings to the file `config.ini`

    [Database]
    database = mysql://vufind:vufindpw@db/vufind

    [Authentication]
    hash_passwords = true
    encrypt_ils_password = true

Furthermore [autoconfig] will try to create the database based on the credentials provided in the `config.ini`-settings.

Further information about [autoconfig]s usage you can find in the [documentation of *autoconfig*][autoconfig]

## Notes

* The _vufind1-*_-Image exists only for development purposes. It enables developers to easily switch containers when they have VuFind1-work to do.
* There are no tests until i know how to write them for Docker-images

[VuFind]: https://github.com/vufind-org/vufind
[official PHP-Image]: https://hub.docker.com/_/php/
[7.2/Dockerfile]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/vufind-php/blob/master/7.2/Dockerfile
[7.1/Dockerfile]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/vufind-php/blob/master/7.1/Dockerfile
[7.0/Dockerfile]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/vufind-php/blob/master/7.0/Dockerfile
[5.6/Dockerfile]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/vufind-php/blob/master/5.6/Dockerfile
[autoconfig]: https://ubleipzig.github.io/autoconfig/
[Usage of the Image]: #Usage-of-the-Image