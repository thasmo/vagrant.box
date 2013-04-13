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

  # install latest chef version
  sudo wget -O setup.deb "http://www.opscode.com/chef/download?p=ubuntu&pv=12.10&m=x86_64"
  sudo chmod +x setup.deb
  sudo dpkg -i setup.deb
  sudo rm -f setup.deb

  # finish initialization
  touch /home/vagrant/initialization
fi
