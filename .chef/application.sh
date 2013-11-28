#!/bin/sh

# start initialization once
if [ ! -f /home/vagrant/application ]; then

  # PhpMyAdmin
  sudo sh /var/www/dev/host/pma/install.sh

  # Roundcube
  sudo sh /var/www/dev/host/mail/install.sh

  # finish initialization
  touch /home/vagrant/application
fi
