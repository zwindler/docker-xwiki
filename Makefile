build:
	docker build -t zwindler/xwiki-tomcat9:latest .

dockercompose:
	docker-compose -f compose/docker-compose.yml up -d

bridge:
	docker network create -d bridge xwiki-bridge

runpgsql:
	docker run --net=xwiki-bridge -itd --name xwiki-postgres -e POSTGRES_DB=xwiki -e POSTGRES_USER=xwiki -e POSTGRES_PASSWORD=xwiki postgres

runxwiki:
	docker run --net=xwiki-bridge -itd --name xwiki-tomcat -p 8080:8080 -e POSTGRES_INSTANCE=xwiki-postgres -e POSTGRES_PASSWORD=xwiki zwindler/xwiki-tomcat8
