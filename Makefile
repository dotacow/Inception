all: up

build:
	docker compose -f srcs/compose.yaml build

build-no-cache:
	docker compose -f srcs/compose.yaml build --no-cache

up:
	docker compose -f srcs/compose.yaml up -d --build

down:
	docker compose -f srcs/compose.yaml down

re: down all

clean:
	docker compose -f srcs/compose.yaml down --rmi --volumes --remove-orphans -t10

.PHONY: all build build-no-cache up re stop clean