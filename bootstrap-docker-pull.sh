#!/bin/bash
# Copyright 2019 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  Tue 05 Feb 2019 08:30:07 AM CET
#   modified: Tue 05 Feb 2019 08:30:57 AM CET

docker pull rabbitmq
docker pull memcached
docker pull quicksave/test-async
docker pull quicksave/test-post
docker pull quicksave/test-oauth
docker pull quicksave/test-cdn
docker pull quicksave/test-api
docker pull quicksave/test-storage
docker pull quicksave/www
docker pull quicksave/memadmin

