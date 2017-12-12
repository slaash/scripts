FROM ubuntu:latest
# xhost + 
# $ docker run -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/radu/Music:/mnt --device /dev/snd --ipc=host slaash/audacity audacity

RUN apt-get -q update && apt-get -qy install software-properties-common && add-apt-repository -yu ppa:ubuntuhandbook1/audacity && apt-get -qy install audacity libcanberra-gtk-module && apt-get -q clean

ENV DISPLAY :0

CMD audacity
