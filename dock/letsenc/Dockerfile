FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install git
RUN mkdir -p /var/www/html/example
WORKDIR /opt
RUN git clone https://github.com/letsencrypt/letsencrypt
WORKDIR /opt/letsencrypt
#RUN ./letsencrypt-auto certonly --webroot -w /var/www/html/example -d example.com
#RUN ./letsencrypt-auto --help
#RUN letsencrypt --apache -d example.com
