#!/bin/bash

SRC=wget-1.15.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/wget/$SRC || wget -O $DST http://ftp.gnu.org/gnu/wget/$SRC
