#!/bin/bash

SRCVER=grep-2.6.3
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install pcre-8.02-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-1 --prefix=/usr || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
