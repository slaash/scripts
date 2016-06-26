#!/bin/bash
#sudo apt-get install mingw32-binutils
#git clone git://git.tartarus.org/simon/putty.git
cd putty
git stash
git pull
make -C windows -f Makefile.cyg clean
sed -i 's/-mno-cygwin//g' ./mkfiles.pl
perl mkfiles.pl
sed -i 's/-mno-cygwin//g' ./windows/Makefile.cy
make -C windows XFLAGS=-DCOVERITY VER="-DSNAPSHOT=$(date '+%Y-%m-%d') -DSVN_REV=$(cat LATEST.VER) -DMODIFIED" TOOLPATH=i686-w64-mingw32- -f Makefile.cyg
cp windows/*.exe /share/putty/

