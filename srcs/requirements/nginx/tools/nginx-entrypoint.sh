#!/bin/sh

set -e

CERT_DIR="/etc/nginx/ssl"
CERT="$CERT_DIR/inception.crt"
KEY="$CERT_DIR/inception.key"


sed -i "s/_DOMAIN_NAME_/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf

if [ ! -d "$CERT_DIR" ]; then
	mkdir -p "$CERT_DIR"
fi

if [ ! -f "$CERT" ] || [ ! -f "$KEY" ]; then
	echo "NGINX Entrypoint: Setting up self-signed SSL for ${DOMAIN_NAME}..."

	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout "$KEY" -out "$CERT" \
		-subj "/CN=${DOMAIN_NAME}" \
		-addext "subjectAltName = DNS:${DOMAIN_NAME}"

	echo "NGINX Entrypoint: SSL certificates generated."
else
	echo "NGINX Entrypoint: SSL certificates already exist. Skipping generation."
fi

echo "NGINX Entrypoint: Starting Nginx..."
exec nginx -g "daemon off;"