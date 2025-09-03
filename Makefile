COMPOSE=docker compose
COMPOSE_FILE=./srcs/docker-compose.yml

# up:
# 	$(COMPOSE) -f $(COMPOSE_FILE) up -d

down:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v

build:
	$(COMPOSE) -f $(COMPOSE_FILE) up --build

