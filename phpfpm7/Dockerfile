FROM php:7.0-fpm-alpine

RUN apk upgrade --update && apk --no-cache add \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libmcrypt-dev \
  libpng-dev \
  postgresql-dev \
  icu-dev \
  g++ \
  bash \
  git \
  nodejs
RUN apk add --no-cache --virtual .tmp-deps \
    $PHPIZE_DEPS
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd pdo iconv mcrypt intl mbstring pdo_mysql pdo_pgsql pgsql json zip

ENV PHPREDIS_VERSION php7
ENV NEWRELIC_VERSION php5-6.3.0.161

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

RUN docker-php-ext-enable opcache

RUN mkdir -p /tmp/install
RUN cd /tmp/install && wget https://download.newrelic.com/php_agent/release/newrelic-$NEWRELIC_VERSION-linux-musl.tar.gz && \
    tar -xzvf newrelic-$NEWRELIC_VERSION-linux-musl.tar.gz

RUN cd $(php -r 'echo ini_get("extension_dir");') && cp /tmp/install/newrelic-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-20151012.so newrelic.so
RUN cp /tmp/install/newrelic-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon && chmod 0755 /usr/bin/newrelic-daemon
RUN rm -Rf /tmp/install

RUN apk del g++
RUN apk del .build-deps

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN npm install -g bower

COPY php.ini /usr/local/etc/php/php.ini
COPY docker-entrypoint.sh /entrypoint.sh

RUN rm -rf /var/cache/apk/*

ENV TERM="xterm"

#RUN usermod -u 501 www-data

RUN ["chmod", "a+x", "/entrypoint.sh"]
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]

