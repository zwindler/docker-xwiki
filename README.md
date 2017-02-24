## Introduction

The goal of this project is to provide a customized tomcat8 container for Xwiki (KMDB) in Docker containers

[![](https://images.microbadger.com/badges/version/zwindler/xwiki-tomcat8.svg)](http://microbadger.com/images/zwindler/xwiki-tomcat8) [![](https://images.microbadger.com/badges/image/zwindler/xwiki-tomcat8.svg)](http://microbadger.com/images/zwindler/xwiki-tomcat8)

## Prerequisite 

### Build dependancies

This project uses Docker, containers, XWiki war file and JDBC driver (available from the Internet). This XWiki setup is preconfigured to use a PostgreSQL database, preferably from a docker container as well.

### Run dependancies

A postgreSQL database accessible with hostname (or container name) in variable "POSTGRES_INSTANCE=mydbcontainername" (see later)

## Deploy

To install, you have two solutions

### Using Docker only

  * (optional) `docker build -t zwindler/xwiki-tomcat8:latest .` #Only if you get it from source
  * `docker network create -d bridge xwiki-nw`
  * `docker run --net=xwiki-nw -itd --name xwiki-postgres -e POSTGRES_DB=xwiki -e POSTGRES_USER=xwiki -e POSTGRES_PASSWORD=xwiki postgres`
  * `docker run --net=xwiki-nw -itd --name xwiki-tomcat -p 8080:8080 -e POSTGRES_INSTANCE=xwiki-postgres zwindler/xwiki-tomcat8`
				
### Using Docker-Compose

YAML docker-compose file is provided in the github repository. This automated all the previous commands

  * `docker-compose up -d`

### Variables at run time

Most important
  * `POSTGRES_INSTANCE`: highly recommended unless you have named your database container `xwiki-postgres` (default setting)

The rest mostly depends on what you used on the database container (or not) setup
  * `POSTGRES_DB`: by default `xwiki`
  * `POSTGRES_USER`: by default `xwiki`
  * `POSTGRES_PASSWORD`: by default `xwiki`. You might (should) want to change this.
	
## Test it!

URL : http://[serveur]:[port]

Example : <http://localhost:8080>

## Building

### Variables at building time

You can now customise your image by building it with the following variables :

  * `XWIKI_VERSION` : you can set the version downloaded during docker image build. Ex : `9.1-rc-1`
  * `PGSQL_JDBC_VERSION` : you can set the version downloaded during docker image build. Ex : `postgresql-42.0.0`
