FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install apache2 php5 php5-json php5-gd php5-sqlite curl libcurl3 libcurl4-openssl-dev php5-curl php5-gd php5-cgi php-pear php5-dev build-essential libpcre3-dev php5 libapache2-mod-php5 php5-apcu wget less && apt-get -qy clean
COPY ./apc.ini /etc/php5/cgi/conf.d/apc.ini
RUN sed -ie 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' /etc/php5/apache2/php.ini
RUN echo 'extension=apcu.so'>>/etc/php5/apache2/php.ini
RUN a2enmod rewrite
RUN a2enmod headers
COPY ./ssl/server.crt /etc/ssl/certs/
COPY ./ssl/server.key /etc/ssl/private/
RUN a2enmod ssl && a2ensite default-ssl
WORKDIR /opt
RUN wget --quiet https://download.owncloud.org/community/owncloud-8.2.2.tar.bz2
RUN tar -C /var/www/html -xjf owncloud-8.2.2.tar.bz2
RUN chown -R www-data:www-data /var/www/html/owncloud

EXPOSE 80 443

COPY ./start.sh /opt/start.sh

CMD ["/opt/start.sh"]
