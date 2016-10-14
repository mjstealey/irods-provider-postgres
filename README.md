# irods-provider-postgres
Docker implementation of iRODS provider using PostgreSQL 9.4

## Supported tags and respective Dockerfile links

- 4.2.0-preview ([4.2.0-preview/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.0-preview/Dockerfile)) **This pre-release is for TESTING ONLY - do not use this for production deployments.**

### Pull image from dockerhub
```bash
docker pull mjstealey/irods-provider-postgres:latest
```
### Usage:

**Example 1.** Deploying with default configuration
```bash
docker run --name provider mjstealey/irods-provider-postgres:latest
```
This call can also be daemonized with the **-d** flag (`docker run -d --name provider mjstealey/irods-provider-postgres:latest`) which would most likely be used in an actual environment.

On completion a running container named **provider** is spawned with the following configuration:
```
...
-------------------------------------------
Database Type: postgres
ODBC Driver:   PostgreSQL Unicode
Database Host: localhost
Database Port: 5432
Database Name: ICAT
Database User: irods
-------------------------------------------
...
-------------------------------------------
Zone name:                  tempZone
iRODS server port:          1247
iRODS port range (begin):   20000
iRODS port range (end):     20199
Control plane port:         1248
Schema validation base URI: file:///var/lib/irods/configuration_schemas
iRODS server administrator: rods
-------------------------------------------
...
Success.

+--------------------------------+
| iRODS is installed and running |
+--------------------------------+
```

Default configuration is based on the default environment variables of the container which are defined as:
```
IRODS_SERVICE_ACCOUNT_NAME=irods
IRODS_SERVICE_ACCOUNT_GROUP=irods
IRODS_SERVER_ROLE=1
ODBC_DRIVER_FOR_POSTGRES=2
IRODS_DATABASE_SERVER_HOSTNAME=localhost
IRODS_DATABASE_SERVER_PORT=5432
IRODS_DATABASE_NAME=ICAT
IRODS_DATABASE_USER_NAME=irods
IRODS_DATABASE_PASSWORD=temppassword
IRODS_DATABASE_USER_PASSWORD_SALT=tempsalt
IRODS_ZONE_NAME=tempZone
IRODS_PORT=1247
IRODS_PORT_RANGE_BEGIN=20000
IRODS_PORT_RANGE_END=20199
IRODS_CONTROL_PLANE_PORT=1248
IRODS_SCHEMA_VALIDATION=file:///var/lib/irods/configuration_schemas
IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods
IRODS_SERVER_ZONE_KEY=TEMPORARY_zone_key
IRODS_SERVER_NEGOTIATION_KEY=TEMPORARY_32byte_negotiation_key
IRODS_CONTROL_PLANE_KEY=TEMPORARY__32byte_ctrl_plane_key
IRODS_SERVER_ADMINISTRATOR_PASSWORD=rods
IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault
```
The **docker exec** can be used to interact with the running iRODS provider. Additionally a user definition of **-u irods** will specify that commands should be run as the **irods** service account assigned as the **rodsadmin** of the deployment.

- Sample **ils**:

  ```
  $ docker exec -u irods provider ils
  /tempZone/home/rods:
  ```

- Sample **iadmin lz**:

  ```
  $ docker exec -u irods provider iadmin lz
  tempZone
  ```
- Sample **ienv**:

  ```
  $ docker exec -u irods provider ienv
  irods_version - 4.2.0
  irods_zone_name - tempZone
  irods_host - 82420a60d73f
  irods_transfer_buffer_size_for_parallel_transfer_in_megabytes - 4
  irods_user_name - rods
  irods_match_hash_policy - compatible
  irods_session_environment_file - /var/lib/irods/.irods/irods_environment.json.0
  irods_port - 1247
  irods_server_control_plane_encryption_num_hash_rounds - 16
  irods_default_resource - demoResc
  irods_home - /tempZone/home/rods
  irods_encryption_num_hash_rounds - 16
  irods_encryption_key_size - 32
  schema_name - irods_environment
  irods_server_control_plane_encryption_algorithm - AES-256-CBC
  irods_default_hash_scheme - SHA256
  irods_cwd - /tempZone/home/rods
  irods_encryption_algorithm - AES-256-CBC
  irods_client_server_policy - CS_NEG_REFUSE
  irods_environment_file - /var/lib/irods/.irods/irods_environment.json
  irods_default_number_of_transfer_threads - 4
  irods_maximum_size_for_single_buffer_in_megabytes - 32
  schema_version - v3
  irods_encryption_salt_size - 8
  irods_server_control_plane_key - TEMPORARY__32byte_ctrl_plane_key
  irods_server_control_plane_port - 1248
  irods_client_server_negotiation - request_server_negotiation
  ```
  **NOTE:** The `irods_host` value is set to the ID of the Docker container. This can be specified by the user at runtime using the `-h HOST_NAME` syntax.
  
