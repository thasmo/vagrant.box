#!/usr/bin/env bash

# Install packages.
apt-get install -y --no-install-recommends \
php-fpm php-cli php-dev php-mysql php-pgsql php-sqlite3 php-json php-apcu \
php-curl php-gd php-imap php7.0-mcrypt php-intl php-xdebug php-memcached php-redis

# Install Composer.
if ! command -v "composer" > /dev/null; then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
fi

# Copy configuration files.
cp /vagrant/provision/configuration/php/pool.ini /etc/php/7.0/fpm/pool.d/www.conf

# Restart service.
service php7.0-fpm restart &> /dev/null
