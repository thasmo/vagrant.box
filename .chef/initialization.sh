#!/bin/sh

# start initialization once
if [ ! -f /home/vagrant/initialization ]; then

  # download and install chef
  sudo wget --content-disposition https://www.opscode.com/chef/install.sh
  sudo sh install.sh -v 11.10.0
  sudo rm install.sh

  # finish initialization
  touch /home/vagrant/initialization
fi
