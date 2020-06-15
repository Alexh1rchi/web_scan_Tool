#!/bin/bash
#program:
#      以时间格式命名测试报告  format:url_yyyy/m/d/h/m/s
#History
#2020/6/11    alex
url=$1
if [ ! -d "./report/web/${url}_result" ]; then  #判断目录是否存在
        mkdir "./report/web/${url}_result"
        #echo "mkdir successful"
fi
mkdir  "./report/web/${url}_result/${url}_`date +%Y%m%d`_`date +%H%M%S`"
filename=`ls -t ./report/web/${url}_result|head -n1`
#echo $filename
cd ./report/web/${url}_result/${filename}
touch report.txt
touch Port_scan.txt
exit 0;
