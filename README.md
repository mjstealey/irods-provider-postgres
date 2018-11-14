# irods-provider-postgres

## What is iRODS?

The Integrated Rule-Oriented Data System (iRODS) is open source data management software used by research organizations and government agencies worldwide.

iRODS is released as a production-level distribution aimed at deployment in mission critical environments. It virtualizes data storage resources, so users can take control of their data, regardless of where and on what device the data is stored.

The development infrastructure supports exhaustive testing on supported platforms.

The plugin architecture supports microservices, storage systems, authentication, networking, databases, rule engines, and an extensible API.

For more details refer to the [official iRODS documentation](https://docs.irods.org/4.2.4).

## Supported tags and respective Dockerfile links

The following tags are supported at: [https://hub.docker.com/r/mjstealey/irods-provider-postgres/](https://hub.docker.com/r/mjstealey/irods-provider-postgres/)

- 4.2.4, latest ([4.2.4/Dockerfile](4.2.4/Dockerfile))
- 4.2.3 ([4.2.3/Dockerfile](4.2.3/Dockerfile))
- 4.2.2 ([4.2.2/Dockerfile](4.2.2/Dockerfile))
- 4.2.1 ([4.2.1/Dockerfile](4.2.1/Dockerfile))
- 4.2.0 ([4.2.0/Dockerfile](4.2.0/Dockerfile))
- 4.1.12 ([4.1.12/Dockerfile](4.1.12/Dockerfile))
- 4.1.11 ([4.1.11/Dockerfile](4.1.11/Dockerfile))
- 4.1.10 ([4.1.10/Dockerfile](4.1.10/Dockerfile))
- 4.1.9 ([4.1.9/Dockerfile](4.1.9/Dockerfile))
- 4.1.8 ([4.1.8/Dockerfile](4.1.8/Dockerfile))

## Get the Docker image

### Pull image from dockerhub

```
docker pull mjstealey/irods-provider-postgres:latest
```

### Build image locally

```
cd irods-provider-postgres/4.2.4
docker build -t irods-provider-postgres:4.2.4 .
```

## Run the iRODS Provider

```
docker run -d --name provider mjstealey/irods-provider-postgres:4.2.4
```

- **Note**: This image is based from the [PostgreSQL Docker definition files](https://hub.docker.com/_/postgres/) which includes `EXPOSE 5432` (the postgres port), so standard container linking will make it automatically available to the linked containers. The default postgres user and database are created in the entrypoint with `initdb`.

## Running iCommands

Since iRODS is running inside of a Docker container, we need to issue iCommands from within the container's scope. This can be accomplished by either getting on the container as the `irods` user, or invoked from the host.

### On the container

```console
$ docker exec -ti -u irods provider /bin/bash
irods@9ca1f64052e0:~$ iadmin lz
tempZone
irods@9ca1f64052e0:~$ iadmin lr
bundleResc
demoResc
irods@9ca1f64052e0:~$ ilsresc -l
resource name: demoResc
id: 10014
zone: tempZone
type: unixfilesystem
class: cache
location: 9ca1f64052e0
vault: /var/lib/irods/iRODS/Vault
free space:
free space time: : Never
status:
info:
comment:
create time: 01526144986: 2018-05-12.17:09:46
modify time: 01526144986: 2018-05-12.17:09:46
context:
parent:
parent context:
irods@9ca1f64052e0:~$ ils
/tempZone/home/rods:
irods@9ca1f64052e0:~$
```

- **Note**: Since the hostname of the container was not explicitly set, Docker will issue a random ID which in this case is `9ca1f64052e0`. This could be problematic depending on use case and it is left to the user to assign a hostname that is meaningful to their setup.

### On the host

```console
$ docker exec -ti -u irods provider ilsresc -l
resource name: demoResc
id: 10014
zone: tempZone
type: unixfilesystem
class: cache
location: 9ca1f64052e0
vault: /var/lib/irods/iRODS/Vault
free space:
free space time: : Never
status:
info:
comment:
create time: 01526144986: 2018-05-12.17:09:46
modify time: 01526144986: 2018-05-12.17:09:46
context:
parent:
parent context:
```

## Environment Variables

The iRODS service has a multitude of configuration options available to it. The variables used during an installation of iRODS have been exposed to the user as settable environment variables and are honored at runtime.

### `IRODS_SERVICE_ACCOUNT_NAME`

Service account name - The account that will be in charge of running iRODS services. Default is `irods`.

### `IRODS_SERVICE_ACCOUNT_GROUP`

Service account group - The group that will be in charge of running iRODS services. Default is `irods`.

### `IRODS_SERVER_ROLE` (version 4.2.0+)

Catalog service role - The role of the node being deploy where `1` denotes an iRODS provider and `2` denotes an iRODS consumer. Default is `1`

### `ODBC_DRIVER_FOR_POSTGRES` (version 4.2.0+)

ODBC driver - For PostgreSQL where `1` is **PostgreSQL ANSI** and `2` is **PostgreSQL Unicode**. Default is `2`.

### `IRODS_DATABASE_SERVER_HOSTNAME`

Database server's hostname or IP - Location of where the PostgreSQL database is running. Default is `localhost`

### `IRODS_DATABASE_SERVER_PORT`

Database server's port - Port which PostgreSQL is listening on. Default is `5432`

### `IRODS_DATABASE_NAME`

Database name - Name used to service the iRODS catalog. Default is `ICAT`

### `IRODS_DATABASE_USER_NAME`

Database user - User that has owner rights on the iRODS catalog database in PostgreSQL. Default is `irods`

### `IRODS_DATABASE_PASSWORD`

Database password - Password for the user that has owner rights on the iRODS catalog database in PostgreSQL. Default is `temppassword`

### `IRODS_DATABASE_USER_PASSWORD_SALT` (version 4.2.0+)

Stored passwords salt - Random data that is used as an additional input to a one-way function that "hashes" data, a password or passphrase. Salts are closely related to the concept of nonce. Default is `tempsalt`

### `IRODS_ZONE_NAME`

Zone name - Logical namespace defining the extent of all resources managed in the iRODS catalog. Default is `tempZone`

### `IRODS_PORT`

Zone port - Port over which iRODS services are communicated. Default is `1247`

### `IRODS_PORT_RANGE_BEGIN`

Parallel port range (begin) - Beginning port of the range of ports used for parallel transfer. Default is `20000`

### `IRODS_PORT_RANGE_END`

Parallel port range (end) - Ending port of the range of ports used for parallel transfer. Default is `20199`

### `IRODS_CONTROL_PLANE_PORT`

Control plane port - Port over which iRODS grid control is communicated. Default is `1248`

### `IRODS_SCHEMA_VALIDATION`

Schema validation base URI - URI used to validate the iRODS schema on the server. Default is `file:///var/lib/irods/configuration_schemas`

### `IRODS_SERVER_ADMINISTRATOR_USER_NAME`

iRODS administrator username - Initial adminstrative user created in the iRODS zone. Default is `rods`

### `IRODS_SERVER_ZONE_KEY`

Zone key - Unique string of characters used to ID a particular zone. Default is `TEMPORARY_zone_key`

### `IRODS_SERVER_NEGOTIATION_KEY`

Negotiation key - 32 byte string used for inter-server communication. Default is `TEMPORARY_32byte_negotiation_key`

### `IRODS_CONTROL_PLANE_KEY`

Control plane key - 32 byte string used for inter-server communication. Default is `TEMPORARY__32byte_ctrl_plane_key`

### `IRODS_SERVER_ADMINISTRATOR_PASSWORD`

iRODS administrator password - Password for the initial adminstrative user created in the iRODS zone. Default is `rods`

### `IRODS_VAULT_DIRECTORY`

Vault directory - Physical location on disk associated with the creation of the initial unix filesystem resource named `demoResc`. Default is `/var/lib/irods/iRODS/Vault`

### `UID_POSTGRES`

UID of the postgres service account - This can be set to any available system UID. Default is `999`

### `GID_POSTGRES`

GID of the postgres service account - This can be set to any available system GID .Default is `999`

### `UID_IRODS`

UID of the irods service account - This can be set to any available system UID. Default is `998`

### `GID_IRODS`

GID of the irods service account - This can be set to any available system GID. Default is `998`

### `POSTGRES_USER`

This optional environment variable is used in conjunction with `POSTGRES_PASSWORD` to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of `postgres` will be used. Default is `postgres`

### `POSTGRES_PASSWORD`

This environment variable is recommended for you to use the PostgreSQL image. This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the `POSTGRES_USER` environment variable. Default is `postgres`

## Persisting data

The default behavior of Docker is to not persist it's data beyond the lifecycle of the container. This can be allieviated by mapping the data directories of the container to volumes on the host. The primary iRODS and PostgreSQL directories are designed to be volume mountable if the user so chooses.

### `/var/lib/irods`

iRODS home - Primary iRODS service files, including default location for the vault, logging and scripts. Ownership of files is based on the `UID_IRODS` and `GID_IRODS` settings.

### `/etc/irods`

iRODS configuration - Primary iRODS configuration files that are generated at runtime. Ownership of files is based on the `UID_IRODS` and `GID_IRODS` settings.

### `/var/lib/postgresql/data`

PostgreSQL data - Database service files and data files. Ownership of files is based on the `UID_POSTGRES` and `GID_POSTGRES` settings.

## Examples

### Simple

```
docker run -d --name provider \
  mjstealey/irods-provider-postgres:latest
```
This call has been daemonized (additional **-d** flag) which would most likely be used in an actual environment

On completion a running container named **provider** is spawned:

```console
$ docker ps
CONTAINER ID        IMAGE                                      COMMAND                  CREATED              STATUS              PORTS                                      NAMES
3d6855129ec7        mjstealey/irods-provider-postgres:latest   "/irods-docker-entry…"   About a minute ago   Up About a minute   1247-1248/tcp, 5432/tcp, 20000-20199/tcp   provider
```

Configuration is based on the default environment variables as defined above.

  **NOTE:** The `irods_host` value is set to the ID of the Docker container. This can be specified by the user at runtime using the `-h HOST_NAME` syntax.

### Persisting data

By sharing volumes from the host to the container, the user can persist data between container instances even if the original container definition is removed from the system.

Volumes to mount:

- **iRODS home**: map to `/var/lib/irods/` on the container
- **iRODS configuration**: map to `/etc/irods/` on the container
- **PostgreSQL data**: map to `/var/lib/postgresql/data/` on the container

SE Linux users should note that volume mounts may fail, and may require a `:z` or `:Z` at the end of their volume defintion.

- `-v $(pwd)/var_irods:/var/lib/irods:z`

It is also recommended to define a **hostname** for the container when persisting data as the hostname information is written to the data store on initialization.

1. Create volumes on the host:

	```
	mkdir var_irods  # map to /var/lib/irods/
	mkdir etc_irods  # map to /etc/irods/
	mkdir var_pgdata # map to /var/lib/postgresql/data/
	```

2. Run the docker container with the `-i` flag for **init**:

    ```
    docker run -d --name provider \
      -h irods-provider \
      -v $(pwd)/var_irods:/var/lib/irods \
      -v $(pwd)/etc_irods:/etc/irods \
      -v $(pwd)/var_pgdata:/var/lib/postgresql/data \
      mjstealey/irods-provider-postgres:latest
    ```

	Note, the host volumes now contain the relevant data to the iRODS deployment

    ```console
    $ ls -lh var_irods
    total 24
    -rw-------@  1 xxxxx  xxxxx   224B May 12 22:08 VERSION.json
    -rw-r--r--@  1 xxxxx  xxxxx   166B Nov  7  2017 VERSION.json.dist
    drwxr-xr-x@  4 xxxxx  xxxxx   128B May 12 13:06 clients
    drwxr-xr-x@  4 xxxxx  xxxxx   128B May 12 13:06 config
    drwxr-xr-x@  3 xxxxx  xxxxx    96B May 12 13:06 configuration_schemas
    drwx------@  3 xxxxx  xxxxx    96B May 12 22:08 iRODS
    -r-xr--r--@  1 xxxxx  xxxxx   283B Nov  7  2017 irodsctl
    drwxr-xr-x@  7 xxxxx  xxxxx   224B May 12 22:08 log
    drwxr-xr-x@  6 xxxxx  xxxxx   192B May 12 13:06 msiExecCmd_bin
    drwxr-xr-x@ 18 xxxxx  xxxxx   576B May 12 13:06 packaging
    drwxr-xr-x@ 22 xxxxx  xxxxx   704B May 12 13:06 scripts
    drwxr-xr-x@  4 xxxxx  xxxxx   128B May 12 13:06 test

    $ ls -lh etc_irods
    total 136
    -rw-r--r--@ 1 xxxxx  xxxxx   4.9K May 12 22:08 core.dvm
    -rw-r--r--@ 1 xxxxx  xxxxx   831B May 12 22:08 core.fnm
    -rw-r--r--@ 1 xxxxx  xxxxx    38K May 12 22:08 core.re
    -rw-r--r--@ 1 xxxxx  xxxxx   106B May 12 22:08 host_access_control_config.json
    -rw-r--r--@ 1 xxxxx  xxxxx    90B May 12 22:08 hosts_config.json
    -rw-------@ 1 xxxxx  xxxxx   3.4K May 12 22:08 server_config.json
    -rw-r--r--@ 1 xxxxx  xxxxx    64B May 12 22:07 service_account.config

    $ ls -lh var_pgdata
    total 104
    -rw-------@  1 xxxxx  xxxxx     3B May 12 22:07 PG_VERSION
    drwx------@  6 xxxxx  xxxxx   192B May 12 22:07 base
    drwx------@ 61 xxxxx  xxxxx   1.9K May 12 22:10 global
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_commit_ts
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_dynshmem
    -rw-------@  1 xxxxx  xxxxx   4.4K May 12 22:07 pg_hba.conf
    -rw-------@  1 xxxxx  xxxxx   1.6K May 12 22:07 pg_ident.conf
    drwx------@  5 xxxxx  xxxxx   160B May 12 22:07 pg_logical
    drwx------@  4 xxxxx  xxxxx   128B May 12 22:07 pg_multixact
    drwx------@  3 xxxxx  xxxxx    96B May 12 22:07 pg_notify
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_replslot
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_serial
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_snapshots
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_stat
    drwx------@  6 xxxxx  xxxxx   192B May 12 22:20 pg_stat_tmp
    drwx------@  3 xxxxx  xxxxx    96B May 12 22:07 pg_subtrans
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_tblspc
    drwx------@  2 xxxxx  xxxxx    64B May 12 22:07 pg_twophase
    drwx------@  4 xxxxx  xxxxx   128B May 12 22:07 pg_wal
    drwx------@  3 xxxxx  xxxxx    96B May 12 22:07 pg_xact
    -rw-------@  1 xxxxx  xxxxx    88B May 12 22:07 postgresql.auto.conf
    -rw-------@  1 xxxxx  xxxxx    22K May 12 22:07 postgresql.conf
    -rw-------@  1 xxxxx  xxxxx    36B May 12 22:07 postmaster.opts
    -rw-------@  1 xxxxx  xxxxx    95B May 12 22:07 postmaster.pid
    ```

	Go ahead and `iput` some data and verify it in the catalog.

    ```console
    $ docker exec -u irods provider iput VERSION.json
    $ docker exec -u irods provider ils -Lr
    /tempZone/home/rods:
      rods              0 demoResc          224 2018-05-13.02:24 & VERSION.json
            generic    /var/lib/irods/iRODS/Vault/home/rods/VERSION.json
    ```

	**Note**: The physical file can be found at: `$(pwd)/var_irods/iRODS/Vault/home/rods/VERSION.json` of the host

3. Stop and remove the provider container:

	```
	docker stop provider
	docker rm -fv provider
	```
	This destroys any host level definitions or default docker managed volumes related to the provider container and makes it impossible to recover the data from that container if we had not persisted it locally

4. Run a new docker container:

    ```
    docker run -d --name new-provider \
      -h irods-provider \
      -v $(pwd)/var_irods:/var/lib/irods \
      -v $(pwd)/etc_irods:/etc/irods \
      -v $(pwd)/var_pgdata:/var/lib/postgresql/data \
      mjstealey/irods-provider-postgres:latest
    ```
	Even though the name of the docker container was changed, the shared host volume mounts and the defined hostname that the container should use remained the same.

	Verify that the file put from the previous container has persisted on the new container instance.

    ```console
    $ docker exec -u irods new-provider ils -Lr
    /tempZone/home/rods:
      rods              0 demoResc          224 2018-05-13.02:24 & VERSION.json
            generic    /var/lib/irods/iRODS/Vault/home/rods/VERSION.json
    ```

### Real world usage

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

Because we want this to interact as a normal iRODS provider, we will need to specify the necessary port mappings for it to do so. specifically ports `1247`, `1248` and `20000-20199`.

Run this docker command from the same directory as the `irods-provider.env` file.

```
docker run -d --name provider \
  -h mjs-dev-1.edc.renci.org \
  --env-file=irods-provider.env \
  -v /var/provider/lib_irods:/var/lib/irods \
  -v /var/provider/etc_irods:/etc/irods \
  -v /var/provider/pg_data:/var/lib/postgresql/data \
  -p 1247:1247 \
  -p 1248:1248 \
  -p 20000-20199:20000-20199 \
  mjstealey/irods-provider-postgres:latest
```

Since the container is being run with the `-d` flag, progress can be monitored by using docker attach to attach a terminal to the `STDOUT` of the container.

```
docker attach --sig-proxy=false provider
```

Use `ctl-c` to exit when finished.

Output of docker ps should look something like:

```console
$ docker ps
CONTAINER ID        IMAGE                                      COMMAND                  CREATED             STATUS              PORTS                                                                              NAMES
f04993705973        mjstealey/irods-provider-postgres:latest   "/irods-docker-ent..."   27 seconds ago      Up 24 seconds       0.0.0.0:1247-1248->1247-1248/tcp, 0.0.0.0:20000-20199->20000-20199/tcp, 5432/tcp   provider
```

The container should also identify it's hostname as the same that you are running it on.

```console
$ docker exec provider hostname
mjs-dev-1.edc.renci.org
```

**Sample iCommands**

A true test of the system will be to log in from another machine, iinit as the `rods` user from the `mjs-dev-1.edc.renci.org` deployment, and see if iCommands work as they should.

In this example we will be using `galera-1.edc.renci.org` as the other machine that has our iRODS deployment within it's network scope (on the same VLAN).

From `galera-1.edc.renci.org`:

```console
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

```console
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

```console
$ sudo ls -alh /var/provider/lib_irods/iRODS/Vault/home/rods
total 10M
drwxr-x--- 2 xxxxx xxxxx 26 Nov 10 13:34 .
drwxr-x--- 3 xxxxx xxxxx 17 Nov 10 13:23 ..
-rw------- 1 xxxxx xxxxx 10M Nov 10 13:34 test-file.dat
```

All other interactions that one would normally have wtih an iRODS provider should hold true for the Docker implementation.

Since the critical files are persisted to the host, adjustment to files such as `/etc/irods/server_config.json` could instead be done at `/var/provider/etc_irods/server_config.json` so long as the appropriate file access permissions are adhered to.

## Additional information

The provided examples all use the `-d` flag to daemonize the docker container. The output that would normally be displayed to `STDOUT` of the container is therefore suppressed.

Output example for [iRODS provider v4.2.2](example-output/example-output-4.2.2.md)

### iRODS provider in Docker notes

- 4.2.2 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (16.04 Xenial iRODS packages)
- 4.2.1 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (14.04 Trusty iRODS packages)
- 4.2.0 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (14.04 Trusty iRODS packages)
- 4.1.11 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (14.04 Trusty iRODS ftp deb files)
- 4.1.10 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (14.04 Trusty iRODS ftp deb files)
- 4.1.9 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (14.04 Trusty iRODS ftp deb files)
- 4.1.8 - Debian:stretch based using [PostgreSQL 10](https://github.com/docker-library/postgres/blob/6fe8c15843400444e4ba6906ec6f94b0d526a678/10/Dockerfile) (14.04 Trusty iRODS ftp deb files)
