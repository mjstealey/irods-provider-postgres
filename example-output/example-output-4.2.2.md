# Example docker output for v4.2.2 initialization

Example output from running the container in non-daemonized mode and using default configuration settings.

```
docker run --name provider \
  -h my.irods.local \
  -v $(pwd)/var_irods:/var/lib/irods \
  -v $(pwd)/etc_irods:/etc/irods \
  -v $(pwd)/var_pgdata:/var/lib/postgresql/data \
  mjstealey/irods-provider-postgres:latest
```

From console:

```console
$ docker run --name provider \
  -h my.irods.local \
  -v $(pwd)/var_irods:/var/lib/irods \
  -v $(pwd)/etc_irods:/etc/irods \
  -v $(pwd)/var_pgdata:/var/lib/postgresql/data \
  mjstealey/irods-provider-postgres:latest
!!! populating /var/lib/irods with initial contents !!!
./
./test/
./test/filesystem/
./test/filesystem/mapping.txt
./test/filesystem/make_sector_mapping_table.py
./test/filesystem/setup_fs.sh
./test/filesystem/teardown_fs.sh
./test/test_framework_configuration.json
./configuration_schemas/
./configuration_schemas/v3/
./configuration_schemas/v3/zone_bundle.json
./configuration_schemas/v3/database_config.json
./configuration_schemas/v3/plugin.json
./configuration_schemas/v3/rule_engine.json
./configuration_schemas/v3/VERSION.json
./configuration_schemas/v3/service_account_environment.json
./configuration_schemas/v3/client_hints.json
./configuration_schemas/v3/server_status.json
./configuration_schemas/v3/host_access_control_config.json
./configuration_schemas/v3/resource.json
./configuration_schemas/v3/client_environment.json
./configuration_schemas/v3/hosts_config.json
./configuration_schemas/v3/configuration_directory.json
./configuration_schemas/v3/server_config.json
./configuration_schemas/v3/server.json
./configuration_schemas/v3/grid_status.json
./packaging/
./packaging/localhost_setup_postgres.input
./packaging/find_os.sh
./packaging/hosts_config.json.template
./packaging/upgrade-3.3.xto4.0.0.sql
./packaging/sql/
./packaging/sql/icatSysTables.sql
./packaging/sql/icatDropSysTables.sql
./packaging/sql/icatSysInserts.sql
./packaging/sql/icatPurgeRecycleBin.sql
./packaging/irodsMonPerf.config.in
./packaging/server_setup_instructions.txt
./packaging/database_config.json.template
./packaging/preremove.sh
./packaging/core.re.template
./packaging/core.fnm.template
./packaging/postinstall.sh
./packaging/server_config.json.template
./packaging/host_access_control_config.json.template
./packaging/connectControl.config.template
./packaging/core.dvm.template
./scripts/
./scripts/kill_pid.py
./scripts/get_irods_version.py
./scripts/pid_age.py
./scripts/system_identification.py
./scripts/terminate_irods_processes.py
./scripts/manual_cleanup.py
./scripts/run_cppcheck.sh
./scripts/switchuser.py
./scripts/irods/
./scripts/irods/pyparsing.py
./scripts/irods/core_file.py
./scripts/irods/setup_options.py
./scripts/irods/paths.pyc
./scripts/irods/test/
./scripts/irods/test/test_resource_configuration.py
./scripts/irods/test/test_imeta_help.py
./scripts/irods/test/rule_texts_for_tests.py
./scripts/irods/test/test_auth.py
./scripts/irods/test/test_irmdir.py
./scripts/irods/test/session.py
./scripts/irods/test/test_iadmin.py
./scripts/irods/test/test_ireg.py
./scripts/irods/test/test_catalog.py
./scripts/irods/test/test_iticket.py
./scripts/irods/test/test_native_rule_engine_plugin.py
./scripts/irods/test/test_iscan.py
./scripts/irods/test/test_irodsctl.py
./scripts/irods/test/test_client_hints.py
./scripts/irods/test/test_resource_tree.py
./scripts/irods/test/test_chunkydevtest.py
./scripts/irods/test/test_icommands_file_operations.py
./scripts/irods/test/metaclass_unittest_test_case_generator.py
./scripts/irods/test/test_ils.py
./scripts/irods/test/test_all_rules.py
./scripts/irods/test/test_federation.py
./scripts/irods/test/test_iput_options.py
./scripts/irods/test/README
./scripts/irods/test/__init__.py
./scripts/irods/test/test_igroupadmin.py
./scripts/irods/test/test_ichmod.py
./scripts/irods/test/command.py
./scripts/irods/test/test_quotas.py
./scripts/irods/test/test_iquest.py
./scripts/irods/test/test_xmsg.py
./scripts/irods/test/resource_suite.py
./scripts/irods/test/test_faulty_filesystem.py
./scripts/irods/test/test_load_balanced_suite.py
./scripts/irods/test/test_ipasswd.py
./scripts/irods/test/test_imeta_set.py
./scripts/irods/test/test_iphymv.py
./scripts/irods/test/settings.py
./scripts/irods/test/test_resource_types.py
./scripts/irods/test/test_rulebase.py
./scripts/irods/test/test_compatibility.py
./scripts/irods/test/test_control_plane.py
./scripts/irods/test/test_irsync.py
./scripts/irods/six.py
./scripts/irods/__init__.pyc
./scripts/irods/lib.py
./scripts/irods/controller.py
./scripts/irods/exceptions.py
./scripts/irods/password_obfuscation.py
./scripts/irods/convert_configuration_to_json.py
./scripts/irods/__init__.py
./scripts/irods/paths.py
./scripts/irods/log.py
./scripts/irods/configuration.py
./scripts/irods/database_upgrade.py
./scripts/irods/database_interface.py
./scripts/irods/database_connect.py
./scripts/irods/json_validation.py
./scripts/irods/pypyodbc.py
./scripts/irods/upgrade_configuration.py
./scripts/irods/start_options.py
./scripts/make_resource_tree.py
./scripts/setup_irods.py
./scripts/validate_json.py
./scripts/get_db_schema_version.py
./scripts/run_tests.py
./scripts/find_shared_object.py
./scripts/rulebase_fastswap_test_2276.sh
./scripts/cleanup_resource_tree.py
./scripts/chown_directories_for_postinstall.py
./scripts/run_coverage_test.sh
./scripts/irods_control.py
./config/
./config/packedRei/
./config/lockFileDir/
./VERSION.json.dist
./clients/
./clients/bin/
./clients/bin/genOSAuth
./clients/icommands/
./clients/icommands/test/
./clients/icommands/test/misc/
./clients/icommands/test/misc/load-metadata.txt
./clients/icommands/test/misc/email.tag
./clients/icommands/test/misc/sample.email
./clients/icommands/test/misc/devtestuser-account-ACL.txt
./clients/icommands/test/misc/load-usermods.txt
./clients/icommands/test/rules/
./clients/icommands/test/rules/rulemsiPrintGenQueryOutToBuffer.r
./clients/icommands/test/rules/ruleintegrityACL.r
./clients/icommands/test/rules/rulemsiAddSelectFieldToGenQuery.r
./clients/icommands/test/rules/rulemsiDataObjUnlink-trash.r
./clients/icommands/test/rules/rulemsiExtractTemplateMDFromBuf.r
./clients/icommands/test/rules/rulemsiMergeDataCopies.r
./clients/icommands/test/rules/rulemsiGetMoreRows.r
./clients/icommands/test/rules/rulemsiSetDataObjAvoidResc.r
./clients/icommands/test/rules/test_no_memory_error_patch_2242.r
./clients/icommands/test/rules/rulemsiXmlDocSchemaValidate.r
./clients/icommands/test/rules/rulemsiobjput_z3950.r
./clients/icommands/test/rules/rulemsiGetSystemTime.r
./clients/icommands/test/rules/rulemsiStrchop.r
./clients/icommands/test/rules/ruleprint_hello.r
./clients/icommands/test/rules/rulemsiHumanToSystemTime.r
./clients/icommands/test/rules/rulemsiGetContInxFromGenQueryOut.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByActionID.r
./clients/icommands/test/rules/rulemsiobjget_test.r
./clients/icommands/test/rules/rulemsiDataObjUnlink.r
./clients/icommands/test/rules/rulemsiGetCollectionPSmeta.r
./clients/icommands/test/rules/rulemsiStrCat.r
./clients/icommands/test/rules/rulewriteBytesBuf.r
./clients/icommands/test/rules/rulemsiCollRsync.r
./clients/icommands/test/rules/rulemsiCopyAVUMetadata.r
./clients/icommands/test/rules/rulemsiStrArray2String.r
./clients/icommands/test/rules/rulemsiCollectionSpider.r
./clients/icommands/test/rules/rulemsiGetDataObjACL.r
./clients/icommands/test/rules/rulemsiSetMultiReplPerResc.r
./clients/icommands/test/rules/rulemsiobjget_slink.r
./clients/icommands/test/rules/rulemsiobjget_irods.r
./clients/icommands/test/rules/rulemsiObjByName.r
./clients/icommands/test/rules/rulemsiMakeGenQuery.r
./clients/icommands/test/rules/rulemsiSortDataObj.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByUserID.r
./clients/icommands/test/rules/rulemsiGetStdoutInExecCmdOut.r
./clients/icommands/test/rules/rulemsiSetResource.r
./clients/icommands/test/rules/ruleintegrityAVU.r
./clients/icommands/test/rules/rulemsiXmsgServerConnect.r
./clients/icommands/test/rules/rulemsiGetDataObjAVUs.r
./clients/icommands/test/rules/rulemsiFtpGet.r
./clients/icommands/test/rules/rulemsiMakeQuery.r
./clients/icommands/test/rules/rulemsiDataObjPhymv.r
./clients/icommands/test/rules/rulemsiSysChksumDataObj.r
./clients/icommands/test/rules/rulewriteString.r
./clients/icommands/test/rules/rulemsiCommit.r
./clients/icommands/test/rules/rulemsiGetDataObjAIP.r
./clients/icommands/test/rules/rulemsiobjput_irods.r
./clients/icommands/test/rules/rulemsiDataObjLseek.r
./clients/icommands/test/rules/rulemsiLoadMetadataFromXml.r
./clients/icommands/test/rules/rulemsiServerMonPerf.r
./clients/icommands/test/rules/rulemsiCreateUser.r
./clients/icommands/test/rules/rulemsiFlagInfectedObjs.r
./clients/icommands/test/rules/rulemsiPhyPathReg.r
./clients/icommands/test/rules/rulemsiDataObjRsync.r
./clients/icommands/test/rules/rulewritePosInt.r
./clients/icommands/test/rules/rulemsiSetReplComment.r
./clients/icommands/test/rules/rulemsiGetFormattedSystemTime-human.r
./clients/icommands/test/rules/rulemsiDataObjChksum.r
./clients/icommands/test/rules/rulemsiFreeBuffer.r
./clients/icommands/test/rules/rulemsiGetDiffTime.r
./clients/icommands/test/rules/rulemsiSetDataObjPreferredResc.r
./clients/icommands/test/rules/rulemsiObjStat.r
./clients/icommands/test/rules/rulemsiWriteRodsLog.r
./clients/icommands/test/rules/rulemsiExecCmd.r
./clients/icommands/test/rules/rulemsiSysReplDataObj.r
./clients/icommands/test/rules/rulemsiTwitterPost.r
./clients/icommands/test/rules/rulemsiSetRandomScheme.r
./clients/icommands/test/rules/rulemsiSetACL.r
./clients/icommands/test/rules/testsuiteForLcov.r
./clients/icommands/test/rules/rulemsiDataObjCreate.r
./clients/icommands/test/rules/rulemsiSetRescQuotaPolicy.r
./clients/icommands/test/rules/rulemsiXsltApply.r
./clients/icommands/test/rules/rulemsiGetStderrInExecCmdOut.r
./clients/icommands/test/rules/rulemsiExecStrCondQuery.r
./clients/icommands/test/rules/rulemsiSplitPath.r
./clients/icommands/test/rules/rulemsiSetReServerNumProc.r
./clients/icommands/test/rules/rulemsiDeleteUser.r
./clients/icommands/test/rules/rulemsiSetBulkPutPostProcPolicy.r
./clients/icommands/test/rules/ruleintegrityFileSize.r
./clients/icommands/test/rules/rulemsiOprDisallowed.r
./clients/icommands/test/rules/rulemsiPrintKeyValPair.r
./clients/icommands/test/rules/rulegenerateBagIt.r
./clients/icommands/test/rules/rulemsiSendMail.r
./clients/icommands/test/rules/testsuite2.r
./clients/icommands/test/rules/rulemsiSubstr.r
./clients/icommands/test/rules/rulemsiPropertiesSet.r
./clients/icommands/test/rules/rulemsiCheckPermission.r
./clients/icommands/test/rules/rulemsiDataObjOpen.r
./clients/icommands/test/rules/rulemsiSetDataType.r
./clients/icommands/test/rules/rulemsiz3950Submit.r
./clients/icommands/test/rules/rulemsiSetDataTypeFromExt.r
./clients/icommands/test/rules/rulemsiIsColl.r
./clients/icommands/test/rules/rulemsiString2StrArray.r
./clients/icommands/test/rules/rulemsiCheckOwner.r
./clients/icommands/test/rules/rulemsiRemoveKeyValuePairsFromObj.r
./clients/icommands/test/rules/rulemsiDataObjGet.r
./clients/icommands/test/rules/rulemsiDataObjTrim.r
./clients/icommands/test/rules/rulemsiCollRepl.r
./clients/icommands/test/rules/rulemsiRenameLocalZone.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByTimeStamp.r
./clients/icommands/test/rules/rulemsiobjget_srb.r
./clients/icommands/test/rules/rulemsiDataObjRename.r
./clients/icommands/test/rules/rulemsiNoTrashCan.r
./clients/icommands/test/rules/rulemsiGetCollectionSize.r
./clients/icommands/test/rules/rulemsiSetPublicUserOpr.r
./clients/icommands/test/rules/ruleintegrityDataType.r
./clients/icommands/test/rules/rulemsiSysMetaModify.r
./clients/icommands/test/rules/rulemsiExecGenQuery.r
./clients/icommands/test/rules/rulemsiRmColl.r
./clients/icommands/test/rules/rulemsiDataObjCopy.r
./clients/icommands/test/rules/rulemsiImageConvert-no-properties.r
./clients/icommands/test/rules/rulemsiSetDefaultResc.r
./clients/icommands/test/rules/rulemsiobjput_test.r
./clients/icommands/test/rules/rulemsiDeleteCollByAdmin.r
./clients/icommands/test/rules/rulemsiGetFormattedSystemTime.r
./clients/icommands/test/rules/rulemsiSetGraftPathScheme.r
./clients/icommands/test/rules/rulemsiobjget_z3950.r
./clients/icommands/test/rules/rulemsiPropertiesExists.r
./clients/icommands/test/rules/rulemsiStrlen.r
./clients/icommands/test/rules/rulemsiTarFileCreate.r
./clients/icommands/test/rules/rulereadXMsg.r
./clients/icommands/test/rules/rulemsiGoodFailure.r
./clients/icommands/test/rules/rulemsiCollCreate.r
./clients/icommands/test/rules/rulemsiRegisterData.r
./clients/icommands/test/rules/rulemsiSendXmsg.r
./clients/icommands/test/rules/ruleintegrityAVUvalue.r
./clients/icommands/test/rules/rulemsiLoadMetadataFromDataObj.r
./clients/icommands/test/rules/rulemsiPropertiesNew.r
./clients/icommands/test/rules/rulemsiQuota.r
./clients/icommands/test/rules/rulemsiPropertiesAdd.r
./clients/icommands/test/rules/rulemsiSetQuota.r
./clients/icommands/test/rules/rulemsiPropertiesClear.r
./clients/icommands/test/rules/rulemsiStripAVUs.r
./clients/icommands/test/rules/rulemsiRenameCollection.r
./clients/icommands/test/rules/ruleTestChangeSessionVar.r
./clients/icommands/test/rules/rulemsiGetObjectPath.r
./clients/icommands/test/rules/rulemsiApplyDCMetadataTemplate.r
./clients/icommands/test/rules/rulemsiRcvXmsg.r
./clients/icommands/test/rules/rulemsiConvertCurrency.r
./clients/icommands/test/rules/rulemsiXmsgServerDisConnect.r
./clients/icommands/test/rules/rulemsiDataObjRepl.r
./clients/icommands/test/rules/rulemsiRecursiveCollCopy.r
./clients/icommands/test/rules/rulemsiAddKeyValToMspStr.r
./clients/icommands/test/rules/rulemsiAddUserToGroup.r
./clients/icommands/test/rules/rulemsiPrintGenQueryInp.r
./clients/icommands/test/rules/rulemsiDoSomething.r
./clients/icommands/test/rules/rulemsiCheckAccess.r
./clients/icommands/test/rules/rulemsiAssociateKeyValuePairsToObj.r
./clients/icommands/test/rules/rulemsiGetCollectionContentsReport.r
./clients/icommands/test/rules/rulemsiStoreVersionWithTS.r
./clients/icommands/test/rules/rulemsiSdssImgCutout_GetJpeg.r
./clients/icommands/test/rules/rulemsiCreateUserAccountsFromDataObj.r
./clients/icommands/test/rules/rulemsiCheckHostAccessControl.r
./clients/icommands/test/rules/rulemsiDataObjClose.r
./clients/icommands/test/rules/rulemsiGetCollectionPSmeta-null.r
./clients/icommands/test/rules/rulemsiGetUserACL.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByKeywords.r
./clients/icommands/test/rules/rulemsiPropertiesClone.r
./clients/icommands/test/rules/rulemsiGetQuote.r
./clients/icommands/test/rules/rulemsiSplitPathByKey.r
./clients/icommands/test/rules/rulemsiSetRescSortScheme.r
./clients/icommands/test/rules/rulemsiGetTaggedValueFromString.r
./clients/icommands/test/rules/nqueens.r
./clients/icommands/test/rules/rulemsiCreateXmsgInp.r
./clients/icommands/test/rules/rulewriteLine.r
./clients/icommands/test/rules/rulemsiImageGetProperties.r
./clients/icommands/test/rules/rulemsiGetCollectionACL.r
./clients/icommands/test/rules/rulemsiXmsgCreateStream.r
./clients/icommands/test/rules/rulemsiobjput_srb.r
./clients/icommands/test/rules/rulemsiDeleteUnusedAVUs.r
./clients/icommands/test/rules/rulemsiIsData.r
./clients/icommands/test/rules/rulemsiExit.r
./clients/icommands/test/rules/rulemsiSleep.r
./clients/icommands/test/rules/rulemsiFlagDataObjwithAVU.r
./clients/icommands/test/rules/rulemsiRollback.r
./clients/icommands/test/rules/rulemsiAddConditionToGenQuery.r
./clients/icommands/test/rules/testsuite1.r
./clients/icommands/test/rules/rulemsiPropertiesFromString.r
./clients/icommands/test/rules/rulemsiStrToBytesBuf.r
./clients/icommands/test/rules/rulemsiImageConvert.r
./clients/icommands/test/rules/rulemsiPhyBundleColl.r
./clients/icommands/test/rules/rulemsiobjput_slink.r
./clients/icommands/test/rules/rulemsiPropertiesToString.r
./clients/icommands/test/rules/rulemsiAclPolicy.r
./clients/icommands/test/rules/rulemsiGetValByKey.r
./clients/icommands/test/rules/rulemsiCreateCollByAdmin.r
./clients/icommands/test/rules/rulemsiGetIcatTime.r
./clients/icommands/test/rules/rulemsiobjget_http.r
./clients/icommands/test/rules/rulemsiStageDataObj.r
./clients/icommands/test/rules/rulemsiIp2location.r
./clients/icommands/test/rules/ruleintegrityFileOwner.r
./clients/icommands/test/rules/ruleintegrityExpiry.r
./clients/icommands/test/rules/rulemsiSetNumThreads.r
./clients/icommands/test/rules/rulemsiStructFileBundle.r
./clients/icommands/test/rules/rulemsiPropertiesRemove.r
./clients/icommands/test/rules/rulemsiString2KeyValPair.r
./clients/icommands/test/rules/rulemsiExtractNaraMetadata.r
./clients/icommands/test/rules/rulewriteKeyValPairs.r
./clients/icommands/test/rules/rulemsiListEnabledMS.r
./clients/icommands/test/rules/rulemsiGetUserInfo.r
./clients/icommands/test/rules/rulemsiGetSessionVarValue.r
./clients/icommands/test/rules/rulemsiPropertiesGet.r
./clients/icommands/test/rules/rulemsiTarFileExtract.r
./clients/icommands/test/rules/rulemsiDataObjWrite.r
./clients/icommands/test/rules/rulemsiGetDataObjPSmeta.r
./clients/icommands/test/rules/rulemsiReadMDTemplateIntoTagStruct.r
./clients/icommands/test/rules/rulemsiDataObjPut.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByObjectID.r
./clients/icommands/test/rules/rulemsiSetNoDirectRescInp.r
./clients/icommands/test/rules/rulemsiDeleteDisallowed.r
./clients/icommands/test/rules/rulewriteXMsg.r
./clients/icommands/test/rules/rulemsiDataObjRead.r
./clients/icommands/test/rules/rulemsiLoadUserModsFromDataObj.r
./clients/icommands/test/rules/rulemsiGetObjType.r
./clients/icommands/test/rules/rulemsiNoChkFilePathPerm.r
./clients/icommands/test/rules/testsuite3.r
./clients/icommands/test/rules/rulemsiobjput_http.r
./clients/icommands/test/rules/rulemsiImageConvert-compression.r
./clients/icommands/test/rules/rulemsiDeleteUsersFromDataObj.r
./clients/icommands/test/rules/rulemsiGuessDataType.r
./clients/icommands/test/rules/rulemsiLoadACLFromDataObj.r
./clients/icommands/test/rules/rulemsiDigestMonStat.r
./clients/icommands/test/rules/rulemsiAddKeyVal.r
./clients/icommands/test/rules/rulemsiExportRecursiveCollMeta.r
./clients/icommands/test/rules/rulemsiFlushMonStat.r
./log/
./msiExecCmd_bin/
./msiExecCmd_bin/irodsServerMonPerf
./msiExecCmd_bin/hello
./msiExecCmd_bin/test_execstream.py
./msiExecCmd_bin/univMSSInterface.sh
./irodsctl
!!! populating /var/lib/postgresql/data with initial contents !!!
./
usermod: no changes
usermod: no changes
Postgres is unavailable - sleeping
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
running bootstrap script ... Postgres is unavailable - sleeping
ok
performing post-bootstrap initialization ... Postgres is unavailable - sleeping
Postgres is unavailable - sleeping
Postgres is unavailable - sleeping
ok
syncing data to disk ... Postgres is unavailable - sleeping

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
ok

Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

waiting for server to start....2018-05-13 02:37:37.933 UTC [74] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2018-05-13 02:37:38.047 UTC [75] LOG:  database system was shut down at 2018-05-13 02:37:34 UTC
2018-05-13 02:37:38.083 UTC [74] LOG:  database system is ready to accept connections
 done
server started
ALTER ROLE


/postgres-docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

2018-05-13 02:37:38.242 UTC [74] LOG:  received fast shutdown request
waiting for server to shut down...2018-05-13 02:37:38.244 UTC [74] LOG:  aborting any active transactions
.2018-05-13 02:37:38.249 UTC [74] LOG:  worker process: logical replication launcher (PID 81) exited with exit code 1
2018-05-13 02:37:38.249 UTC [76] LOG:  shutting down
2018-05-13 02:37:38.312 UTC [74] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2018-05-13 02:37:38.377 UTC [28] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2018-05-13 02:37:38.377 UTC [28] LOG:  listening on IPv6 address "::", port 5432
2018-05-13 02:37:38.385 UTC [28] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2018-05-13 02:37:38.507 UTC [94] FATAL:  the database system is starting up
Postgres is unavailable - sleeping
2018-05-13 02:37:38.514 UTC [93] LOG:  database system was shut down at 2018-05-13 02:37:38 UTC
2018-05-13 02:37:38.563 UTC [28] LOG:  database system is ready to accept connections
2018-05-13 02:37:40.553 UTC [103] FATAL:  role "root" does not exist
CREATE USER irods WITH PASSWORD 'temppassword';
CREATE DATABASE "ICAT";
GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods;
CREATE USER irods WITH PASSWORD 'temppassword';
CREATE ROLE
CREATE DATABASE "ICAT";
CREATE DATABASE
GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods;
GRANT
Updating /var/lib/irods/VERSION.json...
The iRODS service account name needs to be defined.
iRODS user [irods]:
iRODS group [irods]:

+--------------------------------+
| Setting up the service account |
+--------------------------------+

Existing Group Detected: irods
Existing Account Detected: irods
Setting owner of /var/lib/irods to irods:irods
Setting owner of /etc/irods to irods:irods
iRODS server's role:
1. provider
2. consumer
Please select a number or choose 0 to enter a new value [1]:
Updating /etc/irods/server_config.json...

+-----------------------------------------+
| Configuring the database communications |
+-----------------------------------------+

You are configuring an iRODS database plugin. The iRODS server cannot be started until its database has been properly configured.

ODBC driver for postgres:
1. PostgreSQL ANSI
2. PostgreSQL Unicode
Please select a number or choose 0 to enter a new value [1]:
Database server's hostname or IP address [localhost]:
Database server's port [5432]:
Database name [ICAT]:
Database username [irods]:

-------------------------------------------
Database Type: postgres
ODBC Driver:   PostgreSQL Unicode
Database Host: localhost
Database Port: 5432
Database Name: ICAT
Database User: irods
-------------------------------------------

Please confirm [yes]: Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.


Updating /etc/irods/server_config.json...
Listing database tables...
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.

Updating /etc/irods/server_config.json...

+--------------------------------+
| Configuring the server options |
+--------------------------------+

iRODS server's zone name [tempZone]:
iRODS server's port [1247]:
iRODS port range (begin) [20000]:
iRODS port range (end) [20199]:
Control Plane port [1248]:
Schema Validation Base URI (or off) [file:///var/lib/irods/configuration_schemas]:
iRODS server's administrator username [rods]:

-------------------------------------------
Zone name:                  tempZone
iRODS server port:          1247
iRODS port range (begin):   20000
iRODS port range (end):     20199
Control plane port:         1248
Schema validation base URI: file:///var/lib/irods/configuration_schemas
iRODS server administrator: rods
-------------------------------------------

Please confirm [yes]: Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.




Updating /etc/irods/server_config.json...

+-----------------------------------+
| Setting up the client environment |
+-----------------------------------+

Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.



Updating /var/lib/irods/.irods/irods_environment.json...

+--------------------------+
| Setting up default vault |
+--------------------------+

iRODS Vault directory [/var/lib/irods/Vault]:

+-------------------------+
| Setting up the database |
+-------------------------+

Listing database tables...
Creating database tables...

+-------------------+
| Starting iRODS... |
+-------------------+

Validating [/var/lib/irods/.irods/irods_environment.json]... Success
Validating [/var/lib/irods/VERSION.json]... Success
Validating [/etc/irods/server_config.json]... Success
Validating [/etc/irods/host_access_control_config.json]... Success
Validating [/etc/irods/hosts_config.json]... Success
Ensuring catalog schema is up-to-date...
Updating to schema version 2...
Updating to schema version 3...
Updating to schema version 4...
Updating to schema version 5...
Catalog schema is up-to-date.
Starting iRODS server...
Success

+---------------------+
| Attempting test put |
+---------------------+

Putting the test file into iRODS...
Getting the test file from iRODS...
Removing the test file from iRODS...
Success.

+--------------------------------+
| iRODS is installed and running |
+--------------------------------+

usermod: no changes
usermod: no changes
```
