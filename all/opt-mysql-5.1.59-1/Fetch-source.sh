#!/bin/bash

SRC=mysql-5.1.59.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-5.1/$SRC
