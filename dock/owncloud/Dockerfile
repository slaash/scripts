FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install apache2 git php5 php5-json php5-gd php5-sqlite curl libcurl3 libcurl4-openssl-dev php5-curl php5-gd php5-cgi php-pear php5-dev build-essential libpcre3-dev php5 libapache2-mod-php5 php5-apcu wget less && apt-get -qy clean

WORKDIR /opt
RUN git clone https://github.com/letsencrypt/letsencrypt
WORKDIR /opt/letsencrypt
RUN ./letsencrypt-auto --help
#RUN /opt/letsencrypt/certbot-auto -n --agree-tos --register-unsafely-without-email --apache -d home777.go.ro

RUN sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
#RUN echo "<IfModule mod_headers.c>\
#  Header always set Strict-Transport-Security \"max-age=15552000; includeSubDomains\"\
#</IfModule>" >> /etc/apache2/sites-available/default-ssl.conf

COPY ./apc.ini /etc/php5/cgi/conf.d/apc.ini
RUN sed -ie 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' /etc/php5/apache2/php.ini
RUN echo 'extension=apcu.so'>>/etc/php5/apache2/php.ini
RUN a2enmod rewrite
RUN a2enmod headers
#COPY ./ssl/server.crt /etc/ssl/certs/
#COPY ./ssl/server.key /etc/ssl/private/
RUN a2enmod ssl && a2ensite default-ssl
WORKDIR /opt
RUN wget --quiet https://download.owncloud.org/community/owncloud-9.1.2.tar.bz2
RUN tar -C /var/www/html -xjf owncloud-9.1.2.tar.bz2
#COPY htaccess /var/www/html/owncloud/.htaccess
RUN chown -R www-data:www-data /var/www/html/owncloud

EXPOSE 80 443

COPY ./*.sh /opt/
COPY ./owncloud.conf /etc/apache2/conf-available/
RUN ln -s /etc/apache2/conf-available/owncloud.conf /etc/apache2/conf-enabled/owncloud.conf

CMD ["/opt/start_apache.sh"]
