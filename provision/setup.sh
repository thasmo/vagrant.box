#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update Packages
apt-get update
apt-get upgrade -y

# Add Repositories
apt-get install -y software-properties-common
apt-add-repository -y ppa:nginx/stable
apt-add-repository -y ppa:rwky/redis
apt-add-repository -y ppa:chris-lea/node.js
apt-add-repository -y ppa:ondrej/php5-5.6
apt-add-repository -y ppa:ondrej/mysql-5.6
apt-get update

# Install Packages
apt-get install -y \
build-essential curl dos2unix gcc git libmcrypt4 libpcre3-dev make \
nginx nodejs sqlite3 libsqlite3-dev mysql-server redis-server memcached ssl-cert \
php5-cli php5-dev php5-mysqlnd php5-sqlite php5-apcu php5-json php5-curl php5-gd \
php5-gmp php5-imap php5-mcrypt php5-xdebug php5-memcached php5-redis php5-fpm

# Install Node Packages
npm install -g grunt-cli
npm install -g gulp
npm install -g bower

# Install Composer
if ! command -v "composer" > /dev/null; then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
fi

# Configure Nginx
cp /home/vagrant/provision/configuration/nginx/nginx.conf /etc/nginx/nginx.conf
cp /home/vagrant/provision/configuration/nginx/host/blank.conf /etc/nginx/sites-available/blank
cp /home/vagrant/provision/configuration/nginx/host/default.conf /etc/nginx/sites-available/default
touch /etc/nginx/environment.conf
service nginx restart

# Configure PHP
cp /home/vagrant/provision/configuration/php/pool.ini /etc/php5/fpm/pool.d/www.conf
cp /home/vagrant/provision/configuration/php/php-cli.ini /etc/php5/cli/conf.d/99-custom.ini
cp /home/vagrant/provision/configuration/php/php-fpm.ini /etc/php5/fpm/conf.d/99-custom.ini
service php5-fpm restart

# Configure MySQL
mysql --user="root" --password="" -e "UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';"
cp /home/vagrant/provision/configuration/mysql/custom.cnf /etc/mysql/conf.d/custom.cnf
service mysql restart
