#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## YUM UPDATE SYSTEM                      ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

yum clean all
yum -y -d 0 -e 0 update yum
yum -y -e 0 -d 0 update

## UPDATE RUBY GEM
if [[ `which gem 2>/dev/null` != "" ]]; then
   gem update --system
fi
