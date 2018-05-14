FROM postgres:10
MAINTAINER Michael J. Stealey <michael.j.stealey@gmail.com>

ENV IRODS_VERSION=4.1.10

# set user/group IDs for irods account
RUN groupadd -r irods --gid=998 \
    && useradd -r -g irods -d /var/lib/irods --uid=998 irods \
    && mv /docker-entrypoint.sh /postgres-docker-entrypoint.sh

# install iRODS 4.1.10
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" \
    > /etc/apt/sources.list.d/jessie-backports.list \
  && apt-get update && apt-get install -y \
  wget \
  sudo \
  unixodbc \
  odbc-postgresql \
  super \
  perl \
  libssl1.0.0 \
  libfuse2 \
  libjson-perl \
  perl \
  python \
  python-psutil \
  python-requests \
  lsof \
  python-jsonschema \
  moreutils \
  jq

RUN wget -L ftp://ftp.renci.org/pub/irods/releases/${IRODS_VERSION}/ubuntu14/irods-icat-${IRODS_VERSION}-ubuntu14-x86_64.deb \
  && wget -L ftp://ftp.renci.org/pub/irods/releases/${IRODS_VERSION}/ubuntu14/irods-database-plugin-postgres-1.10-ubuntu14-x86_64.deb \
  && dpkg -i \
    irods-database-plugin-postgres-1.10-ubuntu14-x86_64.deb \
    irods-icat-${IRODS_VERSION}-ubuntu14-x86_64.deb \
  && rm -f irods-icat-${IRODS_VERSION}-ubuntu14-x86_64.deb \
  && rm -f irods-database-plugin-postgres-1.10-ubuntu14-x86_64.deb

# default iRODS and PostgreSQL environment variables
ENV IRODS_SERVICE_ACCOUNT_NAME=irods \
  IRODS_SERVICE_ACCOUNT_GROUP=irods \
  IRODS_DATABASE_SERVER_HOSTNAME=localhost \
  IRODS_DATABASE_SERVER_PORT=5432 \
  IRODS_DATABASE_NAME=ICAT \
  IRODS_DATABASE_USER_NAME=irods \
  IRODS_DATABASE_PASSWORD=temppassword \
  IRODS_ZONE_NAME=tempZone \
  IRODS_PORT=1247 \
  IRODS_PORT_RANGE_BEGIN=20000 \
  IRODS_PORT_RANGE_END=20199 \
  IRODS_CONTROL_PLANE_PORT=1248 \
  IRODS_SCHEMA_VALIDATION=https://schemas.irods.org/configuration \
  IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods \
  IRODS_SERVER_ZONE_KEY=TEMPORARY_zone_key \
  IRODS_SERVER_NEGOTIATION_KEY=TEMPORARY_32byte_negotiation_key \
  IRODS_CONTROL_PLANE_KEY=TEMPORARY__32byte_ctrl_plane_key \
  IRODS_SERVER_ADMINISTRATOR_PASSWORD=rods \
  IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault \
  UID_POSTGRES=999 \
  GID_POSTGRES=999 \
  UID_IRODS=998 \
  GID_IRODS=998 \
  POSTGRES_USER=postgres \
  POSTGRES_PASSWORD=postgres

# create postgresql.tar.gz
RUN cd /var/lib/postgresql/data \
    && tar -czvf /postgresql.tar.gz . \
    && cd /

# create var_irods.tar.gz
RUN cd /var/lib/irods \
    && tar -czvf /var_irods.tar.gz . \
    && cd /

# create etc_irods.tar.gz
RUN cd /etc/irods \
    && tar -czvf /etc_irods.tar.gz . \
    && cd /

COPY ./docker-entrypoint.sh /irods-docker-entrypoint.sh
VOLUME /var/lib/irods /etc/irods /var/lib/postgresql/data

EXPOSE $IRODS_PORT $IRODS_CONTROL_PLANE_PORT $IRODS_PORT_RANGE_BEGIN-$IRODS_PORT_RANGE_END

WORKDIR /var/lib/irods/
ENTRYPOINT ["/irods-docker-entrypoint.sh"]
