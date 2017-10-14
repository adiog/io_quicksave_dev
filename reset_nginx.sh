#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

function setup_nginx_host()
{
    echo "Setting $1.."
    HOST_FILE=$1
    NGINX_HOSTFILE=/etc/nginx/sites-enabled/$HOST_FILE
    cat ./etc/nginx/sites-available/${HOST_FILE} | sudo tee ${NGINX_HOSTFILE} > /dev/null
}

for host_file in etc/nginx/sites-available/*;
do
    setup_nginx_host $(basename $host_file)
done

sudo service nginx restart
