#!/usr/bin/env bash
set -e

IRODS_CONFIG_FILE=/irods.config
INIT=false
EXISTING=false
USAGE=false
VERBOSE=false
RUN_IRODS=false

_update_uid_gid() {
    # if UID_POSTGRES = UID_IRODS, exit with error message
    if [[ ${UID_POSTGRES} = ${UID_IRODS} ]]; then
        echo "ERROR: user irods and user postgres cannot have same UID!!!"
        exit 1;
    else
    # if UID_POSTGRES != UID_IRODS, reassign individual UIDs
        if [[ ${UID_IRODS} = 999 ]]; then
            gosu root usermod -u 1999 irods
        fi
        gosu root usermod -u ${UID_POSTGRES} postgres
        gosu root usermod -u ${UID_IRODS} irods
    fi
    # if GID_POSTGRES = GID_IRODS, reset GID_POSTGRES=GID_IRODS-1 and use GID_IRODS group permissions
    if [[ ${GID_POSTGRES} = ${GID_IRODS} ]]; then
        gosu root groupmod -g ${GID_IRODS} irods
        gosu root usermod -a -G ${GID_IRODS} postgres
        gosu root chown -R postgres:irods /var/lib/postgresql
        gosu root chown -R irods:irods /var/lib/irods
        gosu root chown -R irods:irods /etc/irods
    else
    # if GID_POSTGRES != GID_IRODS, reassign individual GIDs
        if [[ ${GID_IRODS} = 999 ]]; then
            gosu root groupmod -g 1999 irods
        fi
        gosu root groupmod -g ${GID_POSTGRES} postgres
        gosu root groupmod -g ${GID_IRODS} irods
        gosu root chown -R postgres:postgres /var/lib/postgresql
        gosu root chown -R irods:irods /var/lib/irods
        gosu root chown -R irods:irods /etc/irods
     fi
}

_set_postgres_params() {
    # set postgres-docker-entrypoint.sh variables to coincide with iRODS variables unless explicitly defined
    if [[ -z "${POSTGRES_PASSWORD}" ]]; then
        gosu root sed -i 's/POSTGRES_PASSWORD/IRODS_DATABASE_PASSWORD/g' /postgres-docker-entrypoint.sh
    fi
    if [[ -z "${POSTGRES_USER}" ]]; then
        gosu root sed -i 's/POSTGRES_USER/IRODS_DATABASE_USER_NAME/g' /postgres-docker-entrypoint.sh
    fi
    if [[ -z "${POSTGRES_DB}" ]]; then
        gosu root sed -i 's/POSTGRES_DB/IRODS_DATABASE_NAME/g' /postgres-docker-entrypoint.sh
    fi
}

_postgresql_tgz() {
    if [ -z "$(ls -A /var/lib/postgresql/data)" ]; then
        gosu root cp /postgresql.tar.gz /var/lib/postgresql/data/postgresql.tar.gz
        cd /var/lib/postgresql/data
        if $VERBOSE; then
            echo "!!! populating /var/lib/postgresql/data with initial contents !!!"
            gosu root tar -zxvf postgresql.tar.gz
        else
            gosu root tar -zxf postgresql.tar.gz
        fi
        cd /
        gosu root rm -f /var/lib/postgresql/data/postgresql.tar.gz
    fi
}

_irods_tgz() {
    if [ -z "$(ls -A /var/lib/irods)" ]; then
        gosu root cp /irods.tar.gz /var/lib/irods/irods.tar.gz
        cd /var/lib/irods/
        if $VERBOSE; then
            echo "!!! populating /var/lib/irods with initial contents !!!"
            gosu root tar -zxvf irods.tar.gz
        else
            gosu root tar -zxf irods.tar.gz
        fi
        cd /
        gosu root rm -f /var/lib/irods/irods.tar.gz
    fi
}

_generate_config() {
    DATABASE_HOSTNAME_OR_IP=$(/sbin/ip -f inet -4 -o addr | grep eth | cut -d '/' -f 1 | rev | cut -d ' ' -f 1 | rev)
    echo "${IRODS_SERVICE_ACCOUNT_NAME}" > ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVICE_ACCOUNT_GROUP}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ROLE}" >> ${IRODS_CONFIG_FILE} # 1. provider, 2. consumer
    echo "${ODBC_DRIVER_FOR_POSTGRES}" >> ${IRODS_CONFIG_FILE} # 1. PostgreSQL ANSI, 2. PostgreSQL Unicode
    echo "${IRODS_DATABASE_SERVER_HOSTNAME}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_SERVER_PORT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_USER_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "yes" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_PASSWORD}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_USER_PASSWORD_SALT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_ZONE_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_PORT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_PORT_RANGE_BEGIN}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_PORT_RANGE_END}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_CONTROL_PLANE_PORT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SCHEMA_VALIDATION}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ADMINISTRATOR_USER_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "yes" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ZONE_KEY}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_NEGOTIATION_KEY}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_CONTROL_PLANE_KEY}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ADMINISTRATOR_PASSWORD}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_VAULT_DIRECTORY}" >> ${IRODS_CONFIG_FILE}
}

_usage() {
    echo "Usage: ${0} [-h] [-ix run_irods] [-v] [arguments]"
    echo " "
    echo "options:"
    echo "-h                    show brief help"
    echo "-i run_irods          initialize iRODS 4.2.1 provider"
    echo "-x run_irods          use existing iRODS 4.2.1 provider files"
    echo "-v                    verbose output"
    echo ""
    echo "Example:"
    echo "  $ docker run --rm mjstealey/irods-provider-postgres:4.2.1 -h           # show help"
    echo "  $ docker run -d mjstealey/irods-provider-postgres:4.2.1 -i run_irods   # init with default settings"
    echo ""
    exit 0
}

while getopts hixv opt; do
  case "${opt}" in
    h)      USAGE=true ;;
    i)      INIT=true && echo "Initialize iRODS provider";;
    x)      EXISTING=true && echo "Use existing iRODS provider files";;
    v)      VERBOSE=true ;;
    ?)      USAGE=true && echo "Invalid option provided";;
  esac
done

for var in "$@"
do
    if [[ "${var}" = 'run_irods' ]]; then
        RUN_IRODS=true
    fi
done

if $RUN_IRODS; then
    if $USAGE; then
        _usage
    fi
    if $INIT; then
        _postgresql_tgz
        _irods_tgz
        _update_uid_gid
        _set_postgres_params
        ./postgres-docker-entrypoint.sh postgres &
        while ! pg_isready
        do
            echo "$(date) - waiting for database to start"
            sleep 2s
        done
        sleep 2s
        _generate_config
        gosu root python /var/lib/irods/scripts/setup_irods.py < ${IRODS_CONFIG_FILE}
        _update_uid_gid
        if $VERBOSE; then
            echo "INFO: show ienv"
            gosu irods ienv
        fi
        gosu root tail -f /dev/null
    fi
    if $EXISTING; then
        _update_uid_gid
        gosu postgres postgres &
        while ! pg_isready; do
            echo "$(date) - waiting for database to start"
            sleep 2s
        done
        gosu root service irods start
        gosu root tail -f /dev/null
    fi
else
    if $USAGE; then
        _usage
    fi
    _set_postgres_params
    _update_uid_gid
    exec "$@"
fi

exit 0;