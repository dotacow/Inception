#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../.env"

set -euo pipefail

"${SCRIPT_DIR}/alpine_penstable.sh"
"${SCRIPT_DIR}/debian_penstable.sh"

touch "$ENV_FILE"

if grep -q "^DOMAIN_NAME=" "$ENV_FILE"; then
    sed -i "s/^DOMAIN_NAME=.*/DOMAIN_NAME=yokitane.42.fr/" "$ENV_FILE"
else
    echo "DOMAIN_NAME=yokitane.42.fr" >> "$ENV_FILE"
fi