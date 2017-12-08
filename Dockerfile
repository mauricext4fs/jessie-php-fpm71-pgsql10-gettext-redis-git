FROM php:7.1-fpm
RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    openssl \
    locales \
    gettext \
    wget \
    git \
    libicu-dev \
    zlib1g-dev
#RUN apt-get install -y \
#    language-pack-it_CH.utf8

RUN dpkg-reconfigure locales \
	&& locale-gen \
	&& /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'it_CH.UTF-8 UTF-8' >> /etc/locale.gen \
RUN echo 'fr_CH.UTF-8 UTF-8' >> /etc/locale.gen \
RUN echo 'de_CH.UTF-8 UTF-8' >> /etc/locale.gen \
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
	&& locale-gen

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN docker-php-ext-install -j$(nproc) iconv mcrypt
RUN docker-php-ext-install -j$(nproc) zip

#RUN docker-php-ext-install -j$(nproc) curl hash json reflection spl
#RUN docker-php-ext-install -j$(nproc) hash json reflection spl

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    apt-key add - \
    apt-get -y update

RUN apt-get update

RUN apt-get install -y postgresql-10 \
    postgresql-server-dev-10

RUN docker-php-ext-install -j$(nproc) pdo_pgsql

RUN docker-php-ext-configure intl \
	&& docker-php-ext-install intl


RUN docker-php-ext-install \
	gettext \
	mbstring

RUN pecl install redis-3.1.3 \
    && docker-php-ext-enable redis

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

WORKDIR /var/www
EXPOSE 9000
CMD composer install && php-fpm
