#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

cat Dockerfile.in | envsubst > Dockerfile
docker build --no-cache -t quicksave/test-async .
rm Dockerfile
