#!/bin/sh
if [ -f /etc/redhat-release ]
then
    yum install https://rhel7.iuscommunity.org/ius-release.rpm
    yum --enablerepo=epel update -y
    yum --enablerepo=epel install ansible
    yum install git
elif [ -f /etc/debian_version ]
then
    apt-get update
    apt-get upgrade
    # do-release-upgrade -d
    apt-get install software-properties-common
    apt-add-repository ppa:ansible/ansible
    apt-get update
    apt-get install ansible
    apt-get install "nvidia-340"
    apt-get install git
fi
read -p "Reboot (y/n)?" answer
if [ "$answer" == "y" ]
then
    reboot
fi
