#!/bin/bash
#Program:
#  该脚本用于检测端口所存在的问题
#History
#2020/6/8 alex
Port_server=([21]=ftp/tftp/vsftpd [22]=ssh [23]=Telnet [25]=SMTP [53]=DNS [67]=dhcp [68]=dhcp [110]=pop3 [139]=Samba [143]=Imap [161]=SNMP [389]=Ldap [445]=smb [512]=Linux Rexec [513]=Linux Rexec [514]=Linux Rexec [873]=Rsync [1080]=socket [1352]=Lotus domino [1433]=mssql [1521]=oracle [2049]=Nfs [2181]=zookeeper [2375]=docker remote api [3306]=mysql [3389]=Rdp [4848]=GlassFish [5000]=sybase/DB2 [5432]=postgresql [5632]=pcanywhere [5900]=vnc [6379]=Redis [7001]=weblogic [7002]=weblogic [80]=http/https [443]=http/https [8069]=zabbix [8161]=activemq [8080]=Jboss/Tomcat/Resin [8089]=Jboss/Tomcat/Resin [8083]=influxDB [8086]=influxDB [9000]=fastcgi [9090]=Websphere [9200]=elasticsearch [9300]=elasticsearch [11211]=memcached [27017]=mongodb [27018]=mongodb)
Port_error=([21]=爆破/嗅探/溢出/后门 [22]=爆破/openssh漏洞 [23]=爆破/嗅探/弱口令 [25]=邮件伪造 [53]=域传送/劫持/缓存投毒/欺骗 [67]=劫持/欺骗 [68]=劫持/欺骗 [110]=爆破/嗅探 [139]=爆破/未授权访问/远程命令执行 [143]=爆破 [161]=爆破/搜集目标内网信息 [389]=注入/未授权访问/弱口令 [445]=ms17-010/端口溢出 [512]=爆破/Rlogin登录 [513]=爆破/Rlogin登录 [514]=爆破/Rlogin登录 [873]=文件上传/未授权访问 [1080]=爆破 [1352]=爆破/信息泄露 [1433]=爆破/注入/SA弱口令 [1521]=爆破/注入/TNS爆破/反弹shell [2049]=配置不当 [2181]=未授权访问 [2375]=未授权访问 [3306]=爆破/注入 [3389]=爆破/shift后门 [4848]=爆破/认证绕过 [5000]=爆破/注入/提权 [5432]=爆破/注入/缓冲区溢出 [5632]=抓密码/代码执行 [5900]=爆破/认证绕过 [6379]=未授权访问/爆破 [7001]=java反序列化/控制台弱口令 [7002]=java反序列化/控制台弱口令 [80]=web应用漏洞/心脏滴血 [443]=web应用漏洞/心脏滴血 [8069]=远程命令执行/注入 [8161]=弱口令/写文件 [8080]=爆破/PUT文件上传/反序列化 [8089]=爆破/PUT文件上传/反序列化 [8083]=未授权访问 [8086]=未授权访问 [9000]=远程命令执行 [9090]=爆破/java反序列化/弱口令 [9200]=远程代码执行 [9300]=远程代码执行 [11211]=未授权访问 [27017]=未授权访问/爆破 [27018]=未授权访问/爆破)
file=$1

Port=`cat ${file} |grep "端口"|grep -o "[0-9]*"`
for i in $Port
do
	echo ${Port_server[$i]}"服务存在"${Port_error[$i]}"问题"
	echo "______${i}端口_________">>$file
	echo ${Port_server[$i]}"服务">>$file
	echo "存在"${Port_error[$i]}"问题">>$file
done
