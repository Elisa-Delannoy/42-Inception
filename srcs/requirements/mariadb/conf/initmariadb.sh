#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

if [ -d "$DATADIR/mysql" ]; then
  echo "MariaDB already created"
  
  echo "Start mariadb without network"
  mysqld_safe --skip-networking &
  pid=$!
  
  echo "Waiting for mariadb to be ready"
  until mysqladmin ping --silent; do
    sleep 1
  done

  if [! mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE ${MYSQL_DATABASE};" 2>/dev/null]; then
    echo "Database initialisation"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
      CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
      CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
      GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
      FLUSH PRIVILEGES;
EOSQL
  fi
  
  echo "Stop mariadb"
  mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
  wait $pid
  
  echo "Start new mariadb with password and network"
  exec mysqld_safe --datadir="$DATADIR" --skip-name-resolve
fi

echo "Mariadb initialisation"
mysql_install_db --user=mysql --datadir="$DATADIR"

echo "Start mariadb without network"
mysqld_safe --skip-networking &
pid=$!

echo "Waiting for mariadb to be ready"
until mysqladmin ping --silent; do
  sleep 1
done

echo "Database initialisation"
mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
  CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
  CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
  CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
  GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "Stop mariadb"
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
wait $pid

echo "Start new mariadb with password and network"
exec mysqld_safe --datadir="$DATADIR" --skip-name-resolve

