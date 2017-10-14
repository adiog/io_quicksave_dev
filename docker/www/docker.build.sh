#!/usr/bin/env bash

[[ ! -d ./io_quicksave_www/ ]] && git clone --recursive https://github.com/adiog/io_quicksave_www
./io_quicksave_www/bootstrap.sh
sed -e "s/https/http/g" -i ./io_quicksave_www/js/env.js
#find . -name .git -type d -exec rm -fr {} \;

cat Dockerfile.in | envsubst > Dockerfile
sudo docker build -t quicksave/www .
rm Dockerfile

