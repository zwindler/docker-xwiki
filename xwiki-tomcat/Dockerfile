FROM tomcat:8-jre8
MAINTAINER Denis GERMAIN <dt.germain@gmail.com> 
ENV POSTGRES_INSTANCE=xwiki-pgsql POSTGRES_PORT=5432 /
    POSTGRES_DB=xwiki POSTGRES_USER=xwiki /
    POSTGRES_PASSWORD=xwiki XWIKI_VERSION=9.0

COPY setenv.sh bin/setenv.sh
COPY xwiki-tomcat-entrypoint.sh /

RUN sed -i "s/redirectPort=\"8443\" /redirectPort=\"8443\" URIEncoding=\"UTF-8\" /" conf/server.xml

RUN rm -rf webapps/* && \
    curl -L \
      'http://download.forge.ow2.org/xwiki/xwiki-enterprise-web-${XWIKI_VERSION}.war' \
       -o xwiki.war && \
    unzip -d webapps/xwiki xwiki.war && \
    rm -f xwiki.war

RUN curl -L \
      'https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar' \
      -o 'webapps/xwiki/WEB-INF/lib/postgresql-9.4-1212.jdbc42.jar' && \
    echo "environment.permanentDirectory=/usr/local/tomcat/work/xwiki" >> webapps/xwiki/WEB-INF/xwiki.properties

COPY hibernate.cfg.xml webapps/xwiki/WEB-INF/
COPY xwiki.cfg webapps/xwiki/WEB-INF/

VOLUME /usr/local/tomcat/work/xwiki

ENTRYPOINT ["/xwiki-tomcat-entrypoint.sh"]
