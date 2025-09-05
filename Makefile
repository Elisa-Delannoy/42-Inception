COMPOSE_FILE=./srcs/docker-compose.yml

down:
	docker compose -f $(COMPOSE_FILE) down -v

build:
	docker compose -f $(COMPOSE_FILE) up --build

set_volumes:
	mkdir -p /home/edelanno/data/wordpress
	mkdir -p /home/edelanno/data/mariadb
	sudo chown -R edelanno:edelanno /home/edelanno/data/wordpress
	sudo chown -R edelanno:edelanno /home/edelanno/data/mariadb
	sudo chmod 755 /home/edelanno/data/wordpress
	sudo chmod 755 /home/edelanno/data/mariadb


clean:
	sudo rm -rf /home/edelanno/data/wordpress
	sudo rm -rf /home/edelanno/data/mariadb

fclean: down clean

rebuild: fclean all