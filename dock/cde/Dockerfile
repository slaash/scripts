FROM debian:testing

RUN apt-get -q update && apt-get -qy install procps git build-essential libxt-dev libxmu-dev libxft-dev libxinerama-dev libxpm-dev libxm4 libmotif-dev libxaw7-dev libx11-dev libxss-dev libtirpc-dev x11-xserver-utils libjpeg62-turbo-dev libfreetype6-dev libssl-dev tcl-dev ksh m4 ncompress xfonts-100dpi xfonts-100dpi-transcoded rpcbind bison xbitmaps
WORKDIR /opt
RUN git clone --depth 1 git://git.code.sf.net/p/cdesktopenv/code cdesktopenv-code
WORKDIR /opt/cdesktopenv-code/cde
RUN make World
ENV LD_LIBRARY_PATH /opt/cdesktopenv-code/cde/exports/lib
WORKDIR /opt/cdesktopenv-code/cde/admin/IntegTools/dbTools
RUN ./installCDE -s /opt/cdesktopenv-code/cde/
WORKDIR /opt/cdesktopenv-code/cde/admin/IntegTools/post_install/linux
RUN ./configRun -e
RUN chmod -R a+rwx /var/dt
RUN mkdir -p /usr/spool/calendar
