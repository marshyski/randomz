#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## HOME AREA BACKUP SCRIPT                ##
## VERSION 0.3 | 06MAY2012                ##
## TESTED ON RHEL 5-6 / UBUNTU 9          ##
############################################


#### VARIABLES
DAYMONTH=`date +%d%b`
BACKUP_DIR="$HOME/backup"
LOG="$BACKUP_DIR/backup.log"
BACKUP="$BACKUP_DIR/backup-$DAYMONTH.bz2"
BACKUP_DATA="$HOME/scripts /etc/fstab /projects/hbve /projects/notes*"
SSH_KEY="$HOME/.ssh/id_rsa"


#### CHECK VARIABLES
if [[ ! -d $BACKUP_DIR ]]; then
   echo "Backup directory '$BACKUP_DIR' doesn't exist..."
   exit
fi
if [[ ! -f $SSH_KEY ]]; then
   echo "SSH Key '$SSH_KEY' doesn't exist..."
   exit
fi


#### CLEAN UP HOME AREA
date > $LOG
echo "Cleaning up home area..." | tee -a $LOG

find $HOME -xdev -type f -name "*~" -print -exec rm {} \;

if [[ -d $HOME/.cache ]]; then
   rm -Rf $HOME/.cache
fi
if [[ -d $HOME/.purple/logs ]]; then
   rm -Rf $HOME/.purple/logs/*
fi
if [[ -d $HOME/.purple/icons ]]; then
   rm -Rf $HOME/.purple/icons/*
fi
if [[ -d $HOME/.gimp*/tmp ]]; then
   rm -Rf $HOME/.gimp*/tmp/*
fi
if [[ -d $HOME/.evolution/cache/tmp ]]; then
   rm -Rf $HOME/.evolution/cache/tmp/*
fi
if [[ -d $HOME/.adobe ]]; then
   rm -Rf $HOME/.adobe/*
fi
if [[ -d $HOME/..macromedia ]]; then
   rm -Rf $HOME/.macromedia/*
fi
if [[ -d $HOME/.local/share/Trash ]]; then
   rm -Rf $HOME/.local/share/Trash
   mkdir -p $HOME/.local/share/Trash
fi


#### FIND BACKUPS LOCALLY OLDER THAN 15 DAYS AND REMOVE
find $BCKUP_DIR/backup-*.bz2 -type f -mtime +15 -exec rm {} \; 2>/dev/null | tee -a $LOG
echo ""
echo "Deleted backups older then 15 days..." | tee -a $LOG


#### TAR(bz2) FILE ####
if [[ -f $BACKUP ]]; then
   rm -f $BACKUP
fi

tar -cvpjf $BACKUP $BACKUP_DATA | tee -a $LOG

echo ""
echo "Finished tar'ing files..." | tee -a $LOG


#### FIND REMOTE BACKUPS AND DELETE
ssh -q -i $SSH_KEY username@host -n "find ~/backup/backup-* -type f -exec rm {} \; 2>/dev/null" 2>/dev/null | tee -a $LOG
echo ""
echo "Deleted old backups at remote host..." | tee -a $LOG


#### RSYNC BACKUP TO REMOTE SITE
rsync -avz --rsh="ssh -i $SSH_KEY" --delete --numeric-ids $BACKUP username@host:~/backup 2>/dev/null | tee -a $LOG
echo ""
echo "Finished! Size of backup is: `du -shL $BACKUP`" | tee -a $LOG
date >> $LOG
