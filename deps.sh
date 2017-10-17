#!/bin/bash
# Copyright 2017 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  wto, 17 paź 2017, 04:48:59
#   modified: wto, 17 paź 2017, 04:58:26

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

sudo apt-get install screen

sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install \
      apt-transport-https \
          ca-certificates \
              curl \
                  software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
sudo apt-key fingerprint 0EBFCD88
    
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
           stable"
   

sudo apt-get update
sudo apt-get install docker-ce
   
git clone https://github.com/python/cpython \
      && cd cpython \
          && git checkout 3.6 \
              && ./configure \
                  && make -j 4 \
                      && sudo make install \
                          && cd .. \
                              && rm -fr cpython
sudo apt install python3-virtualenv

sudo apt install nginx

