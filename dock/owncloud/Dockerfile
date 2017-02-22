FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install apache2 git php5 php5-json php5-intl php5-mcrypt php5-imagick php5-gd php5-sqlite php5-mysql php5-curl php5-memcached curl libcurl3 libcurl4-openssl-dev php5-curl php5-gd php5-cgi php-pear php5-dev build-essential libpcre3-dev php5 libapache2-mod-php5 php5-apcu wget less nano sudo

WORKDIR /opt
RUN git clone https://github.com/letsencrypt/letsencrypt
WORKDIR /opt/letsencrypt
RUN ./letsencrypt-auto --help

RUN sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

COPY ./apc.ini /etc/php5/cgi/conf.d/apc.ini
RUN sed -ie 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' /etc/php5/apache2/php.ini
RUN echo 'extension=apcu.so'>>/etc/php5/apache2/php.ini
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl && a2ensite default-ssl
WORKDIR /opt
RUN wget --quiet https://download.owncloud.org/community/owncloud-9.1.2.tar.bz2
RUN tar -C /var/www/html -xjf owncloud-9.1.2.tar.bz2
RUN chown -R www-data:www-data /var/www/html/owncloud

EXPOSE 80 443

COPY ./*.sh /opt/
COPY ./owncloud.conf /etc/apache2/conf-available/
RUN ln -s /etc/apache2/conf-available/owncloud.conf /etc/apache2/conf-enabled/owncloud.conf

CMD ["/opt/start_apache.sh"]
