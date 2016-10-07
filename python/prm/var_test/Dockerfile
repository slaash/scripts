FROM docker.uberresearch.com/python_base:3.5.3
MAINTAINER Radu Moisa <radu@uberresearch.com>

# Install basic packages

RUN apt-get -qq update && apt-get install -y libffi-dev libssl-dev golang git apt-transport-https

COPY docker.list /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN apt-get -qq update && apt-get install -y docker-engine

RUN pip install -U pip && pip install uwsgi

RUN mkdir /opt/go
ENV GOPATH /opt/go
ENV PATH $GOPATH/bin:$PATH
ENV TERM=linux
RUN go get -u github.com/coreos/clair/contrib/analyze-local-images

# Set working directory
WORKDIR /pack/app

# Setup application
RUN pip install -e .

# Fix permissions
#RUN chown -R app:app .
#RUN usermod -G docker -a app

# Set user
#USER app

CMD ["uwsgi","development.ini"]

