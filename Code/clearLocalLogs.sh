#!/bin/sh
declare -a dayArray
declare -i k
k=0
for((i=24;i<168;i=(i+24)));
do
        day=`date --date="-$i hour" +%Y-%m-%d`
        dayArray[k++]=$day
done

# clear bladeservice logs
filelist=`ls /data1/BladeService/logs`
cd /data1/BladeService/logs
for file in $filelist;
do
        if [ $file == "log" ] || [ $file == "fatallog" ];
        then
                continue
        fi

	prefix=`echo $file | awk -F '.' '{print $1}'`
	if [ $prefix != "log" ] && [ $prefix != "fatallog" ];
	then
		continue
	fi

        datesuffix=`echo $file | awk -F '.' '{print $2}'`
        if [ $datesuffix != ${dayArray[0]} ] && [ $datesuffix != ${dayArray[1]} ] && [ $datesuffix != ${dayArray[2]} ] && [ $datesuffix != ${dayArray[3]} ] && [ $datesuffix != ${dayArray[4]} ] && [ $datesuffix != ${dayArray[5]} ];
        then
                rm -f $file
        fi
done

# clear loganalysis logs
filelist=`ls /opt/azure/loganalysis/log`
cd /opt/azure/loganalysis/log
for file in $filelist;
do
        if [ $file == "azure_loganalysis_log" ] || [ $file == "azure_loganalysis_fatal_log" ] || [ $file == "azure_loganalysis.record" ];
        then
                continue
        fi
	
	prefix=`echo $file | awk -F '.' '{print $1}'`
        if [ $prefix != "azure_loganalysis_log" ] && [ $prefix != "azure_loganalysis_fatal_log" ];
        then
                continue
        fi

        datesuffix=`echo $file | awk -F '.' '{print $2}'`
        if [ $datesuffix != ${dayArray[0]} ] && [ $datesuffix != ${dayArray[1]} ] && [ $datesuffix != ${dayArray[2]} ] && [ $datesuffix != ${dayArray[3]} ] && [ $datesuffix != ${dayArray[4]} ] && [ $datesuffix != ${dayArray[5]} ];
        then
                rm -f $file
        fi
done
