all: up

build:
	docker compose -f srcs/compose.yaml build

build-no-cache:
	docker compose -f srcs/compose.yaml build --no-cache

up:
	docker compose -f srcs/compose.yaml up -d --build

down:
	docker compose -f srcs/compose.yaml down

re: down clean build-no-cache up

clean:
	docker compose -f ./srcs/compose.yaml down --volumes --rmi all
# docker system prune -a --volumes -f (only turn this on in the vm)
.PHONY: all build build-no-cache up re stop clean