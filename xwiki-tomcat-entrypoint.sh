#!/bin/bash
set -e

cd /usr/local/tomcat/webapps/ROOT

sed -i "s/POSTGRES_INSTANCE/${POSTGRES_INSTANCE}/g" WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_PORT/${POSTGRES_PORT}/g" WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_DB/${POSTGRES_DB}/g" WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_USER/${POSTGRES_USER}/g" WEB-INF/hibernate.cfg.xml
sed -i "s/POSTGRES_PASSWORD/${POSTGRES_PASSWORD}/g" WEB-INF/hibernate.cfg.xml

#L. Dubost PR #2, add personalised distribution Id
if [ -f META-INF/extension.xed ]; then
  sed -i "s/<id>org.xwiki.enterprise:xwiki-enterprise-web/<id>org.xwiki.enterprise:xwiki-enterprise-docker-zwindler/" META-INF/extension.xed
fi

cd /usr/local/tomcat
bin/catalina.sh run
