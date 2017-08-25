#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

ENV=${1:-env.sh}

cd $(dirname $0)

. ${ENV}

USER=`whoami`

function verbose()
{
    [[ -n "${VERBOSE}" ]] && read
}

function clone_dep()
{
    DEP_GIT=$1
    DEP_DIR=$2
    echo "# Clone ${DEP_GIT} into ${DEP_DIR}..."
    if [[ ! -e ${DEP_DIR} ]];
    then
        git clone --recursive ${DEP_GIT} ${DEP_DIR}
    else
        (cd ${DEP_DIR} && git pull)
    fi
    echo "# ... clone ${DEP_GIT} into ${DEP_DIR} [DONE]"
    verbose
}

function apt()
{
    sudo apt install python3 python3-dev xvfb certbot rabbitmq-server
    sudo apt install memcached libmemcached11 libmemcached-dev libmemcached-tools php-memcached php-fpm
    sudo apt install libmagic-dev
}

function pip()
{
    sudo pip3 install pillow pika python-oauth2
    sudo pip3 install python-memcached
    sudo pip3 install python-libmagic
}

function env2in()
{
    mkdir -p tmp/trash
    cat env.sh | grep -e "^export" | sed -e "s| *#.*$||" > tmp/trash/env.in
    cat env.sh | grep -e "^export [^=]*=\"" > tmp/trash/env_string.in
    cat env.sh | grep -e "^export [^=]*=[^\"]" > tmp/trash/env_int.in
}

function env2js()
{
    (
    echo '// This file is an AUTOGENERATED part of quicksave project.'
    echo '// Copyright (c) 2017 Aleksander Gajewski <adiog@quicksave.io>.'
    echo ''
    echo 'const env = {'
    cat tmp/trash/env.in  | sed -e "s#export \([^=]*\)=\"\?\([^\"]*\)\"\?#  \1: '\2',#" | sed -e "1s/,$//" | tac | envsubst
    echo '};'
    ) > tmp/env.js
}

function env2py()
{
    (
    echo '# This file is an AUTOGENERATED part of quicksave project.'
    echo '# Copyright (c) 2017 Aleksander Gajewski <adiog@quicksave.io>.'
    echo ''
    echo 'import os'
    echo ''
    echo ''
    cat tmp/trash/env_string.in | sed -e "s|export \([^=]*\)=\"\([^\"]*\)\" *#* *\(.*\)|\1 = os.environ.get('\1', '\2')|" | envsubst
    cat tmp/trash/env_int.in | sed -e "s|export \([^=]*\)=\([0-9]*\) *#* *\(.*\)|\1 = int(os.environ.get('\1', '\2'))|" | envsubst
    ) > tmp/env.py
}

function env2cpp()
{
    (
    echo '// This file is an AUTOGENERATED part of quicksave project.'
    echo '// Copyright (c) 2017 Aleksander Gajewski <adiog@quicksave.io>.'
    echo ''
    echo '#ifndef QUICKSAVE_ENV_H'
    echo '#define QUICKSAVE_ENV_H'
    echo ''
    echo '#include <gflags/gflags.h>'
    echo ''
    cat tmp/trash/env_string.in | sed -e "s|export \([^=]*\)=\"\([^\"]*\)\" *#* *\(.*\)|DEFINE_string(\1, \"\2\", \"\3\");|" | envsubst
    cat tmp/trash/env_int.in | sed -e "s|export \([^=]*\)=\([0-9]*\) *#* *\(.*\)|DEFINE_int64(\1, \2, \"\3\");|" | envsubst
    echo ''
    echo '#endif'
    ) > tmp/env.h
}

function compile_proxygen()
{
    PROXYGEN=$1
    if [[ ! -e ${PROXYGEN}/proxygen/libtool ]];
    then
        ${PROXYGEN}/proxygen/deps.sh
    fi
}

