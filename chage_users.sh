#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## CHAGE LOCAL SYSTEM USERS               ##
## 03MAR2013		                  ##
## TESTED ON RHEL 5-6 / UBUNTU 9          ##
############################################

TMP="$HOME/chage_tmp"
FINAL_LOG="$HOME/chage_users.log"

rm -f $FINAL_LOG

cat /etc/passwd | awk -F":" '{ print $1 }' > $TMP
touch $FINAL_LOG

while read line; do
   
   echo "$line" >> $FINAL_LOG
   chage -l $line | grep 'Last' >> $FINAL_LOG
   echo "" >> $FINAL_LOG
   
done < $TMP

rm -f $TMP
