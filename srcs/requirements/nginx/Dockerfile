FROM debian:12

RUN apt update && apt install nginx -y

RUN mkdir -p /etc/nginx/tls && apt install openssl -y \
    && openssl req -x509 -nodes -out /etc/nginx/tls/inception.certif \
    -keyout /etc/nginx/tls/inception.key \
    -subj "/C=FR/ST=OCCITANIE/L=PERPIGNAN/0=42/OU=42/CN=edelanno.42.fr/UID=edelanno"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html;
RUN chown -R www-data:www-data /var/www/html;

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 443
