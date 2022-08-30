#!/bin/sh

# Set archive log mode and enable GG replication
ORACLE_SID=ORCLCDB
export ORACLE_SID
sqlplus /nolog <<- EOF
	CONNECT sys/oracle AS SYSDBA
	alter system set db_recovery_file_dest_size = 5G;
	alter system set db_recovery_file_dest = '/opt/oracle/oradata/recovery_area' scope=spfile;
	shutdown immediate
	startup mount
	alter database archivelog;
	alter database open;
        -- Should show "Database log mode: Archive Mode"
	archive log list
	exit;
EOF

# Enable LogMiner required database features/settings
sqlplus sys/oracle@//localhost:1521/ORCLCDB as sysdba <<- 'EOF'
  ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
  ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
   	 SELECT SUPPLEMENTAL_LOG_DATA_MIN min,
   	        SUPPLEMENTAL_LOG_DATA_PK pk,
   	        SUPPLEMENTAL_LOG_DATA_UI ui,
   	        SUPPLEMENTAL_LOG_DATA_FK fk,
   	        SUPPLEMENTAL_LOG_DATA_ALL "all"
   	     from v$database;
  ALTER PROFILE DEFAULT LIMIT FAILED_LOGIN_ATTEMPTS UNLIMITED;
  exit;
EOF

# Create Log Miner Tablespace and User
sqlplus sys/oracle@//localhost:1521/ORCLCDB as sysdba <<- EOF
  CREATE TABLESPACE LOGMINER_TBS DATAFILE '/opt/oracle/oradata/ORCLCDB/logminer_tbs.dbf' SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
  exit;
EOF

sqlplus sys/oracle@//localhost:1521/ORCLPDB1 as sysdba <<- EOF
  CREATE TABLESPACE LOGMINER_TBS DATAFILE '/opt/oracle/oradata/ORCLCDB/ORCLPDB1/logminer_tbs.dbf' SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
  exit;
EOF

sqlplus sys/oracle@//localhost:1521/ORCLCDB as sysdba <<- EOF
  CREATE USER c##dbzuser IDENTIFIED BY dbz DEFAULT TABLESPACE LOGMINER_TBS QUOTA UNLIMITED ON LOGMINER_TBS CONTAINER=ALL;
  GRANT CREATE SESSION TO c##dbzuser CONTAINER=ALL;
  GRANT SET CONTAINER TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$DATABASE TO c##dbzuser CONTAINER=ALL;
  GRANT FLASHBACK ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT_CATALOG_ROLE TO c##dbzuser CONTAINER=ALL;
  GRANT EXECUTE_CATALOG_ROLE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY TRANSACTION TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY DICTIONARY TO c##dbzuser CONTAINER=ALL;
  GRANT LOGMINING TO c##dbzuser CONTAINER=ALL;
  GRANT CREATE TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT LOCK ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT CREATE SEQUENCE TO c##dbzuser CONTAINER=ALL;
  GRANT EXECUTE ON DBMS_LOGMNR TO c##dbzuser CONTAINER=ALL;
  GRANT EXECUTE ON DBMS_LOGMNR_D TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGMNR_LOGS TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGMNR_CONTENTS TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGFILE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$ARCHIVED_LOG TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$ARCHIVE_DEST_STATUS TO c##dbzuser CONTAINER=ALL;
  exit;
EOF

sqlplus sys/oracle@//localhost:1521/ORCLPDB1 as sysdba <<- EOF
  CREATE USER C##TESTUSR IDENTIFIED BY pass;
  GRANT CONNECT TO C##TESTUSR;
  GRANT CREATE SESSION TO C##TESTUSR;
  GRANT CREATE TABLE TO C##TESTUSR;
  GRANT CREATE SEQUENCE to C##TESTUSR;
  GRANT CREATE TYPE to C##TESTUSR;
  ALTER USER C##TESTUSR QUOTA 100M on users;
  exit;
EOF