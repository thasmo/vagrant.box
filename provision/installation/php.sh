#!/usr/bin/env bash

# Install packages.
apt-get install -y --no-install-recommends \
php7.0-fpm php7.0-cli php7.0-dev php7.0-mysql php7.0-pgsql php7.0-sqlite3 php7.0-json php7.0-curl php7.0-xml \
php7.0-zip php7.0-gd php7.0-imap php7.0-mcrypt php7.0-intl php7.0-xmlrpc php7.0-bz2 php7.0-opcache php7.0-ldap \
php7.0-soap php7.0-json php7.0-mbstring php7.0-readline php-redis php-memcached php-xdebug php-apcu

# Install Composer.
if ! command -v "composer" > /dev/null; then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
fi

# Copy configuration files.
cp /vagrant/provision/configuration/php/pool.ini /etc/php/7.0/fpm/pool.d/www.conf

# Restart service.
service php7.0-fpm restart &> /dev/null
