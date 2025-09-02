FROM debian:oldstable-slim 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
  php-fpm \
  php-mysql \
  wget \
  unzip \
  && rm -rf /var/lib/apt/lists/*

# WORKDIR /var/www/html

RUN mkdir -p /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.3.1-fr_FR.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/ \
    && mv /var/www/wordpress /var/www/html \
    && rm /tmp/wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html



COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY conf/initdocker.sh  /initdocker.sh
RUN chmod +x /initdocker.sh


EXPOSE 9000

ENTRYPOINT ["/initdocker.sh"]

CMD ["php-fpm8.2", "-F"]

