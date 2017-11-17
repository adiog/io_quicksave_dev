#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

function init_queues()
{
  sleep 5
  wget http://localhost:${IO_QUICKSAVE_MQ_MANAGE_PORT}/cli/rabbitmqadmin
  chmod +x rabbitmqadmin
  ./rabbitmqadmin declare queue name=request durable=false
  ./rabbitmqadmin declare queue name=response durable=false
  rm rabbitmqadmin
  notify-send "quicksave.io\nrabbitmq running on localhost:${IO_QUICKSAVE_MQ_PORT}...\nweb: http://localhost:${IO_QUICKSAVE_MQ_MANAGE_PORT} (guest:guest)"
}

init_queues &
sudo docker rm mq_quicksave_docker
sudo docker run \
    --name mq_quicksave_docker \
    --expose 5672 \
    --expose 15672 \
    --net network_quicksave_docker \
    -p 5672:5672 \
    -p 15672:15672 \
    rabbitmq:management \
|| ./bin/qs-audit fatal "rabbit-mq crashed"