function create_master_db()
{
    echo "# Create DB ..."
    if [[ ! -e ${IO_QUICKSAVE_DB_MASTER} ]];
    then
        sudo mkdir -p ${IO_QUICKSAVE_DB_DIR}
        sudo chown ${USER} ${IO_QUICKSAVE_DB_DIR}
        ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/create_database_master_postgres_create_scripts.sh ${IO_QUICKSAVE_DB_MASTER}
        ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/insert_user.sh ${IO_QUICKSAVE_DB_MASTER} ${USER} "pass"
    fi
    verbose
}

function create_locust_db()
{
    echo "# Create locust DB ..."
    if [[ ! -e ${IO_QUICKSAVE_LOCUST_DATABASE} ]];
    then
        sudo mkdir -p ${IO_QUICKSAVE_DB_DIR}
        sudo chown ${USER} ${IO_QUICKSAVE_DB_DIR}
        ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/create_master_database.sh ${IO_QUICKSAVE_LOCUST_DATABASE}
        for uid in `seq ${IO_QUICKSAVE_LOCUST_USER_MIN} ${IO_QUICKSAVE_LOCUST_USER_MAX}`;
        do
            ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/insert_user.sh ${IO_QUICKSAVE_LOCUST_DATABASE} "u${uid}" "p${uid}"
        done
    fi
    verbose
}

function create_unittest_db()
{
    echo "# Create DB ..."
    if [[ ! -e ${IO_QUICKSAVE_DB_UNITTEST} ]];
    then
        sudo mkdir -p ${IO_QUICKSAVE_DB_DIR}
        sudo chown ${USER} ${IO_QUICKSAVE_DB_DIR}
        ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/create_slave_database.sh ${IO_QUICKSAVE_DB_UNITTEST}
        ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/insert_user.sh ${IO_QUICKSAVE_DB_UNITTEST} ${USER} "pass"
    fi
    verbose
}

function create_slave_db()
{
    echo "# Create DB ..."
    if [[ ! -e ${IO_QUICKSAVE_DB_SLAVE} ]];
    then
        sudo mkdir -p ${IO_QUICKSAVE_DB_DIR}
        sudo chown ${USER} ${IO_QUICKSAVE_DB_DIR}
        ${IO_QUICKSAVE_LIBBEANS_DIR}/sqlbeans/create_slave_database.sh ${IO_QUICKSAVE_DB_SLAVE}
    fi
    verbose
}


function io_quicksave_www()
{
    #clone_dep ${IO_QUICKSAVE_GIT}/io_quicksave_www ${IO_QUICKSAVE_WWW_DIR}
    [[ ! -e ${IO_QUICKSAVE_CPPAPI_DIR}/shared/qsql ]] && ln -fs ${IO_QUICKSAVE_PLUGIN_DIR}/js ${IO_QUICKSAVE_WWW_DIR}/js/plugin
    [[ ! -e ${IO_QUICKSAVE_WWW_DIR}/js/generated/JsBeans.js ]] && ln -fs ${IO_QUICKSAVE_LIBBEANS_DIR}/jsbeans/jsbeans.js ${IO_QUICKSAVE_WWW_DIR}/js/generated/JsBeans.js
    ${IO_QUICKSAVE_LIBBEANS_DIR}/jsbeans/bootstrap.sh ${IO_QUICKSAVE_BEANS_DIR} ${IO_QUICKSAVE_WWW_DIR}
    verbose
    ${IO_QUICKSAVE_QSQL_DIR}/jsqsql/bootstrap.sh ${IO_QUICKSAVE_WWW_DIR}
    verbose
    cp tmp/env.js ${IO_QUICKSAVE_WWW_DIR}/js/env.js
    cp tmp/env.js ${IO_QUICKSAVE_WWW_DIR}/client-chrome/env.js
}

