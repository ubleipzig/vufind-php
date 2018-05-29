FROM ubleipzig/vufind-php:5.6
VOLUME [ "/home/www-data/.npm", "/home/www-data/.composer" ]

ENV VUFIND_ENV=development \
  NODE_ENV=development

COPY assets/docker-entrypoint-debug /docker-entrypoint

RUN apk add --no-cache --update autoconf \
  && pecl install xdebug-2.5.5 \
  && docker-php-ext-enable xdebug \
  && apk del autoconf \
  && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_connect_back=1 ' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && chmod a+x /docker-entrypoint
