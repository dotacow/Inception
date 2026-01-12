  *This project has been created as part of the 42 curriculum by yousef kitaneh*

---
# Table of Contents
- [Table of Contents](#table-of-contents)
- [Description](#description)
	- [Overview](#overview)
	- [Design Choices](#design-choices)
	- [Comparison Table](#comparison-table)
- [Prerequisites and Instructions](#prerequisites-and-instructions)
- [Resources](#resources)
---
# Description
## Overview
 Inception is a full [LEMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu) implementation from scratch,
 all services are containerized alongside their dependencies using docker, communicating between each other through the docker network.

 a key requirement for this project is to implement all services from scratch above a minimal linux distribution.

 in this implementation, the following services are provided:
 - an nginx TLS1.3 reverse proxy server.
 - a mariaDB database server
 - adminer to manage the database
 - a wordpress + php-fpm application server
 - redis caching server to reduce database load
 - an FTP server
 - a simple static website to test the reverse proxy and enable .rrd file upload.
 - a rerun server to visulaize .rrd files.

for instructions on how to use the built system, please refer to the [user documentation.](./USER_DOC.md)

## Design Choices
## Comparison Table
# Prerequisites and Instructions
the only dependency you need is ***docker***, in addition to sudo privileges for docker to function properly.

managing the system's containers and volumes is done through a makefile which wraps around the docker compose.

 to build and run the project:
```bash
make up
 ```

to stop the containers:
```bash
make down
```
for an extensive list of managment commands, please refer to the [developer documentation.](./DEV_DOC.m)

# Resources