function io_quicksave_api()
{

    verbose
    mkdir -p ${IO_QUICKSAVE_CPPAPI_DIR}/shared/
    verbose

    ${IO_QUICKSAVE_QSQL_DIR}/cppqsql/bootstrap.sh ${IO_QUICKSAVE_CPPAPI_DIR}
    verbose
    [[ ! -e ${IO_QUICKSAVE_CPPAPI_DIR}/shared/qsql ]] && ln -fs ${IO_QUICKSAVE_QSQL_DIR}/cppqsql/include ${IO_QUICKSAVE_CPPAPI_DIR}/shared/qsql
    verbose

    ${IO_QUICKSAVE_LIBBEANS_DIR}/cppbeans/bootstrap.sh ${IO_QUICKSAVE_BEANS_DIR} ${IO_QUICKSAVE_CPPAPI_DIR}
    verbose
    #${IO_QUICKSAVE_LIBBEANS_DIR}/cppbeans/bootstrap_postgres.sh ${IO_QUICKSAVE_BEANS_DIR} ${IO_QUICKSAVE_CPPAPI_DIR} User Meta Tag File Action Key
    ${IO_QUICKSAVE_LIBBEANS_DIR}/cppbeans/bootstrap_sqlite.sh ${IO_QUICKSAVE_BEANS_DIR} ${IO_QUICKSAVE_CPPAPI_DIR} User Meta Tag File Action Key
    verbose

    [[ ! -e ${IO_QUICKSAVE_CPPAPI_DIR}/shared/libbeans ]] && ln -fs ${IO_QUICKSAVE_LIBBEANS_DIR}/cppbeans/include ${IO_QUICKSAVE_CPPAPI_DIR}/shared/libbeans
    verbose

    [[ ! -e ${IO_QUICKSAVE_CPPAPI_DIR}/shared/plugin-engine ]] && ln -fs ${IO_QUICKSAVE_PLUGIN_DIR}/include ${IO_QUICKSAVE_CPPAPI_DIR}/shared/plugin-engine
    verbose

    cp tmp/env.h ${IO_QUICKSAVE_CPPAPI_DIR}/generated/env.h
}


