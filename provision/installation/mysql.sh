#!/usr/bin/env bash

# Add PPA.
apt-add-repository -u -y ppa:ondrej/mysql-5.6

# Install packages.
apt-get install -y --no-install-recommends mysql-server

# Configure server.
mysql --user="root" --password="" -e "UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';"

# Copy configuration files.
cp /vagrant/provision/configuration/mysql/custom.cnf /etc/mysql/mysql.conf.d/z-custom.cnf
#rm /usr/my.cnf

# Restart service.
service mysql restart &> /dev/null
