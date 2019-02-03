#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

# use explicit quotation marks for strings, ie.:
# export STRING_VALUE="string"   # optional string comment
# and
# export INT64_VALUE=123         # optional int comment

QUICKSAVE="${1:-$(cd $(dirname $0); pwd)}"
export QUICKSAVE="${QUICKSAVE}"

export QUICKSAVE_PREFIX="/"
export IO_QUICKSAVE="quicksave.io"

export IO_QUICKSAVE_GIT="https://github.com/adiog"
export IO_QUICKSAVE_CERT_DIR="${QUICKSAVE}/cert"
export IO_QUICKSAVE_CLIENT_DIR="${QUICKSAVE}/client"

export IO_QUICKSAVE_API="api.quicksave.io"
export HTTPS_API_QUICKSAVE_IO="https://${IO_QUICKSAVE_API}"
export IO_QUICKSAVE_LOCUST="locust.quicksave.io"
export IO_QUICKSAVE_LOCUST_OAUTH="oauth.locust.quicksave.io"
export IO_QUICKSAVE_LOCUST_API="api.locust.quicksave.io"
export IO_QUICKSAVE_LOCUST_CDN="cdn.locust.quicksave.io"
export IO_QUICKSAVE_OAUTH="oauth.quicksave.io"
export IO_QUICKSAVE_BOOT="boot.quicksave.io"
export IO_QUICKSAVE_MQ="mq.quicksave.io"
export IO_QUICKSAVE_CDN="cdn.quicksave.io"
export IO_QUICKSAVE_LOG="log.quicksave.io"
export IO_QUICKSAVE_WWW="www.quicksave.io"

export HTTPS_OAUTH_QUICKSAVE_IO="https://${IO_QUICKSAVE_OAUTH}"
export HTTPS_CDN_QUICKSAVE_IO="https://${IO_QUICKSAVE_CDN}"

export IO_QUICKSAVE_API_DIR="/io.quicksave.api"
export IO_QUICKSAVE_CDN_DIR="/io.quicksave.cdn"
export IO_QUICKSAVE_MEM_DIR="/io.quicksave.bootstrap/memadmin"
export IO_QUICKSAVE_SWAGGER_DIR="/io.quicksave.bootstrap/swagger-editor"
export IO_QUICKSAVE_LOG_DIR="/io.quicksave.log"
export IO_QUICKSAVE_WWW_DIR="/io.quicksave.www"
export IO_QUICKSAVE_BOOT_DIR="${QUICKSAVE}/boot"

export IO_QUICKSAVE_CPPAPI_DIR="/io.quicksave.cppapi"

export IO_QUICKSAVE_LOCUST_HOST="localhost"   # IP/Hostname to bind to
export IO_QUICKSAVE_LOCUST_PORT=8089          # Port to listen on with HTTP protocol
export IO_QUICKSAVE_LOCUST_OAUTH_PORT=13009
export IO_QUICKSAVE_LOCUST_API_PORT=11009
export IO_QUICKSAVE_LOCUST_CDN_PORT=12009


export IO_QUICKSAVE_API_HOST="localhost"   # IP/Hostname to bind to
export IO_QUICKSAVE_API_PORT=11000         # Port to listen on with HTTP protocol
export api_threads=0                       # Number of threads to listen on. Numbers <= 0 will use the number of cores on this machine.
export api_spdy_port=11001                 # Port to listen on with SPDY protocol (not used)
export api_h2_port=11002                   # Port to listen on with HTTP/2 protocol (not used)

export IO_QUICKSAVE_CDN_HOST="localhost"   # IP/Hostname to bind to
export IO_QUICKSAVE_CDN_PORT=12000         # Port to listen on with HTTP protocol
export cdn_threads=0                       # Number of threads to listen on. Numbers <= 0 will use the number of cores on this machine.
export cdn_spdy_port=12001                 # Port to listen on with SPDY protocol (not used)
export cdn_h2_port=12002                   # Port to listen on with HTTP/2 protocol (not used)

export IO_QUICKSAVE_OAUTH_HOST="localhost"   # IP/Hostname to bind to
export IO_QUICKSAVE_OAUTH_PORT=13000         # Port to listen on with HTTP protocol
export oauth_threads=0                       # Number of threads to listen on. Numbers <= 0 will use the number of cores on this machine.
export oauth_spdy_port=11001                 # Port to listen on with SPDY protocol (not used)
export oauth_h2_port=11002                   # Port to listen on with HTTP/2 protocol (not used)

