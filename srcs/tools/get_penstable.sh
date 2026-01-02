#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../.env"

VERSION=$(curl -s "https://hub.docker.com/v2/repositories/library/alpine/tags?page_size=100" | \
  jq -r '.results[].name' | \
  grep -E '^[0-9]+\.[0-9]+$' | \
  sort -V | \
  tail -n 2 | \
  head -n 1)

if [ -z "$VERSION" ]; then
    echo "Error: Could not fetch Alpine version."
    exit 1
fi

CURRENT_VERSION=""
if [ -f "$ENV_FILE" ]; then
    CURRENT_VERSION=$(grep "^ALPINE_VERSION=" "$ENV_FILE" | cut -d '=' -f2)
fi

if [ "$CURRENT_VERSION" != "$VERSION" ]; then
    echo "Alpine version out of date ($CURRENT_VERSION -> $VERSION),updating."

    touch "$ENV_FILE"

    if grep -q "^ALPINE_VERSION=" "$ENV_FILE"; then
        sed -i "s/^ALPINE_VERSION=.*/ALPINE_VERSION=$VERSION/" "$ENV_FILE"
    else
        echo "ALPINE_VERSION=$VERSION" >> "$ENV_FILE"
    fi
else
    echo "Alpine version is up-to-date ($VERSION). No changes made."
fi