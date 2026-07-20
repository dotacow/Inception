ARG ALPINE_VERSION=3.23
FROM alpine:${ALPINE_VERSION}

RUN adduser -S -G www-data www-data

RUN apk update && apk add --no-cache \
	curl \
	mariadb-client \
	php \
	php-fpm \
	php-mysqli \
	php-phar \
	php-mbstring \
	php-curl \
	php-dom \
	php-exif \
	php-fileinfo \
	php-xml \
	php-zip \
	php-openssl \
	php-intl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
	
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html
RUN ln -s /usr/sbin/php-fpm84 /usr/sbin/php-fpm
COPY conf/www.conf /etc/php/php-fpm.d/www.conf
COPY tools/wp-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-entrypoint.sh
WORKDIR /var/www/html
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-entrypoint.sh"]