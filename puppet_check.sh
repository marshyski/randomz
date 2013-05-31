#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## TEST/CHECK PUPPET MANIFESTS            ##
## 18APR2013                              ##
## TESTED ON RHEL 6                       ##
############################################

#REMOVE TRAILING WHITESPACE
#sed -i 's/[ \t]*$//' $1 init.pp

PUPPET_DIR="/etc/puppet"
TMP="$HOME/ptmp"
LOG="$HOME/puppet.log"

## CHECK IF PUPPET IS INSTALLED
if [[ `which puppet 2>/dev/null` = "" ]]; then
   echo "Could not find puppet installed"
   exit
fi

rm -f $LOG
touch $LOG

## RUN JUST ONE MODULE INSTEAD OF ALL MODULES
if [[ $1 != "" ]]; then
   echo "$1" | tee -a $LOG
   puppet apply --noop $1 | tee -a $LOG
   if [[ `which puppet-lint 2>/dev/null` = "" ]]; then
     ## USE PUPPETLINTER API INSTEAD OF LOCAL PUPPET-LINT
     curl -s -i -F file=@$1 http://www.puppetlinter.com/api/v1/lint |  sed -e '1,17d' -e :a -e '$!N;s/\n//;ta' -e :b -e 's/,/\n/;tb' -e 's/\\n//;tb' \
     | grep -iv 'tab character\|two-space' | tee -a $LOG
   else
     puppet-lint $1 | grep -iv 'tab character\|two-space' | tee -a $LOG
   fi
   find $1 -type f -perm /0137 -printf "%p is %m should be 0640 or less\n" 2>/dev/null | tee -a $LOG
   find $1 -type f \( ! -group puppet \) -printf "%p is group %g should be puppet\n" 2>/dev/null | tee -a $LOG
   echo "" | tee -a $LOG
   rm -f $TMP
   exit
fi

## FIND PUPPET MODULES, EXCLUDE TEST/SITE.PP
find $PUPPET_DIR 2>/dev/null | grep '\.pp' | grep -v 'site.pp\|test/init.pp' > $TMP

## RUN NOOP ON SITE.PP IF EXISTS
if [[ `find $PUPPET_DIR 2>/dev/null | grep 'site.pp'` != "" ]]; then
   echo "`find $PUPPET_DIR 2>/dev/null | grep 'site.pp'`" | tee -a $LOG
   puppet apply --noop `find $PUPPET_DIR 2>/dev/null | grep 'site.pp'` | tee -a $LOG
   echo "" | tee -a $LOG
fi

## CHECK PUPPET FOR BASIC SETTINGS
while read line; do
   
   echo "$line" | tee -a $LOG
   puppet apply --noop $line | tee -a $LOG
   if [[ `which puppet-lint 2>/dev/null` = "" ]]; then
     ## USE PUPPETLINTER API INSTEAD OF LOCAL PUPPET-LINT 
     curl -s -i -F file=@$line http://www.puppetlinter.com/api/v1/lint |  sed -e '1,17d' -e :a -e '$!N;s/\n//;ta' -e :b -e 's/,/\n/;tb' -e 's/\\n//;tb' \
     | grep -iv 'tab character\|two-space' | tee -a $LOG
   else
     puppet-lint $line | grep -iv 'tab character\|two-space' | tee -a $LOG
   fi
   find $line -type f -perm /0137 -printf "%p is %m should be 0640 or less\n" 2>/dev/null | tee -a $LOG
   find $line -type f \( ! -group puppet \) -printf "%p is group %g should be puppet\n" 2>/dev/null | tee -a $LOG
   echo "" | tee -a $LOG

done < $TMP

rm -f $TMP
