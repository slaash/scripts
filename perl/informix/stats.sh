#!/bin/bash

export INFORMIXSERVER="test"
echo "Informix server: $INFORMIXSERVER"

export INFORMIXDIR=/opt/IBM/informix
export PATH=$INFORMIXDIR/bin:$PATH
export ONCONFIG=$INFORMIXSERVER
onstat
oncheck -ce

export INFORMIXSERVER="demo_on"
echo "Informix server: $INFORMIXSERVER"

export INFORMIXDIR=/opt/IBM/informix
export PATH=$INFORMIXDIR/bin:$PATH
export ONCONFIG=$INFORMIXSERVER
onstat
oncheck -ce

