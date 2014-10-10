#!/bin/bash
HOSTNAME="localhost"
PORT="3306"  
USERNAME="root" 
PASSWORD="rdcenter123"
DBNAME="bladefs_admin"
TABLE_EXCEPTION_INFO="exception_info"
TABLE_DS_DATA_SUM="ds_data_sum"
TABLE_DS_DATA_STAT="ds_data_stat"


timestamp=`date +%s`
#35 days ago
ago=$[timestamp-3024000]

clear_exception_info="delete from ${TABLE_EXCEPTION_INFO} where timestamp < ${ago}"
clear_ds_data_sum="delete from ${TABLE_DS_DATA_SUM} where timestamp < ${ago}"
clear_ds_data_stat="delete from ${TABLE_DS_DATA_STAT} where timestamp < ${ago}"


mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e"${clear_exception_info}" > test.txt
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e"${clear_ds_data_sum}" > test.txt
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e"${clear_ds_data_stat}" > test.txt

