FROM php:8.2-fpm-alpine

# Useful PHP extension installer image, copy binary into your container
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# APK stands for Alpine Linux package keeper (manager). One can use the apk command to delete, install, upgrade, or list software
# An access control list (ACL) contains rules that grant or deny access to certain digital environments.
# Description: FASTCgi (fcgi) is a language independent, high performant extension to CGI. https://archlinux.org/packages/extra/x86_64/fcgi/
# The file command is used to determine the type of a file
# The gettext program translates a natural language message into the user's language
RUN apk add --no-cache \
		acl \
        bash \
        fcgi \
		file \
		gettext \
		git \
	;

# https://docs.moodle.org/311/en/admin/environment/php_extension/intl
# https://www.educba.com/php-zip-files/
# The APCu extension adds object caching functions to PHP.
# OPcache is a type of caching system that saves precompiled script bytecode in a server’s memory called a cache, so each time a user visits a web page, it loads faster.
RUN set -eux; \
    install-php-extensions \
    	intl \
    	zip \
    	apcu \
		opcache \
        pdo pdo_mysql \
    ;

# allow super user - set this if you use Composer as a
# super user at all times like in docker containers
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer (copy composer in PHP image)
COPY --from=composer /usr/bin/composer /usr/bin/composer
# obtain composer using multi-stage build
# https://docs.docker.com/build/building/multi-stage/
#COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

# copy application files to the working directory (/var/www/html)
COPY . .

# Xdebug has different modes / functionalities. See https://xdebug.org/docs/all_settings#mode
# We can default to 'off' and set to 'debug' when we run docker compose up if we need it
ENV XDEBUG_MODE=develop

# Copy xdebug config file into container
COPY ./.docker/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
#COPY ./.docker/xdebug.ini $PHP_INI_DIR/xdebug.ini

# Install xdebug
RUN set -eux; \
	install-php-extensions xdebug

# Instal Symfony CLI (https://symfony.com/download)
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony*/bin/symfony /usr/local/bin/symfony