FROM docker.uberresearch.com/python_base:3.5.3
MAINTAINER Radu Moisa <radu@uberresearch.com>

# Install basic packages
RUN apt-get -qq update && apt-get install -y libffi-dev libssl-dev
RUN pip install -U pip && pip install uwsgi

# Set working directory
WORKDIR /pack/app

# Setup application
RUN pip install -e .

# Fix permissions
RUN chown -R app:app .

# Set user
USER app

CMD ["uwsgi","development.ini"]

