#!/usr/bin/env bash

# Install packages.
apt-get install -y --no-install-recommends dovecot-imapd

# Configure Dovecot.
echo "mail_location = maildir:~/Maildir" > /etc/dovecot/conf.d/99-custom.conf

# Restart service.
service dovecot restart &> /dev/null
