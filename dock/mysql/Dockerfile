FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

ENV TERM linux

RUN echo 'mysql-server mysql-server/root_password password toor' | debconf-set-selections
RUN echo 'mysql-server mysql-server/root_password_again password toor' | debconf-set-selections

RUN apt-get -q update && apt-get -qy install mysql-server debconf less nano net-tools

RUN sed -i "s/^bind\-address.*/bind-address = 0.0.0.0/g" /etc/mysql/my.cnf

VOLUME /var/lib/mysql
EXPOSE 3306

CMD ["mysqld"]
