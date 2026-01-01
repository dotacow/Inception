#!/bin/bash

VERSION=$(curl -s "https://hub.docker.com/v2/repositories/library/alpine/tags?page_size=100" | \
  jq -r '.results[].name' | \
  grep -E '^[0-9]+\.[0-9]+$' | \
  sort -V | \
  tail -n 2 | \
  head -n 1)

echo "Penultimate Alpine version: $VERSION"

touch srcs/.env

if grep -q "^ALPINE_VERSION=" srcs/.env; then
  sed -i "s/^ALPINE_VERSION=.*/ALPINE_VERSION=$VERSION/" srcs/.env
else
  echo "ALPINE_VERSION=$VERSION" >> srcs/.env
fi
echo "Updated .env with ALPINE_VERSION=$VERSION"