#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## WEBSITE PUSH / SYNC		          ##
## 10MAY2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

KEY="$HOME/.ssh/sdf"
WEBSITE="/root/randomz/marshyski.com"

rm -fv `find $WEBSITE | grep '\~'` 

if [[ $1 = "-t" ]]; then
   rsync -navz --rsh="ssh -p 22 -i $KEY" $WEBSITE/* mfski@sdf.org:/arpa/gm/m/mfski/html/marshyski.com
   exit
fi

cd $WEBSITE
chmod -f 0755 ./*
chmod -f 0755 images
chmod -f 0755 images/*
chmod -f 0444 scripts/*

rsync -avz --rsh="ssh -p 22 -i $KEY" $WEBSITE/* mfski@sdf.org:/arpa/gm/m/mfski/html/marshyski.com

ssh -q -i $KEY mfski@sdf.org -n "/arpa/gm/m/mfski/bin/restore_pems.sh" 2>/dev/null
