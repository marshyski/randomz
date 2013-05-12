#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## SET RANDOM PERMISSIONS AND SUCH        ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

## REPLACE PASSWORD EXPIRATION TIMES
sed -i 's/0:99999:7/1:60:14/' /etc/shadow

## DISABLE IPv6 IN /ETC/NETCONFIG
sed -i 's/udp6/#udp6/' /etc/netconfig 2>/dev/null
sed -i 's/tcp6/#tcp6/' /etc/netconfig 2>/dev/null

## SET UMASKS
grep umask /etc/* | grep -v '#\|pear.conf\|php.ini\|ltrace'| awk -F":" '{ print $1 }' > /tmp/umask

while read line; do

  sed -i 's/umask 022/umask 077/' $line 2>/dev/null
  sed -i 's/umask 002/umask 077/' $line 2>/dev/null

done < /tmp/umask
chmod -f 0755 /etc
rm -f /tmp/umask

## GEN003540 - THE SYSTEM MUST IMPLEMENT NON-EXECUTABLE PROGRAM STACKS
echo ""
echo "Find broken symbolic links in common executable paths"
find /usr/bin /usr/sbin /sbin /bin /usr/local/bin /usr/local/sbin /etc -xtype l -exec ls -Lla {} \;
echo ""

## FIND WORLD WRITABLE DIRECTORIES
echo "Find world writable directories"
find / -type d -perm -1000 -exec ls -ld {} \; 2>/dev/null | grep -vs '/mnt\|/net'
echo ""

## SET PERMISSIONS ON SYSTEM/SECURITY LOGS
chmod -f 0640 /var/log/*
chmod -f 0640 /var/log/audit/*
chmod -f 0600 /var/log/cron*
chmod -f 0600 /var/log/btmp
chmod -f 0660 /var/log/wtmp

## REMOVE WRITE FROM WORLD WRITEABLE FILES
chmod -f o-w `find / -noleaf -type f -perm -o+w 2>/dev/null`

## REPLACE OLD GIDs WITH GROUP ROOT
#chown -f :root `find / -noleaf -nogroup 2>/dev/null | grep -vs '/mnt\|/net'`

## REPLACE OLD UIDs WITH USER ROOT
#chown -f root: `find / -noleaf -nouser 2>/dev/null | grep -vs '/mnt\|/net'`