**Example 2.** Use a local environment file to pass environment variables into the docker container for the iRODS provider to use during `setup_irods.py` call.
```bash
$ docker run --env-file sample-provider.env --name provider mjstealey/irods-provider-postgres:latest
```
- Using sample environment file named `sample-provider.env` you can override as many or as few default environment variables as you want (Update as required for your iRODS installation).

  ```bash
  IRODS_SERVICE_ACCOUNT_NAME=irods
  IRODS_SERVICE_ACCOUNT_GROUP=irods
  IRODS_SERVER_ROLE=1         # iRODS server's role: 1. provider, 2. consumer
  ODBC_DRIVER_FOR_POSTGRES=2  # ODBC driver for postgres: 1. PostgreSQL ANSI, 2. PostgreSQL Unicode
  IRODS_DATABASE_SERVER_HOSTNAME=localhost
  IRODS_DATABASE_SERVER_PORT=5432
  IRODS_DATABASE_NAME=ICAT
  IRODS_DATABASE_USER_NAME=irods
  IRODS_DATABASE_PASSWORD=temppassword
  IRODS_DATABASE_USER_PASSWORD_SALT=tempsalt
  IRODS_ZONE_NAME=tempZone
  IRODS_PORT=1247
  IRODS_PORT_RANGE_BEGIN=20000
  IRODS_PORT_RANGE_END=20199
  IRODS_CONTROL_PLANE_PORT=1248
  IRODS_SCHEMA_VALIDATION=file:///var/lib/irods/configuration_schemas
  IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods
  IRODS_SERVER_ZONE_KEY=TEMPORARY_zone_key
  IRODS_SERVER_NEGOTIATION_KEY=TEMPORARY_32byte_negotiation_key
  IRODS_CONTROL_PLANE_KEY=TEMPORARY__32byte_ctrl_plane_key
  IRODS_SERVER_ADMINISTRATOR_PASSWORD=rods
  IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault
  ```
  
This call can also be daemonized with the **-d** flag, which would most likely be used in an actual environment.

On completion, a running container named **provider** is spawned with the same configuration as in the first example.

- Sample **iadmin lr**:
  ```
  $ docker exec -u irods provider iadmin lr
  bundleResc
  demoResc
  ```

- Sample **iadmin lu**
  ```
  $ docker exec -u irods provider iadmin lu
  rods#tempZone
  ```
  
**Example 3.** Sharing host volume with container for persisting database or Vault

The container exposes two volume mount points for PostgreSQL data and iRODS Vault data.

- iRODS Vault data: `/var/lib/irods/iRODS/Vault`
- iRODS Config data: `/etc/irods`
- PostgreSQL data: `/var/lib/postgresql/data`

The host can mount local volumes in order to preserve the iRODS installation between runs of the docker container. Say we want to map `/LOCAL_POSTGRES` to `/var/lib/postgresql/data`, `/LOCAL_VAULT` to `/var/lib/irods/iRODS/Vault`, and `/LOCAL_CONFIG` to `/etc/irods`, we would run something like this:

```
$ docker run \
  -v /LOCAL_POSTGRES:/var/lib/postgresql/data \
  -v /LOCAL_VAULT:/var/lib/irods/iRODS/Vault \
  -v /LOCAL_CONFIG:/etc/irods \
  --name provider \
  mjstealey/irods-provider-postgres:latest
```

Using a local directory named `/mydata` for PostgreSQL data, local directory `/myvault` for the iRODS Vault data, and `/myconfig` for iRODS server configuration along with our environment configuration in the  **myprovider.env** file, we would run this:
```
$ docker run \
  -v /mydata:/var/lib/postgresql/data \
  -v /myvault:/var/lib/irods/iRODS/Vault \
  -v /myconfig:/etc/irods \
  --env-file myprovider.env \
  --name provider \
  mjstealey/irods-provider-postgres:latest
```
On completion a running container named **provider** is spawned with the configuration as defined in the  **sample-provider.env** file. If we were to look in the local `/mydata`, `myvault`, and `myconfig` directories we would see the following:

PostgreSQL **/mydata**
```
$ sudo ls /mydata/ -1
base
global
pg_clog
pg_dynshmem
pg_hba.conf
pg_ident.conf
pg_logical
pg_multixact
pg_notify
pg_replslot
pg_serial
pg_snapshots
pg_stat
pg_stat_tmp
pg_subtrans
pg_tblspc
pg_twophase
PG_VERSION
pg_xlog
postgresql.auto.conf
postgresql.conf
postmaster.opts
postmaster.pid
```
**NOTE** - sudo is required because the files are owned by the **postgres** user within the container which may not have a corresponding user on the local file system. The **postgres** user has UID=999, GID=999.

iRODS Vault **/myvault**
```
$ sudo ls /myvault/
home
$ sudo ls /myvault/home
rods
```
**NOTE** - sudo is required because the files are owned by the **irods** user within the container which may not have a corresponding user on the local file system. The **irods** user has UID=998, GID=998.

iRODS Server config **/myconfig**
```
$ sudo ls /myconfig/ -1
core.dvm
core.fnm
core.re
host_access_control_config.json
hosts_config.json
server_config.json
service_account.config
```
**NOTE** - sudo is required because the files are owned by the **irods** user within the container which may not have a corresponding user on the local file system. The **irods** user has UID=998, GID=998.
