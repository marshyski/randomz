#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## SHUTDOWN REMOTE NETWORKED SYSTEMS      ##
## VERSION 0.1 | 24AUG2012                ##
## TESTED ON RHEL 5-6		          ##
############################################

if [[ $UID != 0 ]]; then 
    echo "Sorry, must be root to run this.  Exiting..."
    exit
fi

SHUTDOWN_HOSTS="/root/shutdown_hosts"
KEY="/root/.ssh/id_rsa"
SHUTDOWN="/sbin/shutdown -h now"

while read line; do

	echo  $line
	ssh -p 22 -i $KEY root@$line -n "$SHUTDOWN"

done < $SHUTDOWN_HOSTS

/sbin/shutdown -h now
