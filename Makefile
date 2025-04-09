.PHONY: help setup build up down

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "  targets:"
	@echo "    setup     Create required directories (e.g., bagfiles)"
	@echo "    build     Build the Docker image using docker-compose"
	@echo "    up        Start the container in detached mode"
	@echo "    down      Stop and remove the container"

setup:
	@if [ -d $(HOME)/bagfiles ]; then \
	  echo "$(HOME)/bagfiles already exists"; \
	else \
	  mkdir -pv $(HOME)/bagfiles && echo "Created $(HOME)/bagfiles"; \
	fi

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down
