#!/bin/sh

# start initialization once
if [ ! -f /home/vagrant/initialization ]; then

  # remove packages
  sudo apt-get -q -y remove juju
  sudo apt-get -q -y remove ruby
  sudo apt-get -q -y remove puppet
  sudo apt-get -q -y remove chef
  sudo apt-get -q -y autoremove
  sudo apt-get -q -y clean

  # download and install chef
  sudo wget --content-disposition https://www.opscode.com/chef/install.sh
  sudo sh install.sh

  # finish initialization
  touch /home/vagrant/initialization
fi
