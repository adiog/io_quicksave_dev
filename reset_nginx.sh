#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

if [[ -z "${QUICKSAVE}" ]];
then
    echo "Load environment variables first!"
    exit 1
fi

function setup_nginx_host()
{
    echo $1
    HOST_FILE=$1
    NGINX_HOSTFILE=/etc/nginx/sites-enabled/$HOST_FILE
    cat ${PREFIX}/etc/nginx/sites-available/$HOST_FILE | sed -e 's#\\\$#${DoLLaR}#g'| DoLLaR=$ envsubst | sudo tee $NGINX_HOSTFILE > /dev/null
}

#[[ ! -e ${IO_QUICKSAVE_CERT_DIR}/${IO_QUICKSAVE}.crt ]] && ./nginx_https.sh ${IO_QUICKSAVE} ${IO_QUICKSAVE_CERT_DIR}

for host_file in etc/nginx/sites-available/*;
do
    setup_nginx_host $(basename $host_file)
done

sudo service nginx restart
