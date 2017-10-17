#!/bin/bash
# Copyright 2017 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  wto, 17 paź 2017, 04:48:59
#   modified: wto, 17 paź 2017, 05:06:22

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

if echo "grep -q `whoami` /etc/sudoers" | sudo bash;
then
    if echo "egrep -q \"`whoami`.*NOPASSWD\" /etc/sudoers" | sudo bash;
    then
        echo "suicidal mode already in place"
    else
        echo "sed -e \"s#.*`whoami`.*#`whoami` ALL=(ALL) NOPASSWD:ALL#\" -i /etc/sudoers" | sudo bash
        echo "suicidal mode enabled"
    fi
else
    echo "`whoami` ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers;
    echo "suicidal mode created"
fi
        
