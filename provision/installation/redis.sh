#!/usr/bin/env bash

# Add PPA.
apt-add-repository -u -y ppa:chris-lea/redis-server

# Install packages.
apt-get install -y --no-install-recommends redis-server
