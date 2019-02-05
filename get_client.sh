#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

cd $(dirname $0)

sudo apt install gedit xsel gnome-screenshot

mkdir -p ~/.quicksave
[[ ! -e ~/.quicksave/venv ]] && python3 -m virtualenv -p python3 ~/.quicksave/venv
. ~/.quicksave/venv/bin/activate
pip3 install git+https://github.com/adiog/io_quicksave_client.git --upgrade

function get_script() {
  SCRIPT=$1
  [[ ! -e ~/.quicksave/bin/${SCRIPT} ]] && wget -O ~/.quicksave/bin/${SCRIPT} https://raw.githubusercontent.com/adiog/io_quicksave_client/master/bin/${SCRIPT}
  chmod +x ~/.quicksave/bin/${SCRIPT}
}

mkdir -p ~/.quicksave/bin
get_script qsarea.sh
get_script qsclip.sh
get_script qsnote.sh

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
