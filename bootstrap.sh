#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

#./deps.sh

. ./env.sh

./get_starting_scripts.sh

./run.sh

./reset_hosts.sh
./reset_nginx.sh

./get_client.sh