export post_threads=0

export IO_QUICKSAVE_SWAGGER="swagger.quicksave.io"
export IO_QUICKSAVE_SWAGGER_HOST="localhost"
export IO_QUICKSAVE_SWAGGER_PORT=3001

export IO_QUICKSAVE_OAUTH_TOKEN_EXPIRE_TIME=3600

export IO_QUICKSAVE_MQ_HOST="localhost"
export IO_QUICKSAVE_MQ_PORT=15672

export IO_QUICKSAVE_MEMCACHED_HOST="127.0.0.1"
export IO_QUICKSAVE_MEMCACHED_PORT="11211"
export IO_QUICKSAVE_MEMCACHED_CONNECTION_STRING="--SERVER=${IO_QUICKSAVE_MEMCACHED_HOST}:${IO_QUICKSAVE_MEMCACHED_PORT}"

export IO_QUICKSAVE_MEMADMIN_PORT=18080

export IO_QUICKSAVE_LOG_HOST="localhost"
export IO_QUICKSAVE_LOG_PORT=9009

export IO_QUICKSAVE_PLUGIN_DIR="${QUICKSAVE}/plugin-engine"
export IO_QUICKSAVE_LIBBEANS_DIR="${QUICKSAVE}/libbeans"
export IO_QUICKSAVE_QSQL_DIR="${QUICKSAVE}/qsql"
export IO_QUICKSAVE_FUSE_DIR="${QUICKSAVE}/fuse"
export IO_QUICKSAVE_BEANS_DIR="${QUICKSAVE}/beans"

export IO_QUICKSAVE_DB_DIR="/io.quicksave.db"

#export IO_QUICKSAVE_DB_MASTER="${IO_QUICKSAVE_DB_DIR}/master.sqlite3"
#export IO_QUICKSAVE_MASTER_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_DB_MASTER}"
#export IO_QUICKSAVE_DB_SLAVE="${IO_QUICKSAVE_DB_DIR}/slave.sqlite3"
#export IO_QUICKSAVE_SLAVE_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_DB_SLAVE}"


export IO_QUICKSAVE_DB_UNITTEST="${IO_QUICKSAVE_DB_DIR}/unittest.sqlite3"
export IO_QUICKSAVE_UNITTEST_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_DB_UNITTEST}"



# MASTER DATABASE
export MASTER_HOST="master.quicksave.io"
export MASTER_PORT=5432

# PRIMARY SLAVE DATABASE
export SLAVE_HOST="slave.quicksave.io"
export SLAVE_PORT=5433

export IO_QUICKSAVE_MASTER_DATABASE_CONNECTION_STRING="postgres://host=${MASTER_HOST} port=${MASTER_PORT} user=postgres"
export IO_QUICKSAVE_SLAVE_DATABASE_CONNECTION_STRING="postgres://host=${SLAVE_HOST} port=${SLAVE_PORT} user=postgres"


export IO_QUICKSAVE_LOCUST_DATABASE="${IO_QUICKSAVE_DB_DIR}/locust.sqlite3"
export IO_QUICKSAVE_LOCUST_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_LOCUST_DATABASE}"
export IO_QUICKSAVE_LOCUST_USER_MIN=1000
export IO_QUICKSAVE_LOCUST_USER_MAX=1099

export IO_QUICKSAVE_PYTHONPATH="${IO_QUICKSAVE_LIBBEANS_DIR}:${IO_QUICKSAVE_LIBBEANS_DIR}/pybeans/:${IO_QUICKSAVE_PLUGIN_DIR}:${IO_QUICKSAVE_PLUGIN_DIR}/pyengine:${IO_QUICKSAVE_PLUGIN_DIR}/pyasync"

export IO_QUICKSAVE_LOG_PYTHON="${IO_QUICKSAVE_LOG_DIR}/python.log"
export IO_QUICKSAVE_LOG_SERVER="${IO_QUICKSAVE_LOG_DIR}/server.log"

export STORAGE_DEFAULT_HOST="localhost"
export STORAGE_DEFAULT_PORT="2222"
export STORAGE_DEFAULT_KEY="default"

export IO_QUICKSAVE_STORAGE_PORT=2222

export IO_QUICKSAVE_PATH="/io.quicksave.bootstrap/plugin-engine/lib/"
