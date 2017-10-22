#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

echo "ACHTUNG!: screen in the background will run sudo command"
echo "          either start processes manually or put a NOPASSWD: into sudoers file"

sudo docker network rm network_quicksave_docker
sudo docker network create network_quicksave_docker

screen -d -m -S qs-audit bash -l -c bin/spawn_audit.sh

screen -d -m -S qs-www bash -l -c docker/www/docker.run.sh

screen -d -m -S qs-memcached bash -l -c docker/memcached/docker.bootstrap.sh
screen -d -m -S qs-memadmin bash -l -c docker/memadmin/docker.run.sh
screen -d -m -S qs-rabbitmq bash -l -c docker/rabbitmq/docker.bootstrap.sh

sleep 3

screen -d -m -S qs-async bash -l -c docker/async/docker.run.sh

screen -d -m -S qs-storage bash -l -c docker-cpp/0-storage.sh

sleep 3

screen -d -m -S qs-api bash -l -c docker-cpp/0-api.sh
screen -d -m -S qs-cdn bash -l -c docker-cpp/0-cdn.sh
screen -d -m -S qs-oauth bash -l -c docker-cpp/0-oauth.sh
screen -d -m -S qs-post bash -l -c docker-cpp/0-post.sh

sleep 3

screen -ls
