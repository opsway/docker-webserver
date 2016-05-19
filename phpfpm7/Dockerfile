FROM php:7.0-fpm-alpine

RUN apk upgrade --update && apk add \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libmcrypt-dev \
  libpng-dev \
  bash \
  git \
  nodejs

RUN docker-php-ext-install pdo iconv mcrypt intl mbstring pdo_mysql pdo_pgsql pgsql json zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

ENV PHPREDIS_VERSION php7

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

RUN docker-php-ext-enable opcache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN npm install -g bower

COPY php.ini /usr/local/etc/php/php.ini

RUN rm -rf /var/cache/apk/*

ENV TERM="xterm"

#RUN usermod -u 501 www-data

WORKDIR /app

