#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

. ./env.sh

sudo docker network rm network_quicksave_docker
sudo docker network create network_quicksave_docker

screen -d -m -S memcached bash -l -c docker/memcached/docker.bootstrap.sh
screen -d -m -S rabbitmq bash -l -c docker/rabbitmq/docker.bootstrap.sh


