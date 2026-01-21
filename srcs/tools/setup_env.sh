#!/bin/bash

set -euo pipefail

./alpine_penstable.sh
./debian_penstable.sh
echo "DOMAIN_NAME=yokitane.42.fr">> ../.env