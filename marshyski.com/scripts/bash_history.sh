#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## ARCHIVE BASH HISTORY FOR ONE YEAR      ##
## VERSION 0.1 | 27AUG2012                ##
## TESTED ON RHEL 5-6 / UBUNTU 9          ##
############################################

BASH_HIS="$HOME/.bash_history.`date +%m-%d-%y`"
cat $HOME/.bash_history | grep -v 'du\|history\|find\|date\|top\|grep\|man\|mount\|umount\|ls\|more\|which\|ssh\|exit\|vi\|eject\|cat\|cd' > $BASH_HIS
find $HOME/.bash_history.* -mtime +365 -exec rm {} \;
