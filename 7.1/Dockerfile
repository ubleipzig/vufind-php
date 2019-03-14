FROM php:7.1-fpm-alpine3.8
ENTRYPOINT [ "/docker-entrypoint" ]
VOLUME [ "/var/cache/vufind", "/usr/local/vufind" ]

ENV VUFIND_CACHE_DIR=/var/cache/vufind \
  VUFIND_APPLICATION_PATH=/usr/local/vufind \
  VUFIND_LOCAL_DIR=/usr/local/vufind/local \
  VUFIND_ENV=production \
  NODE_ENV=production

COPY assets/docker-entrypoint /docker-entrypoint

RUN apk add --no-cache --update --virtual .build-deps icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev libxslt-dev postgresql-dev zlib-dev bzip2-dev libzip-dev autoconf \
  && apk add --no-cache --update libpng libjpeg-turbo freetype icu-libs libpq libmcrypt libxslt libzip python make g++ coreutils nodejs nodejs-npm git subversion openssh openssl bash \
  && pear config-set http_proxy "`printenv http_proxy`" \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-jpeg-dir=/usr/include \
  && docker-php-ext-install -j$(nproc) intl mysqli pdo_pgsql pdo_mysql pdo gd xsl soap zip bz2 \
  && pecl install mcrypt-1.0.0 \
  && docker-php-ext-enable mcrypt \
  && apk del .build-deps \
  && npm install -g @ubleipzig/autoconfig eslint@"<3.0.0" \
  # hack for issue https://github.com/sass/node-sass/issues/1757
  && cd /tmp \
  && npm install -j$(nproc) grunt-sass@"^1.0.0" \
  && cd /tmp/node_modules/node-sass \
  && node scripts/build -f -j $(nproc) \
  && SASS_VER=`ls /tmp/node_modules/node-sass/vendor/` \
  && cp /tmp/node_modules/node-sass/vendor/${SASS_VER}/binding.node /root/.npm/node-sass/3.13.1/${SASS_VER}_binding.node \
  && rm /tmp/* -rf \
  && cp -a ~/.npm ~www-data/.npm \
  && chown www-data:www-data ~www-data/.npm -R \
  && rm /var/lib/apt/lists/* -rf \
  && pear install pear/Http_Request2 \
  && pear channel-discover pear.phing.info \
  && pear install phing/phing \
  && chmod a+x /docker-entrypoint

WORKDIR ${VUFIND_APPLICATION_PATH}

CMD [ "php-fpm" ]
