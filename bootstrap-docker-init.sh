#!/bin/bash
# Copyright 2019 Aleksander Gajewski <adiog@brainfuck.pl>
#   created:  Tue 05 Feb 2019 08:29:27 AM CET
#   modified: Tue 05 Feb 2019 08:30:47 AM CET

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -a

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo groupadd docker

sudo usermod -aG docker $USER

echo "Reboot/restart/relogin may be needed to enable sudoless docker command.."

