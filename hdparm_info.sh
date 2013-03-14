#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## GATHER LOCAL HARD DRIVE INFORMATION    ##
## 03MAR2013   		                  ##
## TESTED ON RHEL 5-6 		          ##
############################################

LOG=$HOME/hdparm.log

rm -f $LOG

hostname > $LOG
echo "" >> $LOG
hdparm -I /dev/sda 2>/dev/null | grep -i 'sda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sdb 2>/dev/null | grep -i 'sdb\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sdc 2>/dev/null | grep -i 'sdc\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sdd 2>/dev/null | grep -i 'sdd\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sde 2>/dev/null | grep -i 'sde\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sdf 2>/dev/null | grep -i 'sdf\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sdg 2>/dev/null | grep -i 'sdg\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/sdh 2>/dev/null | grep -i 'sdh\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hda 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hdb 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hdc 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hdd 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hde 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hdf 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hdg 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
hdparm -I /dev/hdh 2>/dev/null | grep -i 'hda\|serial\|model' | grep -v 'Transport' >> $LOG
echo "" >> $LOG
