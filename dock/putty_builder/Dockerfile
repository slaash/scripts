FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install gcc-mingw-w64-i686 mingw32-binutils git make && apt-get -qy clean
WORKDIR /opt
RUN git clone git://git.tartarus.org/simon/putty.git
WORKDIR /opt/putty
RUN sed -i 's/-mno-cygwin//g' ./mkfiles.pl
RUN perl mkfiles.pl
RUN make -C windows -f Makefile.cyg clean
RUN make -C windows XFLAGS=-DCOVERITY VER="-DSNAPSHOT=$(date '+%Y-%m-%d') -DSVN_REV=$(cat LATEST.VER) -DMODIFIED" TOOLPATH=i686-w64-mingw32- -f Makefile.cyg
