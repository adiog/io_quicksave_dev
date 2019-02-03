#!/usr/bin/env bash

notify-send "quicksave.io\nmemcached admin running...\nweb: http://localhost:${IO_QUICKSAVE_MEMADMIN_PORT}\ncred: (admin:admin)\ncon: mem_quicksave_docker:${IO_QUICKSAVE_MEMCACHED_PORT}"
echo docker run --net network_quicksave_docker -p ${IO_QUICKSAVE_MEMADMIN_PORT}:80 -it quicksave/memadmin
docker run --net network_quicksave_docker -p ${IO_QUICKSAVE_MEMADMIN_PORT}:80 -it quicksave/memadmin
