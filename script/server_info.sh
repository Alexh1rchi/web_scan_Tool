#!bin/bash
#Program:
#	获取服务器容器和版本系统
#2020/6/7 1.0 Alex
IP=$1
report=$2
server=(Apache Tomcat nginx iis bfe )
system=(linux ubuntu Max window Centos)
if [ $1 ]
then
	echo "-----------"
	echo `curl -I -s $IP`|sed 's//\n/g'>./dev/answer.txt
	for ((i=0;i<${#server[@]};i++))
	do
		server_info=`cat ./dev/answer.txt|grep  "Server"|awk -F'\/' '{print $2}'|awk '{print $1}'`
		a=`cat ./dev/answer.txt|grep "Server" |grep -i ${server[$i]}`
		if [ $? -eq 0 ]
		then
			echo  "服务容器："${server[$i]}" 版本： "${server_info}
			echo  "    服务容器："${server[$i]}" 版本： "${server_info}>>${report}
		fi

	done
	for((i=0;i<${#system[@]};i++))
	do
		b=`cat ./dev/answer.txt|grep "Server"|grep -i ${system[$i]}`
		if [ $? -eq 0 ]
                then
                        echo  "服务器操作系统："${system[$i]} 
			echo  "    服务器操作系统："${system[$i]}>>${report}
		fi
	done

else
	echo "请输入IP"
fi
