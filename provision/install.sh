#!/usr/bin/env bash

echo "Provisioning Box ..."

export DEBIAN_FRONTEND=noninteractive

# Add common packages.
apt-get install -y software-properties-common

# Add PPAs.
add-apt-repository -y ppa:git-core/ppa
apt-add-repository -y ppa:chris-lea/redis-server
apt-add-repository -y ppa:ondrej/mysql-5.6
apt-add-repository -y ppa:nginx/development
apt-add-repository -y ppa:ondrej/apache2
apt-add-repository -y ppa:ondrej/php
wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
add-apt-repository -y https://deb.nodesource.com/node_5.x

# Update packages.
apt-get update
apt-get upgrade -y

# Install common packages.
apt-get install -y --no-install-recommends \
build-essential curl dos2unix gcc libmcrypt4 libpcre3-dev make \
graphicsmagick sqlite3 libsqlite3-dev memcached ssl-cert ntp

# Install services.
source /vagrant/provision/installation/git.sh
source /vagrant/provision/installation/redis.sh
source /vagrant/provision/installation/mysql.sh
source /vagrant/provision/installation/nginx.sh
source /vagrant/provision/installation/apache.sh
source /vagrant/provision/installation/php.sh
source /vagrant/provision/installation/postfix.sh
source /vagrant/provision/installation/dovecot.sh
source /vagrant/provision/installation/node.sh

# Configure backup.
cp /vagrant/provision/automation/cron /etc/cron.d/vagrant
