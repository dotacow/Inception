#!/bin/sh
set -eu


if [ -f "/run/secrets/db_password" ] && [ -r "/run/secrets/db_password" ]; then
	SQL_PASSWORD=$(cat /run/secrets/db_password | sed "s/'/''/g")
fi

if [ -f "/run/secrets/wp_admin_password" ] && [ -r "/run/secrets/wp_admin_password" ]; then
	WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password | sed "s/'/''/g")
fi

if [ -f "/run/secrets/wp_password" ] && [ -r "/run/secrets/wp_password" ]; then
	WP_PASSWORD=$(cat /run/secrets/wp_password | sed "s/'/''/g")
fi

if [ -z "$SQL_PASSWORD" ] || [ -z "$WP_ADMIN_PASSWORD" ] || [ -z "$WP_PASSWORD" ]; then
	echo "[ERROR] Failed to load passwords from secrets"
	exit 1
fi

while ! mariadb -h"$SQL_HOSTNAME" -u"$SQL_USER" -p"$SQL_PASSWORD" -e "SELECT 1;"; do
	echo "Waiting for MariaDB..."
	sleep 3
done
echo "MariaDB Connection established."

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Installing WordPress..."
		
	php -d memory_limit=512M /usr/local/bin/wp core download --allow-root --path='/var/www/html'
		
	wp config create --allow-root \
		--dbname="$SQL_DATABASE" \
		--dbuser="$SQL_USER" \
		--dbpass="$SQL_PASSWORD" \
		--dbhost="$SQL_HOSTNAME:$SQL_HOSTPORT" \
		--path='/var/www/html'
		
	wp core install --allow-root \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--path='/var/www/html'
		
	wp user create --allow-root \
		"$WP_USER" "$WP_USER_EMAIL" \
		--user_pass="$WP_PASSWORD" \
		--role=author \
		--path='/var/www/html' || echo "Author user creation failed or already exists."
fi

echo "PHP-FPM Started"
exec php-fpm -y /etc/php/php-fpm.d/www.conf -F