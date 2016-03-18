#!/usr/bin/env bash

# Add PPA.
apt-add-repository -u -y ppa:nginx/development

# Install packages.
apt-get install -y --no-install-recommends -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" nginx-full

# Copy configuration files.
cp /vagrant/provision/configuration/nginx/nginx.conf /etc/nginx/nginx.conf
cp /vagrant/provision/configuration/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
cp /vagrant/provision/configuration/nginx/mime.types /etc/nginx/mime.types

# Create hosts.conf file.
touch /etc/nginx/hosts.conf

# Disable default host.
rm /etc/nginx/sites-enabled/default

# Restart service.
service nginx restart &> /dev/null
