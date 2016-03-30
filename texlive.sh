#!/bin/sh
if [ -f /etc/redhat-release ]
then
    :
elif [ -f /etc/debian_version ]
then
    sudo apt-get install texlive-full xzdec
    tlmgr init-usertree
    tlmgr update --self
fi
