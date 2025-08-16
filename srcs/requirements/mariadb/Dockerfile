FROM debian:12

RUN apt update && apt install mariadb-server -y


COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/initmariadb.sh  /initmariadb.sh
RUN chmod +x /initmariadb.sh

EXPOSE 3306

CMD ["/initmariadb.sh"]
# CMD ["mysqld"]

# ENV MARIADB_ROOT_PASSWORD=""
# ENV SQL_DATABASE=;
# ENV SQL_USER=;
# ENV SQL_PASSWORD=;
# ENV SQL_ROOT_PASSWORD=;

ENV MYSQL_DATABASE=ma_base
ENV MYSQL_USER=mon_user
ENV MYSQL_PASSWORD=mon_mdp
ENV MYSQL_ROOT_PASSWORD=mon_pwd_root



# RUN

# USER

# CMD
