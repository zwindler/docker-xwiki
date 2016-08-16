FROM tomcat:8-jre8
MAINTAINER Denis GERMAIN <dt.germain@gmail.com> 
ENV POSTGRES_INSTANCE=xwiki-pgsql
ENV POSTGRES_PORT=5432
ENV POSTGRES_DB=xwiki
ENV POSTGRES_USER=xwiki
ENV POSTGRES_PASSWORD=xwiki

RUN rm -rf webapps/* && \
    curl -L \
      'http://download.forge.ow2.org/xwiki/xwiki-enterprise-web-8.2.1.war' \
       -o xwiki.war && \
    unzip -d webapps/xwiki xwiki.war && \
    rm -f xwiki.war

RUN curl -L \
      'https://jdbc.postgresql.org/download/postgresql-9.4.1208.jar' \
      -o 'webapps/xwiki/WEB-INF/lib/postgresql-9.4-1208.jdbc42.jar'

COPY hibernate.cfg.xml webapps/xwiki/WEB-INF/
COPY xwiki.cfg webapps/xwiki/WEB-INF/
COPY catalina.properties.append catalina.properties.append
COPY setenv.sh bin/setenv.sh

RUN cat catalina.properties.append >> conf/catalina.properties && \
    rm catalina.properties.append && \
    sed -i "s/redirectPort=\"8443\" /redirectPort=\"8443\" URIEncoding=\"UTF-8\" /" conf/server.xml

COPY xwiki-tomcat-entrypoint.sh /

ENTRYPOINT ["/xwiki-tomcat-entrypoint.sh"]
