# Table of Contents

- [Table of Contents](#table-of-contents)
- [Prerequisites:](#prerequisites)
- [Setting up](#setting-up)
- [Building](#building)
- [Launching](#launching)
- [Container \& Volume Management](#container--volume-management)

---

# Prerequisites:

This project's only core requirement is the docker cli and docker daemon.

```bash
› docker --version 
Docker version 29.0.2, build 8108357 #docker cli version
› dockerd --version
Docker version 29.0.2, build e9ff10b #docker engine version
```

The project makes use of the following helper commands that may not be installed
by default in `setup-env.sh`:

- sudo
- curl
- jq

# Setting up

Just run `./srcs/tools/setup-env.sh` to launch the setup wizard which will guide
you through the setup process and fill out all required environment variables
and secrets. you can check out the templates for secrets and environment
variables in `secretsss/` and `srcs/.env.example` respectively.

# Building

after setting up, you can build the project by running:

```bash
make \
		build # build while using the cache
		build-no-cache # force a clean build
```

# Launching

you can launch the project by running:

```bash
make up
```

to restart the project, you can run:

```bash
make re
```

# Container & Volume Management

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

You can check out (and remove) the created volumes at `~/data/`.
