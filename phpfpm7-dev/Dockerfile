FROM php:7.0-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libicu-dev \
        libpq-dev

RUN docker-php-ext-install pdo iconv mcrypt intl mbstring pdo_mysql pdo_pgsql pgsql json zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

ENV PHPREDIS_VERSION php7
ENV XDEBUG_VERSION XDEBUG_2_4_1

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

RUN curl -L -o /tmp/xdebug.tar.gz https://github.com/xdebug/xdebug/archive/$XDEBUG_VERSION.tar.gz \
    && tar xfz /tmp/xdebug.tar.gz \
    && rm -r /tmp/xdebug.tar.gz \
    && mv xdebug-$XDEBUG_VERSION /usr/src/php/ext/xdebug \
    && docker-php-ext-install xdebug

RUN docker-php-ext-enable opcache

RUN apt-get install -y git

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g bower

COPY php.ini /usr/local/etc/php/php.ini
COPY docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#RUN usermod -u 501 www-data

WORKDIR /var/www/current

EXPOSE 9090
