# irods-provider-postgres

iRODS provider in Docker

- 4.2.2 - Debian:stretch based using PostgreSQL 10 (16.04 Xenial iRODS packages)
- 4.2.1 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS packages)
- 4.2.0 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS packages)
- 4.1.11 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS ftp deb files)
- 4.1.10 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS ftp deb files)
- 4.1.9 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS ftp deb files)
- 4.1.8 - Debian:jessie based using PostgreSQL 9.6 (14.04 Trusty iRODS ftp deb files)

Jump to [Real world usage](#real_usage) example

## Supported tags and respective Dockerfile links

- 4.2.2, latest ([4.2.2/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.2/Dockerfile))
- 4.2.1 ([4.2.1/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.1/Dockerfile))
- 4.2.0 ([4.2.0/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.2.0/Dockerfile))
- 4.1.11 ([4.1.11/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.1.11/Dockerfile))
- 4.1.10 ([4.1.10/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.1.10/Dockerfile))
- 4.1.9 ([4.1.9/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.1.9/Dockerfile))
- 4.1.8 ([4.1.8/Dockerfile](https://github.com/mjstealey/irods-provider-postgres/blob/master/4.1.8/Dockerfile))

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

- **Note**: For iRODS 4.1.x there is no need to specify `IRODS_SERVER_ROLE`, `ODBC_DRIVER_FOR_POSTGRES` or `IRODS_DATABASE_USER_PASSWORD_SALT`. If specified the values will be ignored as they are not used by the 4.1.x setup scripts.


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

SE Linux users should note that volume mounts may fail, and may require a `:z` or `:Z` at the end of their volume defintion.

- `-v $(pwd)/var_irods:/var/lib/irods:z`

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

- **Note**: For iRODS 4.1.x there is no need to specify `IRODS_SERVER_ROLE`, `ODBC_DRIVER_FOR_POSTGRES` or `IRODS_DATABASE_USER_PASSWORD_SALT`. If specified the values will be ignored as they are not used by the 4.1.x setup scripts.

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

### <a name="real_usage"></a> Example: Real world usage

The docker based implementation of iRODS can be used as a standard iRODS catalog provider when being installed on a VM or other platform capable of running docker and has a DNS resolvable name.

In this example we will be using a VM on a private VLAN (not publicly accessible) with:

- Hostname: `mjs-dev-1.edc.renci.org`
- User: `stealey`
- UID/GID: `20022`/`10000`
	- iRODS files to be owned by `20022`/`10000`
	- PostgreSQL files to be owned by `999`/`10000`
- Map 
	- host: `/var/provider/lib_irods` to docker - `/var/lib/irods`
	- host: `/var/provider/etc_irods` to docker - `/etc/irods`
	- host: `/var/provider/pg_data` to docker - `/var/lib/postgresql/data`

**Configuration**

Create an environment file that captures the essence of what you want to deploy. In this example this has been named `irods-provider.env`. The file only needs to contain the values that are being changed from the default, but all are shown here for completeness.

Passwords generated using [pwgen](https://sourceforge.net/projects/pwgen/): `$ pwgen -cnB 32 1`

Example: `irods-provider.env` 

```
IRODS_SERVICE_ACCOUNT_NAME=irods
IRODS_SERVICE_ACCOUNT_GROUP=irods
IRODS_SERVER_ROLE=1
ODBC_DRIVER_FOR_POSTGRES=2
IRODS_DATABASE_SERVER_HOSTNAME=localhost
IRODS_DATABASE_SERVER_PORT=5432
IRODS_DATABASE_NAME=ICAT
IRODS_DATABASE_USER_NAME=irods
IRODS_DATABASE_PASSWORD=thooJohkoo4tah9xi3xuehobooNaikoo
IRODS_DATABASE_USER_PASSWORD_SALT=ifu9ocohteipuchae4eejienoe3bahth
IRODS_ZONE_NAME=mjsDevZone
IRODS_PORT=1247
IRODS_PORT_RANGE_BEGIN=20000
IRODS_PORT_RANGE_END=20199
IRODS_CONTROL_PLANE_PORT=1248
IRODS_SCHEMA_VALIDATION=file:///var/lib/irods/configuration_schemas
IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods
IRODS_SERVER_ZONE_KEY=unieg4aing3Ed4Too7choT4ie4Eiceiz
IRODS_SERVER_NEGOTIATION_KEY=ieb4mahNg7wahiefoo4ahchif9seiC4a
IRODS_CONTROL_PLANE_KEY=aiNiePhi4queshiacoog3uugai4UhooJ
IRODS_SERVER_ADMINISTRATOR_PASSWORD=eeThefeig3ahNo9othaequooMo4bohsa
IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault
UID_POSTGRES=999
GID_POSTGRES=10000
UID_IRODS=20022
GID_IRODS=10000
```
Create the directories on the host to share with the provider container and set the permissions to correspond with the UID/GID that will be passed to the container.

```
$ sudo mkdir -p /var/provider/lib_irods \
	/var/provider/etc_irods \
	/var/provider/pg_data
$ sudo chown -R 20022:10000 /var/provider/lib_irods \
	/var/provider/etc_irods
$ sudo chown -R 999:10000 /var/provider/pg_data
$ sudo ls -alh /var/provider/ ### <-- validate settings
```

**Deployment**

Because we want this to interact as a normal iRODS provider, we will need to open the necessary ports for it to do so. specifically ports `1247`, `1248` and `20000-20199`.

Run this docker command from the same directory as the `irods-provider.env` file.

```
$ docker run -d --name provider \
	-h mjs-dev-1.edc.renci.org \
	--env-file=irods-provider.env \
	-v /var/provider/lib_irods:/var/lib/irods \
	-v /var/provider/etc_irods:/etc/irods \
	-v /var/provider/pg_data:/var/lib/postgresql/data \
	-p 1247:1247 \
	-p 1248:1248 \
	-p 20000-20199:20000-20199 \
	mjstealey/irods-provider-postgres:latest \
	-i run_irods
```

Since the container is being run with the `-d` flag, progress can be monitored by using docker attach to attach a terminal to the `STDOUT` of the container.

```
$ docker attach --sig-proxy=false provider
```

Use `ctl-c` to exit when finished.

Output of docker ps should look something like:

```
$ docker ps
CONTAINER ID        IMAGE                                      COMMAND                  CREATED             STATUS              PORTS                                                                              NAMES
f04993705973        mjstealey/irods-provider-postgres:latest   "/irods-docker-ent..."   27 seconds ago      Up 24 seconds       0.0.0.0:1247-1248->1247-1248/tcp, 0.0.0.0:20000-20199->20000-20199/tcp, 5432/tcp   provider
```

The container should also identify it's hostname as the same that you are running it on.

```
$ docker exec provider hostname
mjs-dev-1.edc.renci.org
```

**Sample iCommands**

A true test of the system will be to log in from another machine, iinit as the `rods` user from the `mjs-dev-1.edc.renci.org` deployment, and see if iCommands work as they should.

In this example we will be using `galera-1.edc.renci.org` as the other machine that has our iRODS deployment within it's network scope (on the same VLAN).

From `galera-1.edc.renci.org`:

```
$ iinit
One or more fields in your iRODS environment file (irods_environment.json) are
missing; please enter them.
Enter the host name (DNS) of the server to connect to: mjs-dev-1.edc.renci.org
Enter the port number: 1247
Enter your irods user name: rods
Enter your irods zone: mjsDevZone
Those values will be added to your environment file (for use by
other iCommands) if the login succeeds.

Enter your current iRODS password: eeThefeig3ahNo9othaequooMo4bohsa

$ ils
/mjsDevZone/home/rods:

$ iadmin lr
bundleResc
demoResc

$ iadmin lu
rods#mjsDevZone

$ iadmin lz
mjsDevZone
```

Try `iput` from `galera-1.edc.renci.org` using a 10MB test file:

```
$ dd if=/dev/zero of=test-file.dat  bs=1M  count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB) copied, 0.0109233 s, 960 MB/s
$ ls -alh test-file.dat
-rw-r--r-- 1 xxxxx xxxxx 10M Nov 10 13:32 test-file.dat

$ iput test-file.dat
$ ils -Lr
/mjsDevZone/home/rods:
  rods              0 demoResc     10485760 2017-11-10.13:34 & test-file.dat
        generic    /var/lib/irods/iRODS/Vault/home/rods/test-file.dat
```

Verify file on disk at `mjs-dev-1.edc.renci.org` in the vault:

```
$ sudo ls -alh /var/provider/lib_irods/iRODS/Vault/home/rods
total 10M
drwxr-x--- 2 xxxxx xxxxx 26 Nov 10 13:34 .
drwxr-x--- 3 xxxxx xxxxx 17 Nov 10 13:23 ..
-rw------- 1 xxxxx xxxxx 10M Nov 10 13:34 test-file.dat
```

All other interactions that one would normally have wtih an iRODS provider should hold true for the Docker implementation.

Since the critical files are persisted to the host, adjustment to files such as `/etc/irods/server_config.json` could instead be done at `/var/provider/etc_irods/server_config.json` so long as the appropriate file access permissions are adhered to.

### Additional information

The provided examples all use the `-d` flag to daemonize the docker container. The output that would normally be displayed to `STDOUT` of the container is therefore suppressed.

Output example for [iRODS provider v4.2.2](example-output/example-output-4.2.2.md)