function swagger_get_definitions()
{
    mkdir -p tmp/swagger_spec/definitions
    for f in ${IO_QUICKSAVE_BEANS_DIR}/*.json;
    do
        JSON_FILE=$(basename ${f})
        YAML_FILE=${JSON_FILE/.json/.yaml}
        python3 ${IO_QUICKSAVE_LIBBEANS_DIR}/swagger/generate_swagger_yaml.py ${IO_QUICKSAVE_BEANS_DIR} ${JSON_FILE} > tmp/swagger_spec/definitions/${YAML_FILE}
    done
}

function swagger_cat_definitions()
{
    SWAGGER_SOURCE=$1
    shift 1
    BEANS_AS_DEFINITIONS=$*

    if [[ -z "${BEANS_AS_DEFINITIONS}" ]];
    then
        BEANS_AS_DEFINITIONS=`ls ${IO_QUICKSAVE_BEANS_DIR}`
    fi

    mkdir -p ${IO_QUICKSAVE_SWAGGER_DIR}/spec-files
    (
        cat swagger_source/${SWAGGER_SOURCE}.head
        echo ""
        echo "definitions:"
        for JSON_FILE in ${BEANS_AS_DEFINITIONS};
        do
            YAML_FILE=${JSON_FILE/.json/.yaml}
            cat tmp/swagger_spec/definitions/${YAML_FILE}
        done
    ) | tee tmp/swagger_spec/${SWAGGER_SOURCE} > ${IO_QUICKSAVE_SWAGGER_DIR}/spec-files/${SWAGGER_SOURCE}

    # explicitly add swagger file as default hardcoded example
    sed -n -e "/${SWAGGER_SOURCE}/!p" -i ${IO_QUICKSAVE_SWAGGER_DIR}/config/*
    sed -e "s|.*exampleFiles.*|&\n    \"${SWAGGER_SOURCE}\",|" -i ${IO_QUICKSAVE_SWAGGER_DIR}/config/*
}

function swagger_editor()
{
    swagger_get_definitions
    #clone_dep https://github.com/swagger-api/swagger-editor ~/github/swagger-editor
    #clone_dep ~/github/swagger-editor ${IO_QUICKSAVE_SWAGGER_DIR}
    (cd ${IO_QUICKSAVE_SWAGGER_DIR} && git checkout v2.10.5)
    swagger_cat_definitions api_quicksave_io.yaml
    swagger_cat_definitions cdn_quicksave_io.yaml
    swagger_cat_definitions oauth_quicksave_io.yaml Token.json TokenRequest.json
    #(cd ${IO_QUICKSAVE_SWAGGER_DIR} && npm install)
}

function rabbitmq()
{
    sudo rabbitmq-plugins enable rabbitmq_management
    WEB_USER=guest
    WEB_PASS=guest
    WEB_MANAGEMENT=http://localhost:15672/
    PORT=5672
}

mkdir -p tmp
env2in
env2js
env2cpp
env2py

clone_dep ${IO_QUICKSAVE_GIT}/io_quicksave_beans ${IO_QUICKSAVE_BEANS_DIR}
clone_dep ${IO_QUICKSAVE_GIT}/io_quicksave_fuse ${IO_QUICKSAVE_FUSE_DIR}
clone_dep ${IO_QUICKSAVE_GIT}/io_quicksave_qsql ${IO_QUICKSAVE_QSQL_DIR}
clone_dep ${IO_QUICKSAVE_GIT}/libbeans ${IO_QUICKSAVE_LIBBEANS_DIR}
clone_dep ${IO_QUICKSAVE_GIT}/plugin-engine ${IO_QUICKSAVE_PLUGIN_DIR}
clone_dep https://github.com/junstor/memadmin ${IO_QUICKSAVE_MEM_DIR}
clone_dep ${IO_QUICKSAVE_GIT}/io_quicksave_cppapi ${IO_QUICKSAVE_CPPAPI_DIR}

export PROXYGEN_DIR=${PREFIX}/proxygen
clone_dep https://github.com/facebook/proxygen ${PROXYGEN_DIR}
compile_proxygen ${PROXYGEN_DIR}

exit
io_quicksave_api

swagger_editor
#clone_dep ${IO_QUICKSAVE_GIT}/io_quicksave_client ${IO_QUICKSAVE_CLIENT_DIR}
cp tmp/env.py ${IO_QUICKSAVE_CLIENT_DIR}/env.py
cp tmp/env.py ${IO_QUICKSAVE_CPPAPI_DIR}/oauth_stress/env.py
cp tmp/env.py ${IO_QUICKSAVE_CPPAPI_DIR}/api_stress/env.py
cp tmp/env.py ${IO_QUICKSAVE_PLUGIN_DIR}/pyengine/env.py

cp tmp/env.py docker/api/env.py
cp tmp/env.py docker/pyasync/env.py

#{
io_quicksave_www
#//create_master_db
#create_locust_db
#create_slave_db
#create_unittest_db

${IO_QUICKSAVE_LIBBEANS_DIR}/pybeans/bootstrap.sh ${IO_QUICKSAVE_BEANS_DIR} ${IO_QUICKSAVE_PLUGIN_DIR}/pyengine Tag Meta File Action Item Key Message CreateRequest InternalCreateRequest BackgroundTask DatabaseTask



${QUICKSAVE}/reset_nginx.sh

if ! grep -q quicksave.io /etc/hosts;
then
    sudo echo 127.0.0.1 quicksave.io api.quicksave.io log.quicksave.io cdn.quicksave.io >> /etc/hosts
else
    echo /etc/hosts already set
fi

#(cd ${IO_QUICKSAVE_API_DIR} && cmake ${IO_QUICKSAVE_CPPAPI_DIR} && make -j 4)

