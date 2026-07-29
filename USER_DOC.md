# Table of Contents

- [Table of Contents](#table-of-contents)
- [Services Provided](#services-provided)
- [Starting and Stopping the Project](#starting-and-stopping-the-project)
- [Accessing the Website](#accessing-the-website)
- [Locating and Managing Credentials](#locating-and-managing-credentials)
- [Verifying Service Health](#verifying-service-health)
	- [MariaDB](#mariadb)

# Services Provided

This project provides a LEMP(Linux,Nginx,MariaDB,PHP) stack implementation, with
the addition of PHP-FPM for dynamic content processing, as well as a WordPress
content management system. each service is containerized and the associated
services communicate over the docker network.

# Starting and Stopping the Project

Refer to the [developer documentation](./DEV_DOC.md) for instructions on how to
manage the projects lifecycle.

# Accessing the Website

To access the WordPress website:

- **Public Site:** `https://<DOMAIN_NAME>`
- **Login Portal:** `https://<DOMAIN_NAME>/wp-login.php`
- **Administration Dashboard:** `https://<DOMAIN_NAME>/wp-admin/`

> Make sure to use https! some browsers will automaticlly fill in http.

> Your browser will display a security warning on the first visit because the
> SSL certificate is self-signed.

# Locating and Managing Credentials

You can checkout `requirements/.env.example` for a preview of the .env file,
Although the setup wizard will guide you through the process of creating the
.env file and secrets.

While the setup script automatically creates the required secrets, you can also
manage them manually in the `requirements/secrets/` directory:

- `db_password.txt`: Standard database user password.
- `db_root_password.txt`: Database root administrator password.
- `wp_admin_password.txt`: WordPress admin panel password.
- `wp_password.txt`: Standard WordPress user password.

# Verifying Service Health

To confirm all services are running and healthy:

1. Run `docker ps`. You should see three containers (`nginx`, `wordpress`,
   `mariadb`) with an `Up (healthy)` status.
2. You can checkout the aggregated logs via

```bash
docker compose -f srcs/compose.yaml logs -f
```

## MariaDB

Some commands to verify the mariaDB service:

```bash
mariadb -u root -p # to login to the database as root
show databases;
use wordpress;
show TABLES;
describe <table_name>;
```
