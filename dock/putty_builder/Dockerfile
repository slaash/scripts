FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install gcc-mingw-w64-i686 git make && apt-get -qy clean
WORKDIR /opt
RUN git clone git://git.tartarus.org/simon/putty.git
WORKDIR /opt/putty
COPY ./pull_and_make.sh /opt/
COPY ./copy_files.sh /opt/
VOLUME ["/build"]
ENTRYPOINT ["/opt/pull_and_make.sh"]
