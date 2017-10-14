#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

[[ ! -e venv ]] && virtualenv -p python3.6 venv
. venv/bin/activate
pip3 install git+https://github.com/adiog/io_quicksave_client.git --upgrade

echo
qs -h
sed -e "s/https/http/g" -i ~/.quicksave/quicksave.ini
echo

echo "Enable virtualenv with:"
echo "$ . venv/bin/activate"
echo "And use qs command to add items."
echo
echo "Examples:"
echo "$ qs --text \"Do the homework\""
echo "$ qs --file VeryImportant.pdf"
echo "$ qs --clipboard"
echo "$ qs --screenshot"
echo
echo "Open http://quicksave.io in your web browser"
echo
echo "Consider using a web browser plugin (firefox/chrome)"
echo
echo "Default credentials are \"testuser\" / \"testpass\""
