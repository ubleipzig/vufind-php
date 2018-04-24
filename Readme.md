# vufind-php

This repository holds the Dockerfiles and VuFind-configuration for the PHP-Application-Server.

## Image-Tags

The images are created via a gitlab-pipeline, see [.gitlab-ci.yml]. There are several tags which can be used:

* `5.6-*`, `7.1-*`, `7.2-*`: points to a specific build. Each build is specified by a number. The higher, the latter.
* `5.6`, `7.1`, `7.2`: points to the latest build from PHPs version-line. It is the same as the last of each specific build.
* `5`, `7`: points to the latest build from PHPs majorversion-line.
* `latest`: always points to the latest PHP version's build.
* `vufind1-*`:  follows the rules above, but points to the image modified for VuFind1

## create Images

Pushing the Code to the Repository does nothing. Images are created via GIT-Tags.

```
git tag -a 7.2-2 -m 'minor optimization'
git push origin 7.2-2
```
_this will create a new image with a tag named `7.2-2`. Also the Tags `7.2`, `7`, and `latest` will point to this image._

```
git tag -a vufind1-5.3-5-debug -m 'minor optimization'
git push origin vufind1-5.3-5-debug
```
_this will create a new image with a tag named `vufind1-5.3-5-debug`. Also the Tags `vufind1-5.3-debug`, `vufind1-5-debug`, and `vufind1-debug` will point to this image._

Only Repository-Masters will be able to create a new Tag.
## Contribution

In case you want to contribute please fork and make a pull-request at [Gitlab-hosting of Leipzig University]. This is due to internal policies and the higher flexibility when it comes to build images and push to [Docker-Hub]

## Todo

* Tests

[.gitlab-ci.yml]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/vufind-php/blob/master/.gitlab-ci.yml
[Gitlab-hosting of Leipzig University]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/vufind-php
[Docker-Hub]: https://hub.docker.com/r/ubleipzig/vufind-php/