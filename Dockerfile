FROM debian:buster

ENV AUTOINDEX on

RUN apt update && apt-get upgrade -y && apt-get -y install wget \
	nginx \
	mariadb-server \
	php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

COPY ./srcs/nginx.conf /etc/nginx/sites-available/wordpress

WORKDIR /var/www/html/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz

RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz

RUN mv phpMyAdmin-5.0.1-english phpmyadmin

COPY ./srcs/config.inc.php /var/www/html/phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

COPY ./srcs/wp-config.php /var/www/html/wordpress

RUN openssl req -x509 -nodes -days 365 -subj "/C=IT/ST=Italy/L=Rome/O=Center/OU=42rome/CN=forhjy" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

EXPOSE 80 443

#RUN chown -R www-data:www-data *

#RUN chmod -R 755 /var/www/*

WORKDIR /./

COPY ./srcs/init.sh ./

CMD bash init.sh
