FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get install -qy autoconf automake build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev yasm cmake mercurial nasm wget make less gcc g++

WORKDIR /opt/ffmpeg_sources

RUN wget -q http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2 && tar -xjf last_x264.tar.bz2 && cd x264-snapshot* && PATH="/opt/ffmpeg/bin:$PATH" ./configure --prefix="/opt/ffmpeg/ffmpeg_build" --bindir="/opt/ffmpeg/bin" --enable-static --disable-opencl && PATH="/opt/ffmpeg/bin:$PATH" make && make install && make distclean

###RUN hg clone https://bitbucket.org/multicoreware/x265 && cd x265/build/linux && PATH="/opt/ffmpeg/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/opt/ffmpeg/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source && make && make install

RUN wget -qO fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master && tar -xzf fdk-aac.tar.gz
RUN cd mstorsjo-fdk-aac* && autoreconf -fiv && ./configure --prefix="/opt/ffmpeg/ffmpeg_build" --disable-shared && make && make install && make distclean

RUN wget -q http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz && tar xzvf lame-3.99.5.tar.gz && cd lame-3.99.5 && ./configure --prefix="/opt/ffmpeg/ffmpeg_build" --enable-nasm --disable-shared && make && make install && make distclean

RUN wget -q http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz && tar xzvf opus-1.1.2.tar.gz && cd opus-1.1.2 && ./configure --prefix="/opt/ffmpeg/ffmpeg_build" --disable-shared && make && make install && make clean

RUN wget -q http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2 && tar -xjf libvpx-1.5.0.tar.bz2 && cd libvpx-1.5.0 && PATH="/opt/ffmpeg/bin:$PATH" ./configure --prefix="/opt/ffmpeg/ffmpeg_build" --disable-examples --disable-unit-tests && PATH="/opt/ffmpeg/bin:$PATH" make && make install && make clean

RUN wget -q http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && tar -xjf ffmpeg-snapshot.tar.bz2
WORKDIR /opt/ffmpeg_sources/ffmpeg
RUN PATH="/opt/ffmpeg/bin:$PATH" PKG_CONFIG_PATH="/opt/ffmpeg/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="/opt/ffmpeg/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I/opt/ffmpeg/ffmpeg_build/include" \
  --extra-ldflags="-L/opt/ffmpeg/ffmpeg_build/lib" \
  --bindir="/opt/ffmpeg/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
###  --enable-libx265 \
  --enable-nonfree
RUN PATH="/opt/ffmpeg/bin:$PATH" make && make install && make distclean && hash -r
VOLUME ["/share"]
ENTRYPOINT ["/opt/ffmpeg/bin/ffmpeg"]

