# Developer instructions

## Table of Contents

### environment setup

- [Prerequisites](#prerequisites)
- [Configs](#configs)
- [Secrets] (#secrets)

### Docker version used:

- Docker version 29.0.2, build 8108357

### useful commands

cool debugging command:

```bash
docker exec -it -u root <container_name> /bin/sh
```

layer & states:

```bash
docker history <image_name> # sequence and layers
docker \
			inspect <image_name> # JSON metadata of image
			network inspect <network_name> # JSON metadata of network
			volume inspect <volume_name> #
```

fclean:

```bash
make down
docker system prune -a --volumes # Removes all contianers, networks, & volumes.
```
