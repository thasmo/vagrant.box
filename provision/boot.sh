#!/usr/bin/env bash

# Update Composer
if command -v "composer" > /dev/null; then
  composer self-update
fi

echo "Ready. Set. Go!"
