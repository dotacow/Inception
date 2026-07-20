#!/bin/sh
set -eu

# test this once you get it up and running: normalpswd'; SELECT * FROM mysql.user INTO OUTFILE '/tmp/dump.txt'; --
if [ -f "/run/secrets/db_password" ] && [ -r "/run/secrets/db_password" ]; then
    SQL_PASSWORD=$(cat /run/secrets/db_password | sed "s/'/''/g")
fi

if [ -f "/run/secrets/db_root_password" ] && [ -r "/run/secrets/db_root_password" ]; then
    SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password | sed "s/'/''/g")
fi

if [ -z "$SQL_PASSWORD" ] || [ -z "$SQL_ROOT_PASSWORD" ]; then
    echo "Unable to read one of the mariadb secrets."
    exit 1
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing mariadb data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

    echo "Bootstrapping mariadb..."

    cat << EOF > /tmp/init.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
TEMP_PID=$!

    for i in $(seq 1 30); do
        mariadb --socket=/run/mysqld/mysqld.sock -u root -e "SELECT 1;"  && break
        sleep 1
    done

    mariadb --socket=/run/mysqld/mysqld.sock -u root < /tmp/init.sql
    rm -f /tmp/init.sql

    mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${SQL_ROOT_PASSWORD}" shutdown
    kill "$TEMP_PID"
    wait "$TEMP_PID"
else
    echo "Found existing mariadb data directory."
fi

echo "Starting mariadb..."
exec mysqld --user=mysql --console