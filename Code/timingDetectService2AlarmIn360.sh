#!/bin/bash

IPLIST=("10.108.82.163" "10.108.82.164" "10.121.96.105" "10.121.96.106" "10.138.253.131" "10.138.253.133")
#IPLIST=("10.108.82.163")
DATA=/data/crones/monitor/recommend_monitor/data
for IP in ${IPLIST[*]}
do
    COUNT=0
    URL="http://${IP}:8082/?reqtype=4&userid=9374befe0125246bc9745f0bd469c056"
    for i in `seq 1 5`;
    do
        rm -f ${DATA}
        wget -O ${DATA} ${URL}
        LC=`grep income ${DATA} | wc -l`
        if [ ${LC} -eq 1 ]; then
            COUNT=`expr ${COUNT} + 1`
            break;
        fi
        sleep 5
    done
    if [ ${COUNT} -eq 0 ]; then
        ALARM_MSG="rec-page-"$IP"-8082-down"
        wget http://alarms.ops.qihoo.net:8360/intfs/alarm_intf?group_name=dianshang_alarm\&subject=$ALARM_MSG
    fi
done
