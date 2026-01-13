  *This project has been created as part of the 42 curriculum by yousef kitaneh*

---
# Table of Contents
- [Table of Contents](#table-of-contents)
- [Description](#description)
	- [Overview](#overview)
	- [Background and Clarifications](#background-and-clarifications)
	- [Design Choices](#design-choices)
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

![simple_dfd](./simple_dfd.png)
<sup>a simple dfd of the system</sup>

## Background and Clarifications
Containerization is a method of packaging software in a way that isolates it from the host system, mainly for the purpose of portability and consistency across different environments. (i.e. escaping dependency hell).

The container service uses in this project is ***Docker***, which isolates applications and their dependencies into a single package called a container image, which then run on the host's kernel, sharing system resources with other containers, while maintaining isolation from each other and the host system.

This is in contrast to traditional ***virtual machines*** which require a full guest operating system to run on top of the host system, making them more resource-intensive, but more isolated and portable, but since docker is more lightweight, it is more suitable for deployment environments.

In real deployments, both containerization and virtualization are often used together to leverage the benefits of both technologies, but it is important to understand their differences and use cases.

---


## Design Choices
 - alpine linux was chosen as the base image for all services due to its minimal size.
 - to ensure data persistence, volumes were created for the database and wordpress files.
 - to combat software rot, helper scripts were created to automate rebuilding the images with the latest software versions, and configuring environment variables.
 - to ease management, a makefile was created to wrap arounddocker compose commands and helper scripts.


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

below is the list of resources which I found useful while working on this project:

- [Docker's Reference](https://docs.docker.com/reference/)
- [Docker Best Practices](https://docs.docker.com/build/building/best-practices/)
- [How Compose Works](https://docs.docker.com/compose/intro/compose-application-model/)
- [The odo's guidelines to container management](https://cloud.theodo.com/en/blog/docker-processes-container)
- [docker image multi-staging](https://docs.docker.com/get-started/)
- [How to install a LEMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu)
- [Docker's beginner's guide](https://docs.docker.com/get-started/)

AI was used to aid in research and generate boilerplate code snippets, as well as proofreading documentation.