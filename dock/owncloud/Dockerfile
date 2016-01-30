FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install apache2 php5 php5-json php5-gd php5-sqlite curl libcurl3 libcurl4-openssl-dev php5-curl php5-gd php5-cgi php-pear php5-dev build-essential libpcre3-dev php5 libapache2-mod-php5 php-apc wget less && apt-get -qy clean
#RUN pecl install apc
COPY ./apc.ini /etc/php5/cgi/conf.d/apc.ini
RUN sed -ie 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' /etc/php5/apache2/php.ini
RUN echo 'extension=apc.so'>>/etc/php5/apache2/php.ini
RUN a2enmod rewrite
RUN a2enmod headers
RUN openssl genrsa -des3 -out server.key 1024 && openssl rsa -in server.key -out server.key.insecurexx && openssl req -new -key server.key -out server.csr && openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt && cp server.crt /etc/ssl/certs && cp server.key /etc/ssl/private && a2enmod ssl && a2ensite default-ssl
WORKDIR /opt
RUN wget --quiet https://download.owncloud.org/community/owncloud-8.2.2.tar.bz2
RUN tar -C /var/www -xjf owncloud-8.2.2.tar.bz2
RUN echo 'php_value post_max_size 2000M'>/var/www/owncloud/.htaccess
RUN chown -R www-data:www-data /var/www/owncloud


