FROM alpine:3.11

# Install Instantclient Basic Light Oracle and Dependencies
RUN apk --no-cache add libaio libnsl libc6-compat curl && \
    cd /tmp && \
    curl -o instantclient-basiclite.zip https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip -SL && \
    unzip instantclient-basiclite.zip && \
    mv instantclient*/ /usr/lib/instantclient && \
    rm instantclient-basiclite.zip && \
    ln -s /usr/lib/instantclient/libclntsh.so.19.1 /usr/lib/libclntsh.so && \
    ln -s /usr/lib/instantclient/libocci.so.19.1 /usr/lib/libocci.so && \
    ln -s /usr/lib/instantclient/libociicus.so /usr/lib/libociicus.so && \
    ln -s /usr/lib/instantclient/libnnz19.so /usr/lib/libnnz19.so && \
    ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 && \
    ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 && \
    ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2

ENV ORACLE_BASE /usr/lib/instantclient
ENV LD_LIBRARY_PATH /usr/lib/instantclient
ENV NLS_LANG AMERICAN_AMERICA.AL32UTF8
ENV TNS_ADMIN /usr/lib/instantclient
ENV ORACLE_HOME /usr/lib/instantclient

ENV OMNIDB_VERSION 2.17.0

RUN apk add --no-cache --virtual .build-deps curl unzip g++ python3-dev \
      && apk add --no-cache make wget llvm \
      && apk add --no-cache --update python3 \
      && pip3 install --upgrade pip \
      && apk add postgresql-dev libffi-dev \
      && pip3 install psycopg2 \
      && pip3 install cffi \
      && curl -Lo /tmp/OmniDB.zip https://github.com/OmniDB/OmniDB/archive/${OMNIDB_VERSION}.zip \
      && unzip /tmp/OmniDB.zip -d /opt/ \
      && rm -f /tmp/OmniDB.zip \
      && mkdir /etc/omnidb \
      && cd /opt/OmniDB-${OMNIDB_VERSION} \
      && pip3 install cherrypy \
      && pip3 install -r requirements.txt \
      && apk del .build-deps \
      && find /usr/local -name '*.a' -delete \
      && addgroup -S omnidb && adduser -S omnidb -G omnidb \
      && chown -R omnidb:omnidb /opt/OmniDB-${OMNIDB_VERSION} \
      && chown -R omnidb:omnidb /etc/omnidb

USER omnidb

EXPOSE 8000 25482

WORKDIR /opt/OmniDB-${OMNIDB_VERSION}/OmniDB

ENTRYPOINT ["python3", "omnidb-server.py", "--host=0.0.0.0", "--port=8000", "-d", "/etc/omnidb"]