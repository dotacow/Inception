ARG ALPINE_VERSION=3.23
FROM alpine:${ALPINE_VERSION}

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY tools/mdb-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mdb-entrypoint.sh

WORKDIR /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mdb-entrypoint.sh"]