FROM sdhibit/rpi-raspbian:latest

RUN apt-get -qy update && apt-get -qy install unzip curl npm nodejs
RUN curl -k -L -o master.zip https://github.com/afaqurk/linux-dash/archive/master.zip
RUN unzip master.zip
WORKDIR linux-dash-master
RUN npm install

CMD ["nodejs","server"]
