COMPOSE_FILE=./srcs/docker-compose.yml

down:
	docker compose -f $(COMPOSE_FILE) down

up:
	docker compose -f $(COMPOSE_FILE) up -d

build: set_volumes
	docker compose -f $(COMPOSE_FILE) build

start:
	docker compose -f $(COMPOSE_FILE) start

stop:
	docker compose -f $(COMPOSE_FILE) stop

set_volumes:
	sudo mkdir -p /home/edelanno/data/wordpress
	sudo mkdir -p /home/edelanno/data/mariadb
	sudo chown -R 33:33 /home/edelanno/data/wordpress
	sudo chmod -R 755 /home/edelanno/data/wordpress
	sudo chown -R 999:999 /home/edelanno/data/mariadb
	sudo chmod -R 755 /home/edelanno/data/mariadb

clean:
	if [ -d "/home/edelanno/data/wordpress" ]; then \
	sudo rm -rf /home/edelanno/data/wordpress; \
	fi
	if [ -d "/home/edelanno/data/mariadb" ]; then \
		sudo rm -rf /home/edelanno/data/mariadb; \
	fi
	if [ -d "/home/edelanno/data" ]; then \
		sudo rm -rf /home/edelanno/data; \
	fi
	docker system prune -a --volumes -f
	
fclean: down clean 