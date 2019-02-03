#!/bin/bash
# Copyright 2019 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  Sun 03 Feb 2019 09:22:21 AM CET
#   modified: Sun 03 Feb 2019 09:22:32 AM CET

# BASH CLEANUP {{{
# PRIVATE:
BASH_TMPDIR=/dev/shm/
BASH_MKTEMP="mktemp --tmpdir=$BASH_TMPDIR"
BASH_CLEANUP_FILE=`$BASH_MKTEMP`
trap BASH_CLEANUP EXIT

function BASH_CLEANUP() {
  tac $BASH_CLEANUP_FILE | bash
  rm $BASH_CLEANUP_FILE
}

# PUBLIC:
function FINALLY() {
  echo "$*" >> $BASH_CLEANUP_FILE
}

function MKTEMP() {
  BASH_TMP=`$BASH_MKTEMP`
  FINALLY "rm $BASH_TMP"
  echo $BASH_TMP
}

function MKTEMP_DIR() {
  BASH_TMP=`$BASH_MKTEMP -d`
  FINALLY "rm -fr $BASH_TMP"
  echo $BASH_TMP
}
# }}}

docker stop $(docker ps -aq)
sudo killall screen
