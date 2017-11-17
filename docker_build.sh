#!/bin/bash
# Copyright 2017 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  nie, 22 paź 2017, 19:06:23
#   modified: nie, 22 paź 2017, 19:09:21

(
  cd ../io_quicksave_cpp/docker/0-dev
    ./0-dev-0-ubuntu/docker.build.sh
    ./0-dev-1-proxygen/docker.build.sh
    ./0-dev-2-antlr/docker.build.sh
    ./0-dev-3-python36/docker.build.sh
    ./0-dev-4-ssh/docker.build.sh
    ./0-dev-5-curl/docker.build.sh
)
(
  cd ../io_quicksave_cpp/docker/1-bin
  ./docker_build.sh
)
(
  cd ../io_quicksave_cpp/docker/2-test
  ./2-test-0-storage/docker.build.sh
  ./2-test-1-api/docker.build.sh
  ./2-test-2-cdn/docker.build.sh
  ./2-test-3-oauth/docker.build.sh
  ./2-test-4-post/docker.build.sh
)
./docker/async/docker.build.sh
