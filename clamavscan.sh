#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## CLAMAV SCAN SCRIPT		          ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

### VERIFY RUNNING SCRIPT AS ROOT
if [[ $UID != 0 ]]; then
   echo "Sorry, must be root to run this.  Exiting..."
   echo ""
   exit
fi

### VARIABLES
LOGDIR="/var/log/clamav/"
LOG="$LOGDIR`hostname`.clamscan.`date +%m%d%Y`.log"
CLAMSCAN=`which clamscan 2>/dev/null`
DIR_SCAN="/boot /sbin /bin /tmp /home /root /usr/bin /usr/sbin"
CVD_LOC="/var/clamav"
DEL_LOGS="7"

### SETUP GROUP VARIABLE
if [[ `grep clamav /etc/group` != "" ]]; then
   GROUP=`grep clamav /etc/group | awk -F":" '{ print $1 }'`
   if [[ `grep ^audit /etc/group` != "" ]]; then
      GROUP=`grep ^audit /etc/group | awk -F":" '{ print $1 }'`
   else
      GROUP="root"
   fi
fi

### CREATE CLAMAV LOG DIRECTORY
mkdir -p $LOGDIR
chmod -f 0650 $LOGDIR
chown -f root:$GROUP $LOGDIR

### CREATE LOG
touch -f $LOG
chmod -f 0640 $LOG
chown -f root:$GROUP $LOG

### UPDATE CVD VIRUS DEFINITIONS 
cd $CVD_LOC
wget -N http://db.local.clamav.net/daily.cvd > /dev/null 2>&1
wget -N http://db.local.clamav.net/main.cvd > /dev/null 2>&1

### START SCAN
echo "---------- CLAMSCAN  LOG ---------" > $LOG
hostname >> $LOG
date >> $LOG
$CLAMSCAN --version >> $LOG
echo "" >> $LOG
$CLAMSCAN -ri $DIR_SCAN 2>/dev/null >> $LOG
echo "Directories Scanned: $DIR_SCAN" >> $LOG
echo "" >> $LOG

### LOG SUMMARY AUDIT
echo "---------- LOG SUMMARY ---------" >> $LOG
ls -ld $LOGDIR >> $LOG
ls -l $LOGDIR* >> $LOG

### NOTIFY ROOT AND CHANGE LOG NAME
if [[ `grep '^Infected' $LOG | awk -F": " '{ print $2 }'` -gt 0 ]]; then
   mv -f $LOG $LOGDIR`hostname`.FOUND-VIRUS.`date +%m%d%Y`.log
fi

### FIND OLD LOGS AND REMOVE
if [[ `find $LOGDIR -type f -mtime -$DEL_LOGS | wc -l` -gt $DEL_LOGS ]]; then
   find $LOGDIR -type f -mtime +$DEL_LOGS -exec rm {} \;
fi
