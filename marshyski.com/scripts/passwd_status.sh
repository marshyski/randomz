#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## OBTAIN LOCAL USERS PASSWORD STATS      ##
## VERSION 0.1 | 24AUG2012                ##
## TESTED ON RHEL 5-6 		          ##
############################################
TMP="$HOME/passwd_tmp"
TMP2="$HOME/passwd_status"
FINAL_LOG="$HOME/passwd_np"

rm -f $FINAL_LOG

cat /etc/passwd | awk -F":" '{ print $1 }' > $TMP
echo "" > $TMP2

while read line; do 

      passwd -S $line >> $TMP2

done < $TMP

sort $TMP2 > $TMP

cat $TMP > $TMP2

cat $TMP2 | grep "NP" | sort > $FINAL_LOG

rm -f $TMP

if [[ `cat $FINAL_LOG` = "" ]]; then
   echo "NO PASSWORD ACCOUNTS WERE FOUND"
   echo "Review password statuses... $TMP2"
   rm -f $FINAL_LOG
else 
   echo "Review log $FINAL_LOG"
   echo "Review password statuses... $TMP2"
fi
