#/bin/bash
#Program:
#  指定IP端口扫描,判断目标主机开放来哪些端口
#History
#2020/6/6  alex
IP=$1
report=$2
#加载端口字典扫描端口
for i in `cat ./dict/defaultport.txt`
do
    echo quit | timeout --signal=9 3 telnet $1 $i |grep "Connected to">>./dev/null.txt
    if [ $? -eq 0 ]
    then
	echo "主机$1开放$i端口"
        echo "$i端口">>$report
    else
	echo "主机$1关闭$i端口"
    fi
done
