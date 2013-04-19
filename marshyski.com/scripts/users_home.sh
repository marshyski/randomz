#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## OBTAIN INFO ON USERS HOME DISK USAGE   ##
## VERSION 0.1 | 24AUG2012                ##
## TESTED ON RHEL 5-6 / UBUNTU 9          ##
############################################

HOME_LOC="/home"
HOME_LIST=`cat /etc/passwd | awk -F: '{print $6}' | grep $HOME_LOC | grep -v clamav`
LOG="$HOME/users_home"

date > $LOG
echo "" >> $LOG

for line in $HOME_LIST; do
   
    du -sh $line 2>/dev/null | grep 'G\|T' >> $LOG

done
