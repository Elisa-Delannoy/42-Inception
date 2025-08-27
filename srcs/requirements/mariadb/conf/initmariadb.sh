#!/bin/bash
set -e

DATADIR="/var/lib/mysql"

if [ -d "$DATADIR/mysql" ] && [ -f "$DATADIR/mysql/user.frm" ]; then
  echo "✅ MariaDB déjà initialisé, lancement normal..."
  exec mysqld_safe
fi


echo "🔧 Lancement de l'initialisation MariaDB..."

mysqld_safe --skip-networking &
pid=$!

echo "⏳ Attente de MariaDB..."
until mysqladmin ping --silent; do
  sleep 1
done

echo "✅ Connexion OK. Configuration..."

# On crée / modifie root sans mot de passe (car c'est le tout début)
mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
  FLUSH PRIVILEGES;
EOSQL

# Maintenant on peut se reconnecter avec le mot de passe root
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
  CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
  GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "🛑 Arrêt temporaire de MariaDB..."
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "🚀 Relance de MariaDB en premier plan..."
exec mysqld_safe
