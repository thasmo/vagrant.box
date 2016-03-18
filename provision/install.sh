#!/usr/bin/env bash

echo "Provisioning Box ..."

export DEBIAN_FRONTEND=noninteractive

# Update packages.
apt-get update
apt-get upgrade -y

# Install common packages.
apt-get install -y --no-install-recommends software-properties-common \
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
