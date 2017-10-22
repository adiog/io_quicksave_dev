#!/usr/bin/env bash

cd $(dirname $0)/..

VENV_DIR=./venv

[[ ! -e ${VENV_DIR} ]] && virtualenv -p python3.6 ${VENV_DIR}

. ${VENV_DIR}/bin/activate

pip install git+https://github.com/adiog/io_quicksave_pybeans --upgrade
pip install git+https://github.com/adiog/io_quicksave_async --upgrade

wget -O bin/qs-audit https://raw.githubusercontent.com/adiog/io_quicksave_audit-server/master/cli/qs-audit

qs-async || ./bin/qs-audit fatal "quicksave async crashed"
