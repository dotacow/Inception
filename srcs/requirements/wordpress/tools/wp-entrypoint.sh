#!/bin/sh
set -e


if [ -f "/run/secrets/db_password.txt" ] && [ -r "/run/secrets/db_password.txt" ]; then
	SQL_PASSWORD=$(cat /run/secrets/db_password.txt 2>/dev/null)
fi

if [ -f "/run/secrets/wp_admin_password.txt" ] && [ -r "/run/secrets/wp_admin_password.txt" ]; then
	WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password.txt 2>/dev/null)
fi

if [ -f "/run/secrets/wp_password.txt" ] && [ -r "/run/secrets/wp_password.txt" ]; then
	WP_PASSWORD=$(cat /run/secrets/wp_password.txt 2>/dev/null)
fi

if [ -z "$SQL_PASSWORD" ] || [ -z "$WP_ADMIN_PASSWORD" ] || [ -z "$WP_PASSWORD" ]; then
	echo "[ERROR] Failed to load passwords from secrets"
	exit 1
fi

while ! mariadb -h"$SQL_HOST" -u"$SQL_USER" -p"$SQL_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
	echo "Waiting for MariaDB..."
	sleep 3
done
echo "MariaDB Connection established."

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Installing WordPress..."
		
	wp core download --allow-root --path='/var/www/html'
		
	wp config create --allow-root \
		--dbname="$SQL_DATABASE" \
		--dbuser="$SQL_USER" \
		--dbpass="$SQL_PASSWORD" \
		--dbhost="$SQL_HOST" \
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

echo "Starting PHP-FPM..."
exec php-fpm -F