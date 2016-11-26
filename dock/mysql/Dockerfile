FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install mysql-server less

EXPOSE 3306

CMD ["mysqld"]
