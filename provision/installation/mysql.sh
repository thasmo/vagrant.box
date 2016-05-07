#!/usr/bin/env bash

# Install packages.
apt-get install -y --no-install-recommends mysql-server

# Configure server.
mysql -e "UPDATE mysql.user SET Host='%', plugin='mysql_native_password', authentication_string=password('') WHERE user='root';"

# Copy configuration files.
cp /vagrant/provision/configuration/mysql/custom.cnf /etc/mysql/mysql.conf.d/z-custom.cnf

# Restart service.
service mysql restart &> /dev/null
