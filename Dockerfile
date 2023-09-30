FROM php:8.1-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql

# allow super user - set this if you use Composer as a
# super user at all times like in docker containers
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer (copy composer in PHP image)
COPY --from=composer /usr/bin/composer /usr/bin/composer
# obtain composer using multi-stage build
# https://docs.docker.com/build/building/multi-stage/
#COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

#Here, we are copying only composer.json and composer.lock (instead of copying the entire source)
# right before doing composer install.
# This is enough to take advantage of docker cache and composer install will
# be executed only when composer.json or composer.lock have indeed changed!-
# https://medium.com/@softius/faster-docker-builds-with-composer-install-b4d2b15d0fff
COPY ./composer.* ./

# run "composer install"
RUN composer install --no-progress --no-interaction

# copy application files to the working directory (/var/www/html)
COPY . .

# run composer dump-autoload --optimize
RUN composer dump-autoload --optimize