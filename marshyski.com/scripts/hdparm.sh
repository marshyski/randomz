#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## GATHER LOCAL HARD DRIVE INFORMATION    ##
## VERSION 0.1 | 24AUG2012                ##
## TESTED ON RHEL 5-6 		          ##
############################################

LOG=/export/ADMIN/hdparm.log

rm -f $LOG

touch $LOG

hostname >> $LOG
echo "" >> $LOG
hdparm -I /dev/sda | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sdb | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sdc | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/hda | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sdd | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sde | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sdf | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sdg | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
hdparm -I /dev/sdh | grep -i 'serial\|model' | grep -v 'Transport' 2>/dev/null >> $LOG
echo "" >> $LOG
