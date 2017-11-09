FROM postgres:10
MAINTAINER Michael J. Stealey <michael.j.stealey@gmail.com>

# set user/group IDs for irods account
RUN groupadd -r irods --gid=998 \
    && useradd -r -g irods -d /var/lib/irods --uid=998 irods \
    && mv /docker-entrypoint.sh /postgres-docker-entrypoint.sh

# install iRODS v4.2.2
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" \
    > /etc/apt/sources.list.d/jessie-backports.list \
    && apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    apt-transport-https \
    sudo \
    jq \
    && wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.irods.org/apt/ xenial main" \
    > /etc/apt/sources.list.d/renci-irods.list \
    && apt-get update && apt-get install -y \
    irods-server=4.2.2 \
    irods-database-plugin-postgres=4.2.2

# default iRODS env
ENV IRODS_SERVICE_ACCOUNT_NAME=irods
ENV IRODS_SERVICE_ACCOUNT_GROUP=irods
# 1. provider, 2. consumer
ENV IRODS_SERVER_ROLE=1
# 1. PostgreSQL ANSI, 2. PostgreSQL Unicode
ENV ODBC_DRIVER_FOR_POSTGRES=2
ENV IRODS_DATABASE_SERVER_HOSTNAME=localhost
ENV IRODS_DATABASE_SERVER_PORT=5432
ENV IRODS_DATABASE_NAME=ICAT
ENV IRODS_DATABASE_USER_NAME=irods
ENV IRODS_DATABASE_PASSWORD=temppassword
ENV IRODS_DATABASE_USER_PASSWORD_SALT=tempsalt
ENV IRODS_ZONE_NAME=tempZone
ENV IRODS_PORT=1247
ENV IRODS_PORT_RANGE_BEGIN=20000
ENV IRODS_PORT_RANGE_END=20199
ENV IRODS_CONTROL_PLANE_PORT=1248
ENV IRODS_SCHEMA_VALIDATION=file:///var/lib/irods/configuration_schemas
ENV IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods
ENV IRODS_SERVER_ZONE_KEY=TEMPORARY_zone_key
ENV IRODS_SERVER_NEGOTIATION_KEY=TEMPORARY_32byte_negotiation_key
ENV IRODS_CONTROL_PLANE_KEY=TEMPORARY__32byte_ctrl_plane_key
ENV IRODS_SERVER_ADMINISTRATOR_PASSWORD=rods
ENV IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault
# UID / GID settings
ENV UID_POSTGRES=999
ENV GID_POSTGRES=999
ENV UID_IRODS=998
ENV GID_IRODS=998

# create postgresql.tar.gz
RUN cd /var/lib/postgresql/data \
    && tar -czvf /postgresql.tar.gz . \
    && cd /

# create irods.tar.gz
RUN cd /var/lib/irods \
    && tar -czvf /irods.tar.gz . \
    && cd /

COPY ./docker-entrypoint.sh /irods-docker-entrypoint.sh
VOLUME /var/lib/irods /etc/irods /var/lib/postgresql/data

EXPOSE $IRODS_PORT $IRODS_CONTROL_PLANE_PORT $IRODS_PORT_RANGE_BEGIN-$IRODS_PORT_RANGE_END
ENTRYPOINT ["/irods-docker-entrypoint.sh"]
WORKDIR "/var/lib/irods"

CMD ["-i", "run_irods"]