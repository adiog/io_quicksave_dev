#!/usr/bin/env bash

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

VENV_DIR=`BASH_MKTEMP_DIR`/venv

virtualenv -p python3.6 ${VENV_DIR}

. ${VENV_DIR}/bin/activate

pip install git+https://github.com/adiog/io_quicksave_audit-server --upgrade

qs-audit-server runserver
