#!/usr/bin/env bash

echo "Provisioning Box ..."

export DEBIAN_FRONTEND=noninteractive

# Update Packages
apt-get update
apt-get upgrade -y

# Add Repositories
apt-get install -y software-properties-common
apt-add-repository -y ppa:nginx/stable
apt-add-repository -y ppa:rwky/redis
apt-add-repository -y ppa:ondrej/apache2
apt-add-repository -y ppa:ondrej/php5-5.6
apt-add-repository -y ppa:ondrej/mysql-5.6
add-apt-repository -y ppa:git-core/ppa

# Add Node Repository
wget -O - https://deb.nodesource.com/setup | sudo bash -

# Install Packages
apt-get install -y \
build-essential curl dos2unix gcc git libmcrypt4 libpcre3-dev make imagemagick postfix dovecot-imapd \
apache2 nginx nodejs sqlite3 libsqlite3-dev mysql-server redis-server memcached ssl-cert ntp \
php5-cli php5-dev php5-mysqlnd php5-sqlite php5-apcu php5-json php5-curl php5-gd \
php5-gmp php5-imap php5-mcrypt php5-xdebug php5-memcached php5-redis php5-fpm php5-intl

# Install Node Packages
npm update -g npm
npm install -g grunt-cli
npm install -g gulp
npm install -g bower
npm install -g yo

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
cp /vagrant/provision/configuration/nginx/mime.types /etc/nginx/mime.types
rm /etc/nginx/sites-enabled/default
service nginx restart &> /dev/null

# Configure PHP
cp /vagrant/provision/configuration/php/pool.ini /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart &> /dev/null

# Configure MySQL
mysql --user="root" --password="" -e "UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';"
cp /vagrant/provision/configuration/mysql/custom.cnf /etc/mysql/conf.d/custom.cnf
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
