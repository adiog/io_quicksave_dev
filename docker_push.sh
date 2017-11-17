#!/bin/bash
# Copyright 2017 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  nie, 22 paź 2017, 19:06:23
#   modified: nie, 22 paź 2017, 19:09:21

# BASH_CLEANUP {{{
BASH_CLEANUP_FILE=`mktemp`
trap BASH_CLEANUP EXIT

function BASH_CLEANUP() {
  BASH_CLEANUP_FILE_REV=`mktemp`
  tac $BASH_CLEANUP_FILE > $BASH_CLEANUP_FILE_REV
  . $BASH_CLEANUP_FILE_REV
  rm $BASH_CLEANUP_FILE $BASH_CLEANUP_FILE_REV
}

function BASH_FINALLY() {
  echo "$*" >> $BASH_CLEANUP_FILE
}

function BASH_MKTEMP() {
  BASH_TMP=`mktemp`
  echo "rm $BASH_TMP" >> $BASH_CLEANUP_FILE
  echo $BASH_TMP
}

function BASH_MKTEMP_DIR() {
  BASH_TMP=`mktemp -d`
  echo "rm -fr $BASH_TMP" >> $BASH_CLEANUP_FILE
  echo $BASH_TMP
}
# }}}

for d in \
  dev-ubuntu \
  dev-proxygen \
  dev-antlr \
  dev-python36 \
  dev-ssh \
  dev-curl \
  bin \
  test-storage \
  test-api \
  test-cdn \
  test-oauth \
  test-post \
  test-async \
  www;
do
  sudo docker push quicksave/$d;
done

