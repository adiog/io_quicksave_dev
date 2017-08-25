#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

. ./env.sh

echo "ACHTUNG!: screen in the background will run sudo command"
echo "          either start processes manually or put a NOPASSWD: into sudoers file"

sudo docker network rm network_quicksave_docker
sudo docker network create network_quicksave_docker

screen -d -m -S memcached bash -l -c docker/memcached/docker.bootstrap.sh
screen -d -m -S memadmin bash -l -c docker/memadmin/docker.run.sh
screen -d -m -S rabbitmq bash -l -c docker/rabbitmq/docker.bootstrap.sh


