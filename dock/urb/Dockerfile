FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install ca-certificates git build-essential libgmp3-dev libsigsegv-dev openssl libssl-dev libncurses5-dev git make exuberant-ctags automake autoconf libtool g++ ragel cmake re2c vim less net-tools && apt-get -qy clean
WORKDIR /opt
RUN git clone git://github.com/urbit/urbit.git
WORKDIR /opt/urbit
RUN make
RUN useradd -m urbit
USER urbit
#RUN bin/urbit -c mycomet

