#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## COMPARE MEMORY USAGE AND RESTART HTTPD ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

MEM=`free -m | grep Mem`
MEM_USED=`echo $MEM | awk '{ print $3 }'`
MEM_FREE=`echo $MEM | awk '{ print $4 }'`

SWAP=`free -m | grep Swap`
SWAP_USED=`echo $SWAP | awk '{ print $3 }'`
SWAP_FREE=`echo $SWAP | awk '{ print $4 }'`

MEM_LIMIT="100"

echo "RAM Used $MEM_USED : RAM Free $MEM_FREE"
echo "SWAP Used $SWAP_USED : SWAP Free $SWAP_FREE"
echo "MEM Limit $MEM_LIMIT"
echo ""

echo "`ps aux 2>/dev/null | grep httpd | grep -v grep | wc -l` HTTPD Processes"
echo "`netstat -tlpn 2>/dev/null | grep [0-9]:80 | wc -l` Clients Accessing Apache"

if [[ $MEM_FREE -lt $MEM_LIMIT ]]; then
    /etc/init.d/httpd restart
fi
