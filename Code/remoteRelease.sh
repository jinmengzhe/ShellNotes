#  $1 is used to indicate whether need update conf files
#  1: need
#  0: not need
#  use it like "sh replacejar.sh 0" or "sh repalcejar.sh 1"
#  iplist is variable depends on 
iplist=("10.11.150.199" "10.11.150.200")
for ip in ${iplist[*]}
do	
	##### stop loganalysis service #####
	echo "stop loganalysis service for "$ip
	temp=`ssh $ip 'cd /opt/bladeazure/loganalysis/bin;sh stop_all.sh'`
	result=$?
	if [ $result -ne 0 ]
	then
		echo "Error:fail to stop loganalysis service for "$ip
		exit 1
	fi
	
	
	##### if need update conf files:1 delete old conf files; 2 copy new files #####
	if [ $1 -eq 1 ]
	then
		echo "delete old conf files for "$ip
		temp=`ssh $ip 'rm -f /opt/bladeazure/loganalysis/conf/*'`
		result=$?
		if [ $result -ne 0 ] 
		then
			echo "Error:fail to delete old conf files for "$ip
			exit 1
		fi
		
		echo "update new conf files for "$ip
		temp=`scp ./testcnf/* $ip:/opt/bladeazure/loganalysis/conf`
		result=$?
		if [  $result -ne 0 ]
		then
			echo "Error:fail to copy new conf files for "$ip
			exit 1
		fi
	fi
	
	
	##### 1 delete old loganalysis.jar  2 copy new loganalysis.jar #####
	echo "delete old loganalysis.jar for "$ip
	temp=`ssh $ip 'rm -f /opt/bladeazure/loganalysis/bin/loganalysis.jar'`
	result=$?
	if [ $result -ne 0 ]
	then
		echo "Error:fail to delete old loganalysis.jar for "$ip
		exit 1
	fi
	
	echo "copy new loganalysis.jar for "$ip
	temp=`scp ./loganalysis.jar $ip:/opt/bladeazure/loganalysis/bin`
	result=$?
	if [ $result -ne 0 ]
	then
		echo "Error:fail to copy new loganalysis.jar for "$ip
		exit 1
	fi
	
	
	##### start loganalysis service #####
	echo "start loganalysis service for "$ip
	temp=`ssh $ip 'cd /opt/bladeazure/loganalysis/bin;sh start_all.sh'`
	result=$?
	if [ $result -ne 0 ] 
	then
		echo "fail to start loganalysis service for "$ip
		exit 1
	fi
	
	echo ""
done
