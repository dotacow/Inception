ARG ALPINE_VERSION=3.23
FROM alpine:${ALPINE_VERSION}

RUN adduser -S -G www-data www-data

RUN apk update && apk add --no-cache \
	curl \
	mariadb-client \
	php82 \
	php82-fpm \
	php82-mysqli \
	php82-phar \
	php82-mbstring \
	php82-curl \
	php82-dom \
	php82-exif \
	php82-fileinfo \
	php82-xml \
	php82-zip \
	php82-openssl \
	php82-intl

RUN ln -sf /usr/bin/php82 /usr/bin/php  && ln -sf /usr/sbin/php-fpm82 /usr/sbin/php-fpm

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
	
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/wp-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-entrypoint.sh
WORKDIR /var/www/html
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-entrypoint.sh"]