#!/usr/bin/env bash

echo "Provisioning Box ..."

export DEBIAN_FRONTEND=noninteractive

# Add Repositories
apt-get install -y software-properties-common
apt-add-repository -y ppa:nginx/development
apt-add-repository -y ppa:chris-lea/redis-server
apt-add-repository -y ppa:ondrej/apache2
apt-add-repository -y ppa:ondrej/php-7.0
apt-add-repository -y ppa:ondrej/mysql-5.6
add-apt-repository -y ppa:git-core/ppa

wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
add-apt-repository https://deb.nodesource.com/node_5.x

# Update Packages
apt-get update
apt-get upgrade -y

# Install Packages
apt-get install -y \
build-essential curl dos2unix gcc git libmcrypt4 libpcre3-dev make graphicsmagick postfix dovecot-imapd \
apache2 nginx nodejs sqlite3 libsqlite3-dev mysql-server redis-server memcached ssl-cert ntp \
php-fpm php-cli php-dev php-opcache php-mysql php-pgsql php-sqlite3 php-json php-apcu \
php-curl php-gd php-imap php7.0-mcrypt php-intl php-xdebug php-memcached php-redis

# Install Node Packages
npm update --global npm
npm install --global --production grunt-cli
npm install --global --production gulp
npm install --global --production bower
npm install --global --production yo
npm install --global --production localtunnel
npm install --global --production browser-sync

# Install Composer
if ! command -v "composer" > /dev/null; then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
fi

# Configure Apache
cp /vagrant/provision/configuration/apache/apache2.conf /etc/apache2/apache2.conf
cp /vagrant/provision/configuration/apache/ports.conf /etc/apache2/ports.conf
touch /etc/apache2/hosts.conf
a2dissite default-ssl
a2dissite 000-default
a2enmod actions
a2enmod proxy_fcgi
a2enmod rewrite
a2enmod ssl
a2enmod vhost_alias
service apache2 restart &> /dev/null

# Configure Nginx
cp /vagrant/provision/configuration/nginx/nginx.conf /etc/nginx/nginx.conf
cp /vagrant/provision/configuration/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
cp /vagrant/provision/configuration/nginx/mime.types /etc/nginx/mime.types
rm /etc/nginx/sites-enabled/default
service nginx restart &> /dev/null

# Configure PHP
cp /vagrant/provision/configuration/php/pool.ini /etc/php/7.0/fpm/pool.d/www.conf
service php7.0-fpm restart &> /dev/null

# Configure MySQL
mysql --user="root" --password="" -e "UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';"
cp /vagrant/provision/configuration/mysql/custom.cnf /etc/mysql/mysql.conf.d/z-custom.cnf
rm /usr/my.cnf
service mysql restart &> /dev/null

# Configure Postfix
if ! grep -q -F 'virtual_alias_maps' /etc/postfix/main.cf; then
  echo "home_mailbox = Maildir/" >> /etc/postfix/main.cf
  echo "virtual_alias_maps = regexp:/etc/postfix/virtual" >> /etc/postfix/main.cf
  echo "/.*/ vagrant" > /etc/postfix/virtual
  service postfix restart &> /dev/null
fi

# Configure Dovecot
echo "mail_location = maildir:~/Maildir" > /etc/dovecot/conf.d/99-custom.conf
service dovecot restart &> /dev/null

# Configure Backup
cp /vagrant/provision/automation/cron /etc/cron.d/vagrant
