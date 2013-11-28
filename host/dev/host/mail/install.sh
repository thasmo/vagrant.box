#!/bin/sh

DIR=$( cd "$( dirname "$0" )" && pwd )

# Create directories
sudo mkdir $DIR/.build
sudo mkdir $DIR/htdocs

# Download latest version
sudo wget -O $DIR/.build/roundcube.tar.gz http://sourceforge.net/projects/roundcubemail/files/latest/download

# Extract archive
sudo tar -xvzf $DIR/.build/roundcube.tar.gz -C $DIR/.build
sudo mv $DIR/.build/roundcubemail* $DIR/.build/roundcube

# Main configuration
sudo mv $DIR/.build/roundcube/config/main.inc.php.dist $DIR/.build/roundcube/config/main.inc.php
sudo sed -i "s~$rcmail_config\['default_host'\] = '';~$rcmail_config\['default_host'\] = 'localhost';~g" $DIR/.build/roundcube/config/main.inc.php
sudo sed -i "s~$rcmail_config\['smtp_server'\] = '';~$rcmail_config\['smtp_server'\] = 'localhost';~g" $DIR/.build/roundcube/config/main.inc.php
sudo sed -i "s~$rcmail_config\['smtp_user'\] = '';~$rcmail_config\['smtp_user'\] = 'vagrant';~g" $DIR/.build/roundcube/config/main.inc.php
sudo sed -i "s~$rcmail_config\['smtp_pass'\] = '';~$rcmail_config\['smtp_pass'\] = 'vagrant';~g" $DIR/.build/roundcube/config/main.inc.php

# Database configuration
sudo mv $DIR/.build/roundcube/config/db.inc.php.dist $DIR/.build/roundcube/config/db.inc.php
sudo sed -i "s~mysql://roundcube:pass@localhost/roundcubemail~sqlite://./sqlite.db~g" $DIR/.build/roundcube/config/db.inc.php
sudo sqlite3 $DIR/.build/roundcube/sqlite.db < $DIR/.build/roundcube/SQL/sqlite.initial.sql

# Move files
sudo mv $DIR/.build/roundcube/* $DIR/htdocs

# Clean up
sudo rm -rf $DIR/.build
