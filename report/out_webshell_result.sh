#!/bin/bash
#program:
#      以时间格式命名测试报告  format:url_yyyy/m/d/h/m/s
#History
#2020/6/11    alex
file=$1
touch  "./report/scan_webshell/${file}_`date +%Y%m%d`_`date +%H%M%S`.txt"
filename=`ls -t ./report/scan_webshell|head -n1`
echo $filename
exit 0;

