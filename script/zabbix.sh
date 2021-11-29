#!/bin/bash
echo -e "请给出要安装的zabbix版本号，建议使用4.x的版本
\033[31musage:./zabbix_aliyun.sh 4.0|4.4|4.5 \033[0m"
echo "例如要安装4.4版本，在命令行写上 ./zabbix_aliyun.sh 4.4"
if [ -z $1 ];then
exit
fi
VERSION=$1
if [ -f /etc/yum.repos.d/zabbix.repo ];then
rm -rf /etc/repos.d/zabbix.repo
fi
rpm -qa | grep zabbix-release && rpm -e zabbix-release
rpm -Uvh https://mirrors.aliyun.com/zabbix/zabbix/$VERSION/rhel/7/x86_64/zabbix-release-$VERSION-1.el7.noarch.rpm
sed -i "s@zabbix/.*/rhel@zabbix/$VERSION/rhel@g" /etc/yum.repos.d/zabbix.repo 
sed -i 's@repo.zabbix.com@mirrors.aliyun.com/zabbix@g' /etc/yum.repos.d/zabbix.repo
[ $? -eq 0 ] && echo "阿里云的zabbix源替换成功" || exit 1
yum clean all
yum makecache fast
