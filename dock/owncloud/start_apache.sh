#!/bin/bash

export APACHE_CONFDIR=/etc/apache2
source $APACHE_CONFDIR/envvars

/usr/sbin/apache2 -k start -e info -DFOREGROUND
