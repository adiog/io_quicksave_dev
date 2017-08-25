#!/bin/bash
# This file is a part of quicksave project.
# Copyright 2017 Aleksander Gajewski <adiog@quicksave.io>.

# use explicit quotation marks for strings, ie.:
# export STRING_VALUE="string"   # optional string comment
# and
# export INT64_VALUE=123         # optional int comment

QUICKSAVE="$(cd $(dirname $0); pwd)"
export QUICKSAVE="${QUICKSAVE}"

export PREFIX="${QUICKSAVE}"
export IO_QUICKSAVE="quicksave.io"

export IO_QUICKSAVE_GIT="https://github.com/adiog"

export PROTOCOL="http"

export IO_QUICKSAVE_API="api.quicksave.io"
export API_QUICKSAVE_IO="${PROTOCOL}://${IO_QUICKSAVE_API}"

export IO_QUICKSAVE_OAUTH="oauth.quicksave.io"
export OAUTH_QUICKSAVE_IO="${PROTOCOL}://${IO_QUICKSAVE_OAUTH}"

export IO_QUICKSAVE_CDN="cdn.quicksave.io"
export CDN_QUICKSAVE_IO="${PROTOCOL}://${IO_QUICKSAVE_CDN}"

export IO_QUICKSAVE_WWW="www.quicksave.io"



export IO_QUICKSAVE_LOCUST="locust.quicksave.io"
export IO_QUICKSAVE_LOCUST_OAUTH="oauth.locust.quicksave.io"
export IO_QUICKSAVE_LOCUST_API="api.locust.quicksave.io"
export IO_QUICKSAVE_LOCUST_CDN="cdn.locust.quicksave.io"



export IO_QUICKSAVE_CPP_DIR="${PREFIX}/cpp"
export IO_QUICKSAVE_CLIENT_DIR="${PREFIX}/client"
export IO_QUICKSAVE_CDN_DIR="${PREFIX}/cdn"
export IO_QUICKSAVE_MEM_DIR="${PREFIX}/memadmin"
export IO_QUICKSAVE_SWAGGER_DIR="${PREFIX}/swagger-editor"
export IO_QUICKSAVE_LOG_DIR="${PREFIX}/logs"
export IO_QUICKSAVE_WWW_DIR="${PREFIX}/www"


export IO_QUICKSAVE_LOCUST_HOST="localhost"   # IP/Hostname to bind to
export IO_QUICKSAVE_LOCUST_PORT=8089          # Port to listen on with HTTP protocol
export IO_QUICKSAVE_LOCUST_API_PORT=11009
export IO_QUICKSAVE_LOCUST_CDN_PORT=12009
export IO_QUICKSAVE_LOCUST_OAUTH_PORT=13009


export IO_QUICKSAVE_API_HOST="0.0.0.0"     # IP/Hostname to bind to
export IO_QUICKSAVE_API_PORT=11000         # Port to listen on with HTTP protocol
export api_threads=0                       # Number of threads to listen on. Numbers <= 0 will use the number of cores on this machine.

export IO_QUICKSAVE_CDN_HOST="0.0.0.0"     # IP/Hostname to bind to
export IO_QUICKSAVE_CDN_PORT=12000         # Port to listen on with HTTP protocol
export cdn_threads=0                       # Number of threads to listen on. Numbers <= 0 will use the number of cores on this machine.

export IO_QUICKSAVE_OAUTH_HOST="0.0.0.0"     # IP/Hostname to bind to
export IO_QUICKSAVE_OAUTH_PORT=13000         # Port to listen on with HTTP protocol
export oauth_threads=0                       # Number of threads to listen on. Numbers <= 0 will use the number of cores on this machine.

export post_threads=0

export IO_QUICKSAVE_SWAGGER="swagger.quicksave.io"
export IO_QUICKSAVE_SWAGGER_HOST="localhost"
export IO_QUICKSAVE_SWAGGER_PORT=3001

export IO_QUICKSAVE_OAUTH_TOKEN_EXPIRE_TIME=3600

export IO_QUICKSAVE_MQ="mq.quicksave.io"
export IO_QUICKSAVE_MQ_HOST="localhost"
export IO_QUICKSAVE_MQ_PORT=5672
export IO_QUICKSAVE_MQ_MANAGE_PORT=15672

export IO_QUICKSAVE_MEMCACHED_HOST="mem.quicksave.io"
export IO_QUICKSAVE_MEMCACHED_PORT="11211"
export IO_QUICKSAVE_MEMCACHED_CONNECTION_STRING="--SERVER=${IO_QUICKSAVE_MEMCACHED_HOST}:${IO_QUICKSAVE_MEMCACHED_PORT}"

export IO_QUICKSAVE_MEMADMIN_PORT=18080

export IO_QUICKSAVE_PLUGIN_DIR="${PREFIX}/plugin-engine"
export IO_QUICKSAVE_LIBBEANS_DIR="${PREFIX}/libbeans"
export IO_QUICKSAVE_QSQL_DIR="${PREFIX}/qsql"
export IO_QUICKSAVE_FUSE_DIR="${PREFIX}/fuse"
export IO_QUICKSAVE_BEANS_DIR="${PREFIX}/beans"

export IO_QUICKSAVE_DB_DIR="${PREFIX}/db"

export IO_QUICKSAVE_DB_MASTER="${IO_QUICKSAVE_DB_DIR}/master.sqlite3"
export IO_QUICKSAVE_MASTER_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_DB_MASTER}"
export IO_QUICKSAVE_DB_SLAVE="${IO_QUICKSAVE_DB_DIR}/slave.sqlite3"
export IO_QUICKSAVE_SLAVE_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_DB_SLAVE}"

export IO_QUICKSAVE_DB_UNITTEST="${IO_QUICKSAVE_DB_DIR}/unittest.sqlite3"
export IO_QUICKSAVE_UNITTEST_DATABASE_CONNECTION_STRING="sqlite://${IO_QUICKSAVE_DB_UNITTEST}"


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

export PYTHONPATH="${IO_QUICKSAVE_PYTHONPATH}"
