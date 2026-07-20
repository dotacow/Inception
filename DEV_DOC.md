# Developer instructions

## Table of Contents

### environment setup

- [Prerequisites](#prerequisites)
- [Configs](#configs)
- [Secrets] (#secrets)

### Docker version used:

- Docker version 29.0.2, build 8108357

### useful commands

cool debugging commands:

```bash
docker exec -it -u root <container_name> <command> # general purpose container debugging

netstat -tulnp # check listening ports

```

layer & states:

```bash
docker history <image_name> # sequence and layers
docker \
			inspect <image_name> # JSON metadata of image
			network inspect <network_name> # JSON metadata of network
			volume inspect <volume_name> #
```
container specific:

```bash
docker exec -it wordpress wp user list --allow-root --path=/var/www/html # list all users

docker exec -it wordpress wp db check --allow-root --path=/var/www/html # check wp-database connection
```