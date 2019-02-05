#!/bin/bash
# Copyright 2017 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  wto, 17 paź 2017, 04:48:59
#   modified: Tue 05 Feb 2019 08:31:07 AM CET

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    screen \
    nginx \
    python3 \
    python3-pip \
    python3-virtualenv


#sudo apt-get install -y gcc g++ make zlib1g-dev openssl
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

