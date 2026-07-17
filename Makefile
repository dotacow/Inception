all: up

build: setup_env
	docker compose -f srcs/compose.yaml build

build-no-cache: setup_env
	docker compose -f srcs/compose.yaml build --no-cache

up: setup_env
	docker compose -f srcs/compose.yaml up -d --build

down:
	docker compose -f srcs/compose.yaml down

re: down all

stop:
	docker compose -f srcs/compose.yaml stop -t10

clean:
	docker compose -f srcs/compose.yaml down --rmi --volumes --remove-orphans -t10

setup_env:
	@./srcs/tools/setup_env.sh

.PHONY: all build build-no-cache up down re stop clean setup_env