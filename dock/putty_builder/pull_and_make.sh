#!/bin/bash

cd /opt/putty
git pull
sed -i 's/-mno-cygwin//g' ./mkfiles.pl
perl mkfiles.pl
make -C windows -f Makefile.cyg clean
make -C windows XFLAGS=-DCOVERITY VER="-DSNAPSHOT=$(date '+%Y-%m-%d') -DSVN_REV=$(cat LATEST.VER) -DMODIFIED" TOOLPATH=i686-w64-mingw32- -f Makefile.cyg
/opt/copy_files.sh

