#!/bin/bash

# Fichier: requirements/wordpress/docker-entrypoint.sh

# Si WordPress n'est pas encore installé (vérifie si le wp-config.php est là)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."

    wp core download --locale=fr_FR --path=/var/www/html --allow-root

    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --path=/var/www/html \
        --allow-root

    wp core install \
        --url=https://edelanno.42.fr \
        --title="Mon Site WordPress" \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path=/var/www/html \
        --skip-email \
        --allow-root

    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
fi

exec "$@"
