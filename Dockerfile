FROM tomcat:9

LABEL org.opencontainers.image.authors=dt.germain@gmail.com

ENV POSTGRES_INSTANCE=xwiki-pgsql POSTGRES_PORT=5432 \
    POSTGRES_DB=xwiki POSTGRES_USER=xwiki \
    POSTGRES_PASSWORD=xwiki

ARG XWIKI_VERSION=14.10.19
ARG PGSQL_JDBC_VERSION=postgresql-42.6.0

COPY setenv.sh bin/setenv.sh
COPY xwiki-tomcat-entrypoint.sh /

RUN sed -i "s/redirectPort=\"8443\" /redirectPort=\"8443\" URIEncoding=\"UTF-8\" /" conf/server.xml

RUN apt-get update && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf webapps/* \
    && curl -L \
      "https://nexus.xwiki.org/nexus/content/groups/public/org/xwiki/platform/xwiki-platform-distribution-war/${XWIKI_VERSION}/xwiki-platform-distribution-war-${XWIKI_VERSION}.war" \
       -o xwiki.war \
    && unzip -d webapps/ROOT xwiki.war \
    && rm -f xwiki.war

RUN curl -L \
      "https://jdbc.postgresql.org/download/${PGSQL_JDBC_VERSION}.jar" \
      -o "webapps/ROOT/WEB-INF/lib/${PGSQL_JDBC_VERSION}.jar" \
    && echo "environment.permanentDirectory=/usr/local/tomcat/work/xwiki" >> webapps/ROOT/WEB-INF/xwiki.properties

COPY logging.properties webapps/ROOT/WEB-INF/classes/logging.properties

COPY hibernate.cfg.xml webapps/ROOT/WEB-INF/
COPY xwiki.cfg webapps/ROOT/WEB-INF/

VOLUME /usr/local/tomcat/work/xwiki

ENTRYPOINT ["/xwiki-tomcat-entrypoint.sh"]
