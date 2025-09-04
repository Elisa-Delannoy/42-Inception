#!/bin/bash

set -e

echo "Waiting for mariadb"
until mysqladmin ping -h "mariadb" --silent; do
  sleep 3
done

cd /var/www/html/wordpress

wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb \
    --allow-root

wp core install \
    --url=https://edelanno.42.fr \
    --title="42-INCEPTION" \
    --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --allow-root

wp user create \
  $WP_USER \
  $WP_USER_EMAIL \
  --role=author \
  --user_pass=$WP_USER_PASSWORD \
  --allow-root

exec /usr/sbin/php-fpm8.2 -F
