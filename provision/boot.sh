#!/usr/bin/env bash

# Update Composer
if command -v "composer" > /dev/null; then
  echo "Updating Composer ..."
  composer self-update &> /dev/null
fi

# Update Node Modules
if command -v "npm" > /dev/null; then
  echo "Updating Node Modules ..."
  npm update -g &> /dev/null
fi

echo "“Do or do not. There is no try.” — Yoda"
