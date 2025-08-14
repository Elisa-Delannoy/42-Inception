FROM debian:12

#WORKDIR srcs/requirements/nginx/

#COPY

RUN apt update && apt install nginx -y
RUN mkdir -p /etc/nginx/ssl && apt install OpenSSL -y && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=OCCITANIE/L=PERPIGNAN/0=42/OU=42/CN=edelanno.42.fr/UID=edelanno"
RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

 

#COPY
# 
#EXPOSE
#
#RUN
#
#USER
#
#CMD
