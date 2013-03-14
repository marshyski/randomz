#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## CHANGE ROOT'S PASSWD TO RANDOM 32 CHAR ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

PASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' | fold -w 32 | head -n 1`
echo "$PASS" | passwd --stdin root 1> /dev/null
