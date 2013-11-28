#!/bin/sh

DIR=$( cd "$( dirname "$0" )" && pwd )

# Create directories
sudo mkdir $DIR/.build
sudo mkdir $DIR/htdocs

# Download latest version
sudo wget -O $DIR/.build/phpmyadmin.zip http://sourceforge.net/projects/phpmyadmin/files/latest/download

# Extract archive
sudo unzip $DIR/.build/phpmyadmin.zip -d $DIR/.build
sudo mv $DIR/.build/phpMyAdmin* $DIR/.build/phpmyadmin

# Copy configuration
sudo cp $DIR/config.inc.php $DIR/.build/phpmyadmin/config.inc.php

# Move files
sudo mv $DIR/.build/phpmyadmin/* $DIR/htdocs

# Clean up
sudo rm -rf $DIR/.build

