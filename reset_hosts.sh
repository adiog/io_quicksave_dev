#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

if ! grep -q quicksave.io /etc/hosts;
then
    echo 127.0.0.1 quicksave.io api.quicksave.io oauth.quicksave.io cdn.quicksave.io | sude tee -a /etc/hosts
else
    echo /etc/hosts already set
fi
