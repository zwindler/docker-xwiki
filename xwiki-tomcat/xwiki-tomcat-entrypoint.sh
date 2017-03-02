#!/bin/bash
set -e

cd /usr/local/tomcat

sed -i "s/POSTGRES_INSTANCE/${POSTGRES_INSTANCE}/g" webapps/ROOT/WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_PORT/${POSTGRES_PORT}/g" webapps/ROOT/WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_DB/${POSTGRES_DB}/g" webapps/ROOT/WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_USER/${POSTGRES_USER}/g" webapps/ROOT/WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_PASSWORD/${POSTGRES_PASSWORD}/g" webapps/ROOT/WEB-INF/hibernate.cfg.xml

#L. Dubost PR #2, add personalised distribution Id
sed -i "s/<id>org.xwiki.enterprise:xwiki-enterprise-web/<id>org.xwiki.enterprise:xwiki-enterprise-docker-zwindler/" webapps/ROOT/META-INF/extension.xed

bin/catalina.sh run
