#!/bin/sh
if [ -f /etc/debian_version ]
then
    apt-get install software-properties-common
    apt-add-repository ppa:ansible/ansible
    apt-get update
    apt-get install ansible
elif [ -f /etc/redhat-release ]
then
    yum install https://rhel7.iuscommunity.org/ius-release.rpm
    yum --enablerepo=epel install ansible
fi
