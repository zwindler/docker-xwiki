FROM tomcat:8-jre8
MAINTAINER Denis GERMAIN <dt.germain@gmail.com> 
ENV POSTGRES_INSTANCE=xwiki-pgsql POSTGRES_PORT=5432 \
    POSTGRES_DB=xwiki POSTGRES_USER=xwiki \
    POSTGRES_PASSWORD=xwiki

ARG XWIKI_VERSION=9.0
ARG PGSQL_JDBC_VERSION=postgresql-42.0.0

COPY setenv.sh bin/setenv.sh
COPY xwiki-tomcat-entrypoint.sh /

RUN sed -i "s/redirectPort=\"8443\" /redirectPort=\"8443\" URIEncoding=\"UTF-8\" /" conf/server.xml

RUN rm -rf webapps/* && \
    curl -L \
      "http://download.forge.ow2.org/xwiki/xwiki-enterprise-web-${XWIKI_VERSION}.war" \
       -o xwiki.war && \
    unzip -d webapps/ROOT xwiki.war && \
    rm -f xwiki.war

RUN curl -L \
      "https://jdbc.postgresql.org/download/${PGSQL_JDBC_VERSION}.jar" \
      -o "webapps/ROOT/WEB-INF/lib/${PGSQL_JDBC_VERSION}.jar" && \
    echo "environment.permanentDirectory=/usr/local/tomcat/work/xwiki" >> webapps/ROOT/WEB-INF/xwiki.properties

COPY hibernate.cfg.xml webapps/ROOT/WEB-INF/
COPY xwiki.cfg webapps/ROOT/WEB-INF/

VOLUME /usr/local/tomcat/work/xwiki

ENTRYPOINT ["/xwiki-tomcat-entrypoint.sh"]
