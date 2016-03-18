#!/usr/bin/env bash

# Add PPA.
add-apt-repository -u -y ppa:git-core/ppa

# Install packages.
apt-get install -y --no-install-recommends git
