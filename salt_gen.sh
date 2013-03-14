#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## SALT PASSWORD YOU WANT FOR AUTH        ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

OPENSSL=`which openssl 2>/dev/null`

clear
stty -echo
echo -n "Enter short string (for password randomness): "
read SALT
echo ""
echo -n "Enter what you want your password to be: "
read NEWPASS
stty echo
clear

## Now we generate the password hash to be placed in a puppet module or whatever
echo -n "This is your password hash ---> "
$OPENSSL passwd -1 -salt $SALT $NEWPASS
echo "This hash is NOT stored anywhere, make sure you save it NOW!"
