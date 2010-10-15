#!/bin/bash

export INFORMIXSERVER=$1
echo "Informix server: $INFORMIXSERVER"

export INFORMIXDIR=/opt/IBM/informix
export PATH=$INFORMIXDIR/bin:$PATH
export ONCONFIG=$INFORMIXSERVER
oninit
onstat

