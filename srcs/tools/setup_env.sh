#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../.env"
SECRETS_DIR="${SCRIPT_DIR}/../../secrets"

echo "=== Setup Wizard ==="
echo "enter desired values, or skip to use defaults (in brackets)."

read -p "Domain name [login.42.fr]: " DOMAIN_NAME
DOMAIN_NAME=${DOMAIN_NAME:-login.42.fr}

read -p "Database Name [wordpress]: " SQL_DATABASE
SQL_DATABASE=${SQL_DATABASE:-wordpress}

read -p "Database User [wp_user]: " SQL_USER
SQL_USER=${SQL_USER:-wp_user}

read -p "Database Host [mariadb:3306]: " SQL_HOST
SQL_HOST=${SQL_HOST:-mariadb:3306}

read -p "WordPress Title [mycoolwebsite]: " WP_TITLE
WP_TITLE=${WP_TITLE:-mycoolwebsite}

read -p "WP Admin [BUTTE]: " WP_ADMIN_USER
WP_ADMIN_USER=${WP_ADMIN_USER:-BUTTE}
read -p "WP Admin Email [BUTTE@example.com]: " WP_ADMIN_EMAIL
WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL:-BUTTE@example.com}

read -p "WP User [user]: " WP_USER
WP_USER=${WP_USER:-user}
read -p "WP  User Email [user@example.com]: " WP_USER_EMAIL
WP_USER_EMAIL=${WP_USER_EMAIL:-user@example.com}

echo "---------------------------------------"
echo "Generating secrets and directories..."

"${SCRIPT_DIR}/alpine_penstable.sh"
"${SCRIPT_DIR}/debian_penstable.sh"

sudo mkdir -p "${HOME}/data/wordpress"
sudo mkdir -p "${HOME}/data/mariadb"

mkdir -p "${SECRETS_DIR}"
# employ unbreakable wordle algorithm
## !never actually employ said algorithm in a real environment.
[ ! -f "${SECRETS_DIR}/db_password.txt" ] && echo "PSHAW" > "${SECRETS_DIR}/db_password.txt"
[ ! -f "${SECRETS_DIR}/db_root_password.txt" ] && echo "STOUT" > "${SECRETS_DIR}/db_root_password.txt"
[ ! -f "${SECRETS_DIR}/wp_password.txt" ] && echo "CLACK" > "${SECRETS_DIR}/wp_password.txt"
[ ! -f "${SECRETS_DIR}/wp_admin_password.txt" ] && echo "STEAK" > "${SECRETS_DIR}/wp_admin_password.txt"

touch "$ENV_FILE"

set_env() {
    local key=$1
    local value=$2
    if grep -q "^${key}=" "$ENV_FILE"; then
        sed -i "s|^${key}=.*|${key}=${value}|" "$ENV_FILE"
    else
        echo "${key}=${value}" >> "$ENV_FILE"
    fi
}

set_env "DOMAIN_NAME" "${DOMAIN_NAME}"
set_env "SQL_DATABASE" "${SQL_DATABASE}"
set_env "SQL_USER" "${SQL_USER}"
set_env "SQL_HOST" "${SQL_HOST}"
set_env "WP_TITLE" "${WP_TITLE}"
set_env "WP_ADMIN_USER" "${WP_ADMIN_USER}"
set_env "WP_ADMIN_EMAIL" "${WP_ADMIN_EMAIL}"
set_env "WP_USER" "${WP_USER}"
set_env "WP_USER_EMAIL" "${WP_USER_EMAIL}"

echo "all done! make sure to check .env"