OBSOLETE : don't use this project / image, there are official docker images provided by XWiki team


## Introduction

The goal of this project is to provide a customized tomcat10 container for XWiki (KMDB) in Docker containers

## Prerequisite 

### Build dependancies

This project uses Docker, containers, the XWiki in its "war file" form and the latest postgreSQL JDBC driver (available from the Internet). So this XWiki setup is preconfigured to use a PostgreSQL database, preferably from a docker container as well.

### Run dependancies

A postgreSQL database accessible with hostname (or container name) in variable "POSTGRES_INSTANCE=mydbcontainername" (see later)

## Deploy

To install, you have two solutions

### Using Docker only

  * (optional) `docker build -t zwindler/xwiki-tomcat9:latest .` #Only if you get it from source
  * `docker network create -d bridge xwiki-bridge`
  * `docker run --net=xwiki-bridge -itd --name xwiki-postgres -e POSTGRES_DB=xwiki -e POSTGRES_USER=xwiki -e POSTGRES_PASSWORD=xwiki postgres`
  * `docker run --net=xwiki-bridge -itd --name xwiki-tomcat -p 8080:8080 -e POSTGRES_INSTANCE=xwiki-postgres zwindler/xwiki-tomcat9`
				
### Using Docker-Compose

YAML docker-compose file is provided in the github repository. This automated all the previous commands. You can modify the docker-compose.yml file to change variables like container names or (more importantly) usernames and passwords.

  * In detached mode `docker-compose -f compose/docker-compose.yml up -d`
  * To see the logs from both containers in current terminal `docker-compose -f compose/docker-compose.yml up`
  * To build image from compose ` docker-compose -f compose/docker-compose.yml build`  

Note : Future releases will include a .env file to set your variables (more convenient).

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

Example : 

`docker build --build-arg XWIKI_VERSION=7.4.4 -t zwindler/xwiki-tomcat9:7.4.4 .
docker run --net=xwiki-bridge -itd --name xwiki-tomcat -p 8080:8080 -e POSTGRES_INSTANCE=xwiki-postgres zwindler/xwiki-tomcat9:7.4.4`
