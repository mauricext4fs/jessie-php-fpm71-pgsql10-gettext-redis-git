# jessie-php-fpm71-pgsql10-gettext-redis-git
Jessie PHP 7.1 FPM with PDO/Postgresql10 lib, gettext, redis native, git and composer

## Base Docker

php:7.1-fpm

## Expose

port 9000

## Extra packages installed from the base docker

 - libmcrypt-dev
 - openssl
 - locales
 - gettext
 - wget
 - git
 - libicu-dev
 - zlib1g-dev
 - postgresql-10
 - postgresql-server-dev-10
 - composer (installed in /usr/local/bin/composer)

## Extra PHP packages enabled

 - iconv
 - mcrypt
 - zip
 - pdo_pgsql
 - intl
 - gettext
 - mbstring
 - redis

## Description

This docker expect the php files to be mounted / copy  directly in /var/www

Using run will automatically run composer install and then start php-fpm on port 9000.
This is mean to be used in tandem with a docker container running either nginx or apache.

## Usage

### Installing package from composer.json

```shell
docker run -it --rm -v $PWD:/var/www mauricext4fs/jessie-php-fpm71-pgsql10-gettext-redis-git composer install
```

### Adding package with composer

```shell
docker run -it --rm -v $PWD:/var/www mauricext4fs/jessie-php-fpm71-pgsql10-gettext-redis-git composer require nikic/fast-route
```

### Runing php-fpm in foreground

```shell
docker run -it --rm -v $PWD:/var/www mauricext4fs/jessie-php-fpm71-pgsql10-gettext-redis-git
```

