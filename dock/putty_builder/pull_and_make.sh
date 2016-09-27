#!/bin/bash

cd /opt/putty
git pull
#git fetch --tags
#git checkout $(git tag|sort -rn|head -1)
#sed -i 's/-mno-cygwin//g' ./mkfiles.pl
perl mkfiles.pl
make -C windows -f Makefile.mgw clean
make -C windows XFLAGS=-DCOVERITY VER="-DSNAPSHOT=$(date '+%Y-%m-%d') -DSVN_REV=$(cat LATEST.VER) -DMODIFIED" TOOLPATH=i686-w64-mingw32- -f Makefile.mgw
/opt/copy_files.sh

