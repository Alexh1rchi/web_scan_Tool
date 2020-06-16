#!/bin/bash
#Program:
#   主程序：域名解析->端口扫描->服务扫描->路径扫描->漏洞检测->生成报告
#History
#2020/6/9 alex
if [ -z $1 ]
then	echo "【参数错误】："
	echo "	  无法识别命令 通过-h获取帮助指令  --help"
fi
case ${1} in
	-h)
		echo "----帮助文档----"
		echo "help:"
		echo "	-h --help get help"
		echo "	-u --url  scan url"
		echo "	-f --filename  scan file find webshell"
		;;
	-u)
		echo "------------执行漏洞检测--------------"
		#输入URL
		url=$2
		echo "检测的url网址：${url}"
                #创建报告目录文件,获取文件名
		sh ./report/out_web_result.sh $url
		reportfile=`ls -t ./report/web/${url}_result|head -n1`
		report="./report/web/${url}_result/${reportfile}/report.txt"
		echo "-----------漏洞检测报告--------">>$report
		echo "检测的url网址：${url}">>$report
		echo "存放检测报告目录：" $reportfile
		echo "开始检测"
		echo "--------------loading--------------"
		echo ""
		echo "域名解析---------->>"
		#域名解析
		IP=`sh ./script/information.sh ${url}`
		echo "IP为：$IP"
		echo "IP为：$IP">>$report
		echo "端口扫描---------->>"
		echo "主机开放端口:">>$report
		#端口扫描
		sh ./script/Port_scan.sh ${IP} ${report}
		echo "配置信息----------->>"
		echo "配置信息">>$report
		#服务器部分配置信息
		sh ./script/server_info.sh ${url} ${report}
		echo "敏感路径爆破------->>"
		echo "敏感路径">>$report
		#敏感路径扫描 
		pythondict=./python/path_scan/dics
		python3  ./python/path_scan/web_dir_scan.py -u http://${url}/ -f $pythondict/path_scan.txt
		echo `cat ./python/path_scan/result.txt`>>$report
		#源码泄漏
		echo "疑似存在源码泄漏路径"
		echo "疑似存在源码泄漏路径">>$report
		python3 ./python/path_scan/web_dir_scan.py -u http://${url}/ -f $pythondict/source_file.txt
        echo `cat ./python/path_scan/result.txt`>>$report
		echo ""
		echo "网站疑似存在漏洞,请修复"
		echo "网站疑似存在漏洞,请修复">>$report
		#网站存在问题
		sh ./script/Port_error_check.sh $report
		;;
	-f)
		echo "----服务器webshell检测----"
		filename=$2
		echo "查杀目录： ${filename}"
		#创建webshell检测目录文件
		sh ./report/out_webshell_result.sh $filename
		file=`ls -t ./report/scan_webshell|head -n1`
		#目录文件webshell检测
		python3 ./python/webshell_scan/webshell_scan.py ${filename}
		echo `python3 ./python/webshell_scan/webshell_scan.py ${filename}`>>./report/scan_webshell/$file
		echo "查杀结果存放文件：${file}"
		;;
	?)
		echo "无法识别参数指令！"&&exit 0
		;;
esac
