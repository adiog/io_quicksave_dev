Overview
========
'quicksave system' provides an easy-access online 'database'.

'objects' can have a different form:
- freetext (selection, content of clipboard etc.)
- file (pdf, image, screenshot, etc.)
- link to online resource (page, image, media, etc.)
etc.

the actual behaviour of creating and retrieving objects is determined by configurable set of plugins.

Object passing
==============

Bean stands here for an serializable object satisfying a json signature.

Bean objects used by system can be found in **[beans repository](https://github.com/adiog/io_quicksave_beans)**.

**[libbeans repository](https://github.com/adiog/io_quicksave_libbeans)** provides a collection of generators and libraries:
- python module
- c++ headers
- c++ bean generator
- c++ database generator (currently sqlite)
- sql generator ('create migration')

Components
==========

www
---
static files. html, javascript and css

main dependencies:
- jquery
- semantic-ui

other dependencies
- mathjax
- prettyprint

www component can be found in **[www repository](https://github.com/adiog/io_quicksave_www)**

qsql
----
quicksave query language. c++, python and javascript parsers

main dependencies:
- antlr

qsql component can be found in **[qsql repository](https://github.com/adiog/io_quicksave_qsql)**

api / oauth / cdn
-----------------
c++ backend.

main dependencies:
- proxygen
- rapidjson
- sqlite/postgres

backend components can be found in **[cppapi repository](https://github.com/adiog/io_quicksave_cpp)**

remark: oauth does not do actual OAuth v2 protocol. It simply authenticates the user and emits a token / creates the token/session/context entry in global memcached service.

post
----
c++ backend collecting the tasks from python async via rabbitmq queue.

dependencies:
- rabbitmq-c

remark: this component is intentionally extracted to prevent QM Python code from directly accessing a db.


EXPERIMENTAL fuse adapter
-------------------------
simple c++ adpater exposing the result of QSQL query directly as static in-memory fuse filesystem.

plugin-engine
-------------
python-based plugin execution framework.

consisted of three main components:
- syncronous engine (initial plugin execution; detect type; determine longer tasks)
- asynchronous engine (longer tasks - e.g. getting thumbnail, backuping resources etc.)
- javascript front-end (presentation layer)

plugin-engine component can be found in **[plugin-engine repository](https://github.com/adiog/io_quicksave_plugin-engine)**

chrome-plugin / social API / bookmarklet
----------------------------------------
browser integration.

chrome plugin can be found in **[chrome plugin repository](https://github.com/adiog/io_quicksave_www/tree/master/client-chrome)**

Fortunately, recently, Firefox has been adapted to modern browser extension API, and the same chrome plugin can be loaded by Firefox 56+ **[firefox plugin repository](https://github.com/adiog/io_quicksave_www/tree/master/client-firefox)**

command line client
-------------------
python-based command line client and explorer integration.

cli client can be found in **[cli client repository](https://github.com/adiog/io_quicksave_client)**


WARNING
=======

If you would consider building/running it: it should be possible. I have tested in on VM with Ubuntu LTS. Keep in mind that building proxygen requires at least 4GB of ram. After successful compilation you should run each component separately (api/oauth/cdn/pyasync/post/rabbitmq/memcached assuming sqlite backend), than you should fix the nginx/hosts (www-component can be served in a static way). Whole operation is a pain in the spine, but possible.

Architecture
============
![alt text](https://github.com/adiog/io_quicksave_dev/raw/master/doc/Architecture.png "quicksave.io Architecture")

Bottlenecks
===========

- master database (used once on authentication)
- memcached (one instance - cannot be replaced by a raw copy)
- rabbitmq

Horizontal scaling
==================

other components thanks to independance can be used without any restriction on number of instances.

User owned parts
================

every user should provide his own database and storage service. of course all metadata can be store in a single database, but this is not a constraint. Currently there are only two storage variants supported: local and sshfs. it can be easily extend to cover gdrive/dropbox. There is no GUI for signups. But feel free to test it locally.

CreateRequest
=============
![alt text](https://github.com/adiog/io_quicksave_dev/raw/master/doc/CreateRequest.png "quicksave.io CreateRequest")

Bootstrapping
=============
Configuration is propagated from env.sh.

./bootstrap.sh loads env.sh

- ./api
- ./cdn
- ./oauth
are using googleflags, ie. to pass env variable use:
- IO_QUICKSAVE_API_HOST=80 ./api --fromenv=IO_QUICKSAVE_API_HOST
or directly
- ./api --IO_QUICKSAVE_API_HOST=80
