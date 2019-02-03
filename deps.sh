#!/bin/bash
# Copyright 2017 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  wto, 17 paź 2017, 04:48:59
#   modified: Sun 03 Feb 2019 10:39:28 AM CET

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

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    screen \
    nginx \
    python3.6 \
    python3-pip \
    python3-virtualenv

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -a

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo groupadd docker

sudo usermod -aG docker $USER
sudo apt-get install -y screen


sudo apt-get install -y gcc g++ make zlib1g-dev openssl
#export CC=gcc
#export CXX=g++
#git clone https://github.com/python/cpython \
#    && cd cpython \
#    && git checkout 3.6 \
#    && ./configure \
#    && make -j 4 \
#    && sudo make install \
#    && cd .. \
#    && rm -fr cpython
sudo apt install -y virtualenv python3-virtualenv

sudo apt install -y nginx

