#!/usr/bin/env bash

# Install packages.
apt-get install -y --no-install-recommends nodejs

# Update npm.
npm update --global npm

# Configure npm.
npm config set registry http://registry.npmjs.org/
npm config set strict-ssl false

# Install node modules.
npm install --global --production --no-optional grunt-cli
npm install --global --production --no-optional gulp
npm install --global --production --no-optional bower
npm install --global --production --no-optional yo
npm install --global --production --no-optional localtunnel
npm install --global --production --no-optional browser-sync
