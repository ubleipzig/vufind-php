FROM image-7.1
VOLUME [ "/home/www-data/.npm", "/home/www-data/.composer" ]

ENV VUFIND_ENV=development \
  NODE_ENV=development

COPY assets/docker-entrypoint-debug /docker-entrypoint

RUN apk add --no-cache --update autoconf \
  && pear config-set http_proxy "`printenv http_proxy`" \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug \
  && apk del autoconf \
  && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_connect_back=1 ' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && sed -e "s!^#\s*StrictHostKeyChecking ask!StrictHostKeyChecking no!" -i /etc/ssh/ssh_config \
  && chmod a+x /docker-entrypoint
