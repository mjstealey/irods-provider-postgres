# irods-provider-postgres

iRODS provider in Docker

- v4.2.2 - Debian:stretch based using PostgreSQL 10 (16.04 Xenial iRODS packages)
- v4.2.1 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS packages)
- v4.2.0 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS packages)

## Supported tags and respective Dockerfile links

- 4.2.2, latest ([4.2.2/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.2/Dockerfile))
- 4.2.1 ([4.2.1/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.1/Dockerfile))
- 4.2.0 ([4.2.0/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.0/Dockerfile))

### Pull image from dockerhub

```bash
$ docker pull mjstealey/irods-provider-postgres:latest
```

### Build locally

```bash
$ cd irods-provider-postgres/4.2.2
$ docker build -t irods-4.2.2 .
$ docker run -d --name provider irods-4.2.2:latest
```

## Usage:

An entry point script named `irods-docker-entrypoint.sh` that is internal to the container will have the provided arguments passed to it.

Supported arguments are:

- `-h`: show brief help
- `-i run_irods`: initialize iRODS provider
- `-x run_irods`: use existing iRODS provider files
- `-v`: verbose output

The options can be referenced by passing in `-h` as in the following example:

```
$ docker run --rm mjstealey/irods-provider-postgres:latest -h
Usage: /irods-docker-entrypoint.sh [-h] [-ix run_irods] [-v] [arguments]

options:
-h                    show brief help
-i run_irods          initialize iRODS 4.2.2 provider
-x run_irods          use existing iRODS 4.2.2 provider files
-v                    verbose output

Example:
  $ docker run --rm mjstealey/irods-provider-postgres:4.2.2 -h           # show help
  $ docker run -d mjstealey/irods-provider-postgres:4.2.2 -i run_irods   # init with default settings
```

### Example: Simple container deploy

```bash
$ docker run -d --name provider mjstealey/irods-provider-postgres:latest
```
This call has been daemonized (additional **-d** flag) which would most likely be used in an actual environment

On completion a running container named **provider** is spawned:

```
$ docker ps
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS              PORTS                                      NAMES
a2b2133a7910        irods-provider-postgres:latest   "/irods-docker-ent..."   54 seconds ago      Up About a minute   1247-1248/tcp, 5432/tcp, 20000-20199/tcp   provider
```

Default configuration is based on the default environment variables of the container which are defined as:

```
# default iRODS env
IRODS_SERVICE_ACCOUNT_NAME=irods
IRODS_SERVICE_ACCOUNT_GROUP=irods
# 1. provider, 2. consumer
IRODS_SERVER_ROLE=1
# 1. PostgreSQL ANSI, 2. PostgreSQL Unicode
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
# UID / GID settings
UID_POSTGRES=999
GID_POSTGRES=999
UID_IRODS=998
GID_IRODS=998
```
Interaction with the iRODS server can be done with the `docker exec` command. The container has a definition of the `irods` Linux service account that has been associated with the `rods` **rodsadmin** user in iRODS. Interaction would look as follows:

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
	irods_version - 4.2.2
	irods_server_control_plane_encryption_algorithm - AES-256-CBC
	schema_name - irods_environment
	irods_transfer_buffer_size_for_parallel_transfer_in_megabytes - 4
	irods_host - a2b2133a7910
	irods_user_name - rods
	irods_zone_name - tempZone
	irods_server_control_plane_encryption_num_hash_rounds - 16
	irods_maximum_size_for_single_buffer_in_megabytes - 32
	irods_session_environment_file - /var/lib/irods/.irods/irods_environment.json.0
	irods_port - 1247
	irods_default_resource - demoResc
	irods_home - /tempZone/home/rods
	irods_encryption_num_hash_rounds - 16
	irods_match_hash_policy - compatible
	irods_default_hash_scheme - SHA256
	irods_client_server_policy - CS_NEG_REFUSE
	schema_version - v3
	irods_encryption_salt_size - 8
	irods_encryption_algorithm - AES-256-CBC
	irods_environment_file - /var/lib/irods/.irods/irods_environment.json
	irods_default_number_of_transfer_threads - 4
	irods_encryption_key_size - 32
	irods_server_control_plane_port - 1248
	irods_server_control_plane_key - TEMPORARY__32byte_ctrl_plane_key
	irods_client_server_negotiation - request_server_negotiation
	irods_cwd - /tempZone/home/rods
	```

  **NOTE:** The `irods_host` value is set to the ID of the Docker container. This can be specified by the user at runtime using the `-h HOST_NAME` syntax.

### Example: Persisting data

By sharing volumes from the host to the container, the user can persist data between container instances even if the original container definition is removed from the system.

Volumes to mount:

- **iRODS home**: map to `/var/lib/irods/` on the container
- **iRODS configuration**: map to `/etc/irods/` on the container
- **PostgreSQL data**: map to `/var/lib/postgresql/data/` on the container

It is also necessary to define a **hostname** for the container when persisting data as the hostname information is written to the data store on initialization.

1. Create volumes on the host:

	```
	$ mkdir var_irods  # map to /var/lib/irods/
	$ mkdir etc_irods  # map to /etc/irods/
	$ mkdir var_pgdata # map to /var/lib/postgresql/data/
	```

2. Run the docker container with the `-i` flag for **init**:

	```
	$ docker run -d --name provider \
		-h irods-provider \
		-v $(pwd)/var_irods:/var/lib/irods \
		-v $(pwd)/etc_irods:/etc/irods \
		-v $(pwd)/var_pgdata:/var/lib/postgresql/data \
		mjstealey/irods-provider-postgres:latest \
		-i run_irods
	```
	
	Note, the host volumes now contain the relevant data to the iRODS deployment
	
	```
	$ ls var_irods
	VERSION.json          clients               configuration_schemas irodsctl              msiExecCmd_bin        scripts
	VERSION.json.dist     config                iRODS                 log                   packaging             test
	
	$ ls etc_irods
	core.dvm                        core.re                         hosts_config.json               service_account.config
	core.fnm                        host_access_control_config.json server_config.json
	
	$ ls var_pgdata
	PG_VERSION           pg_dynshmem          pg_multixact         pg_snapshots         pg_tblspc            postgresql.auto.conf
	base                 pg_hba.conf          pg_notify            pg_stat              pg_twophase          postgresql.conf
	global               pg_ident.conf        pg_replslot          pg_stat_tmp          pg_wal               postmaster.opts
	pg_commit_ts         pg_logical           pg_serial            pg_subtrans          pg_xact              postmaster.pid
	```
	
	Go ahead and `iput` some data and verify it in the catalog.
	
	```
	$ docker exec -u irods provider iput VERSION.json
	$ docker exec -u irods provider ils -Lr
	/tempZone/home/rods:
	  rods              0 demoResc          224 2017-11-09.18:13 & VERSION.json
	        generic    /var/lib/irods/iRODS/Vault/home/rods/VERSION.json
	```
	
	Note, the physical file can be found at: `$(pwd)/var_irods/iRODS/Vault/home/rods/VERSION.json` of the host

3. Stop and remove the provider container:

	```
	$ docker stop provider
	$ docker rm -fv provider
	```
	This destroys any host level definitions or default docker volumes related to the provider container and makes it impossible to recover the data from that container if we had not persisted it locally

4. Run a new docker container with the `-x` flag for **use existing**:

	```
	$ docker run -d --name new-provider \
		-h irods-provider \
		-v $(pwd)/var_irods:/var/lib/irods \
		-v $(pwd)/etc_irods:/etc/irods \
		-v $(pwd)/var_pgdata:/var/lib/postgresql/data \
		mjstealey/irods-provider-postgres:latest \
		-x run_irods
	```
	Even though the name of the docker container changed, the shared host volume mounts and defined hostname that the container should use remained the same.
	
	Verify that the file put from the previous container has persisted on the new container instance.
	
	```
	$ docker exec -u irods new-provider ils -Lr
	/tempZone/home/rods:
	  rods              0 demoResc          224 2017-11-09.18:13 & VERSION.json
	        generic    /var/lib/irods/iRODS/Vault/home/rods/VERSION.json
	```

### Example: Using an environment file

The default configuration variables can be overwritten by user defined values and passed to the container's environment by using an environment file.

Example: `sample-provider.env` 

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
UID_POSTGRES=999
GID_POSTGRES=999
UID_IRODS=998
GID_IRODS=998
```
This can be particularly useful if you want shared volume mounts to be written to the host using a particular `UID` or `GID` value to better integrate with the system.

The inclusion of an environment file is made by adding `--env-file=FILENAME` to the `docker run` call.

Example:

```
$ docker run -d --name provider \
	-h irods-provider \
	--env-file=$(pwd)/sample-provider.env \
	-v $(pwd)/var_irods:/var/lib/irods \
	-v $(pwd)/etc_irods:/etc/irods \
	-v $(pwd)/var_pgdata:/var/lib/postgresql/data \
	mjstealey/irods-provider-postgres:latest \
	-i run_irods
```

### Additional information

The provided examples all use the `-d` flag to daemonize the docker container. The output that would normally be displayed to `STDOUT` of the container is therefore suppressed.

Output example for [iRODS provider v4.2.2](example-output/example-output-4.2.2.md)