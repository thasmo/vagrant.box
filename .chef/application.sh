#!/bin/sh

# PhpMyAdmin
if [ ! -f /var/www/dev/pma/install.lock ]; then
  sudo sh /var/www/dev/pma/install.sh
  touch /var/www/dev/pma/install.lock
fi

# Roundcube
if [ ! -f /var/www/dev/mail/install.lock ]; then
  sudo sh /var/www/dev/mail/install.sh
  touch /var/www/dev/mail/install.lock
fi
