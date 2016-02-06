#!/usr/bin/env bash

# Install packages.
apt-get install -y --no-install-recommends postfix

# Configure Postfix.
if ! grep -q -F 'virtual_alias_maps' /etc/postfix/main.cf; then
  echo "home_mailbox = Maildir/" >> /etc/postfix/main.cf
  echo "virtual_alias_maps = regexp:/etc/postfix/virtual" >> /etc/postfix/main.cf
  echo "/.*/ vagrant" > /etc/postfix/virtual
fi

# Restart service.
service postfix restart &> /dev/null
