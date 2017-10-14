#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

mkdir -p docker-cpp

wget -O docker-cpp/0-storage.sh https://raw.githubusercontent.com/adiog/io_quicksave_cpp/master/docker/2-test/2-test-0-storage/docker.run.sh
wget -O docker-cpp/0-api.sh https://raw.githubusercontent.com/adiog/io_quicksave_cpp/master/docker/2-test/2-test-1-api/docker.run.sh
wget -O docker-cpp/0-cdn.sh https://raw.githubusercontent.com/adiog/io_quicksave_cpp/master/docker/2-test/2-test-2-cdn/docker.run.sh
wget -O docker-cpp/0-oauth.sh https://raw.githubusercontent.com/adiog/io_quicksave_cpp/master/docker/2-test/2-test-3-oauth/docker.run.sh
wget -O docker-cpp/0-post.sh https://raw.githubusercontent.com/adiog/io_quicksave_cpp/master/docker/2-test/2-test-4-post/docker.run.sh

chmod +x docker-cpp/*