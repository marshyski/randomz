#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## AUTO DOWNLOAD /INSTALL 64BIT JRE RPM   ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

cd /home/www/html
rm -f manual.jsp*
wget http://www.java.com/en/download/manual.jsp

VER=`grep "Recommended Version" manual.jsp | awk -F" " '{ print "jre_"$2 $3 $4 $5"_x64.rpm" }' | tr [:upper:] [:lower:]`
LINK=`grep "Linux x64 RPM" manual.jsp | awk -F'"' '{ print $4 }' | head -n 1`

wget -O - $LINK > $VER
rm -f manual.jsp*
chmod -f 0755 $VER 
rpm -ivh $VER
