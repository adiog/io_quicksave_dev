# quicksave

## DEMO

Demo Requirements
-----------------
- screen
- docker
- python3.6 and virtualenv
- nginx

What is the impact on the host system?
--------------------------------------
Demo is intended to be run locally, so the following /etc/hosts entries should be placed:
```
127.0.0.1 api.quicksave.io cdn.quicksave.io oauth.quicksave.io www.quicksave.io quicksave.io
```
These changes will be automatically made by ./bootstrap.sh script.

Additionally the nginx sites associated with these domains will be registered. By default the following ports will be used:
```
8080 ~ quicksave.io
11000 ~ api.quicksave.io
12000 ~ cdn.quicksave.io
13000 ~ oauth.quicksave.io
```

The configuration can be found under **https://github.com/adiog/io_quicksave_dev/tree/master/etc**

Bootstrapping demo
------------------
Just run:
```
$ ./bootstrap.sh
```
WARNING: sudo will be used with each container (you may have to check all 10 screen sessions!).

Using demo
----------
- The default user (*testuser*/*testpass*) will be created.
- Open a browser and simply go to *quicksave.io*
- If you are using Firefox install extension from: *https://addons.mozilla.org/en-US/firefox/addon/quicksave-io/*
- If you are using Chrome you may manually "Load unpacked extension" from *https://github.com/adiog/io_quicksave_chrome/archive/master.zip*

Command line tool
-----------------
If you do not want to pollute your python environment activate virtualenv:
```
. ~/.quicksave/venv/bin/activate
```
The command line tool *qs* will be added to your PATH:
```
$ qs --text \"do homework\"
$ qs --file VeryImportant.pdf
$ qs --clipboard
$ qs --screenshot
$ qs --input
```
Please mind that some additional dependancies are implied (e.g. gnome-screenshot, gedit, xsel).
The configuration file can be found under:
```
~/.quicksave/quicksave.ini
```
If you want to bind a *qs* command to a keyboard shortcut, you may use the *--gui* switch for a credentials prompt. E.g.:
```
qs --gui --area
```
The default session length is set to 1 hour.

QSQL queries
------------
Currently the basic filtering can be done only with QSQL, the syntax is straighforward:
```
WHERE name = 'exact match'
WHERE name ~ 'pattern'
WHERE tag 'yourtag'
WHERE ((name ~ 'Screenshot') OR (tag 'funpic'))
```
Note: excessive parenthesis are currently mandatory.


## Design notes

Overview
--------
'quicksave system' provides an easy-access online 'database'.

'objects' can have a different form:
- freetext (selection, content of clipboard etc.)
- file (pdf, image, screenshot, etc.)
- link to online resource (page, image, media, etc.)
etc.

the actual behaviour of creating and retrieving objects is determined by configurable set of plugins.

Object passing
--------------

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

*Note: the single plugin-engine repository is deprecated. The following ones will be used io_quicksave_api-ext (safe python), io_quicksave_async (unsafe python), io_quicksave_www (javascript).*

browser plugin / social API / bookmarklet
-----------------------------------------
browser integration.

chrome plugin can be found in **[chrome plugin repository](https://github.com/adiog/io_quicksave_chrome)**
firefox plugin can be found in **[firefox plugin repository](https://github.com/adiog/io_quicksave_firefox)**

Firefox Add-on has been already published under **[firefox plugin](https://addons.mozilla.org/en-US/firefox/addon/quicksave-io/)**

command line client
-------------------
python-based command line client and explorer integration.

cli client can be found in **[cli client repository](https://github.com/adiog/io_quicksave_client)**



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

