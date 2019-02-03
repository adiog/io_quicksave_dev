#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

notify-send "quicksave.io\nmemcached running on localhost:${IO_QUICKSAVE_MEMCACHED_PORT}..."
docker rm mem_quicksave_docker
docker run \
    --name mem_quicksave_docker \
    --expose 11211 \
    -p ${IO_QUICKSAVE_MEMCACHED_PORT}:11211 \
    --net network_quicksave_docker \
    -it memcached
