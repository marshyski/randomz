#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## SET GRUB SETTINGS AFTER KERNEL UPDATE  ##
## 03MAR2013   		                  ##
## TESTED ON RHEL 5-6 		          ##
############################################

## REMOVE SPLASH SCREEN AND TURN ON AUDITING DURING BOOT
sed -i 's/rhgb/audit=1/' /boot/grub/grub.conf
sed -i 's/quiet/nousb/' /boot/grub/grub.conf
sed -i 's/rhgb//' /boot/grub/grub.conf
sed -i 's/quiet//' /boot/grub/grub.conf

## SET GRUB TIMEOUT DURING BOOT - FASTER BOOTUP
sed -i 's/timeout=5/timeout=1/' /boot/grub/grub.conf

## SET GRUB PASSWORD
if [[ `grep password /boot/grub/grub.conf` = "" ]]; then
   grep -v ^# /boot/grub/grub.conf| sed '/^$/d' > /tmp/grub.conf
   sed -i '2 a\password --encrypted $6$aW75T8HYAgTB8QIk$M5wEfPL1.bdEjXRmopGDymDX6AKPQJLrUUhc8mKrUzrA4k5uVCMxw.sVZowfPPojjhtn0XJBYqlEJ4msnhShd0' /tmp/grub.conf
   mv -f /boot/grub/grub.conf /boot/grub/grub.bk
   mv -f /tmp/grub.conf /boot/grub
   chmod -f 0600 /boot/grub/grub.conf
   rm -f /etc/grub.conf
   ln -s /boot/grub/grub.conf /etc/
fi
