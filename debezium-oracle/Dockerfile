FROM doctorkirk/oracle-19c

WORKDIR /opt/oracle/oradata

WORKDIR /opt/oracle/oradata/recovery_area

WORKDIR /opt/oracle/oradata/ORCLCDB
WORKDIR /opt/oracle/oradata/ORCLCDB/ORCLPDB1/

WORKDIR /u01/app/oracle/product/19c/dbhome_1/inventory
WORKDIR /u01/app/oracle/product/19c/dbhome_1/bin

#Running my custom scripts
COPY setup-logminer.sh /opt/oracle/scripts/extensions/startup/

RUN chgrp 54321 /opt/oracle/oradata
RUN chown 54321 /opt/oracle/oradata

RUN chgrp 54321 /opt/oracle/oradata/recovery_area
RUN chown 54321 /opt/oracle/oradata/recovery_area

RUN chgrp 54321 /u01/app/oracle/product/19c/dbhome_1/inventory
RUN chown 54321 /u01/app/oracle/product/19c/dbhome_1/inventory

RUN chgrp 54321 /u01/app/oracle/product/19c/dbhome_1/bin
RUN chown 54321 /u01/app/oracle/product/19c/dbhome_1/bin