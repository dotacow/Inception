ARG ALPINE_VERSION=3.23
FROM alpine:${ALPINE_VERSION}

RUN apk update && apk add --no-cache \
    nginx \
    openssl

RUN mkdir -p /run/nginx /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/http.d/default.conf
COPY tools/nginx-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/nginx-entrypoint.sh"]