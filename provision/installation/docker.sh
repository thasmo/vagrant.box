#!/usr/bin/env bash

# Install Docker Engine
if ! type "docker" > /dev/null 2>&1; then
  curl -sSL https://get.docker.com/ | sh
  usermod -aG docker vagrant
fi

# Install Docker Compose.
if ! type "docker-compose" > /dev/null 2>&1; then
  curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi
