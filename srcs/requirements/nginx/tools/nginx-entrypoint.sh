#!/bin/sh
set -e

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Generating self-signed TLS certificate..."
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=JO/ST=Amman/L=Amman/O=42/OU=Inception/CN=${DOMAIN_NAME}" \
        > /dev/null 2>&1
    echo "Certificate generated."
fi

sed -i "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" /etc/nginx/http.d/default.conf

echo "Starting NGINX..."
exec nginx -g "daemon off;"