#!/usr/bin/env bash

# Add PPA.
apt-add-repository -u -y ppa:ondrej/apache2

# Install packages.
apt-get install -y --no-install-recommends apache2

# Copy configuration files.
cp /vagrant/provision/configuration/apache/apache2.conf /etc/apache2/apache2.conf
cp /vagrant/provision/configuration/apache/ports.conf /etc/apache2/ports.conf

# Create hosts.conf file.
touch /etc/apache2/hosts.conf

# Disable default hosts.
a2dissite default-ssl
a2dissite 000-default

# Enable modules.
a2enmod headers
a2enmod actions
a2enmod proxy_fcgi
a2enmod rewrite
a2enmod ssl
a2enmod vhost_alias

# Restart service.
service apache2 restart &> /dev/null
