#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

sudo docker rm async_quicksave_docker
sudo docker run \
    --privileged \
        --name async_quicksave_docker \
        --net network_quicksave_docker \
        -it quicksave/test-async
