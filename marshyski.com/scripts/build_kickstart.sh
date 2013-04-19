#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## GENERATE RHEL KICKSTART IMAGE          ##
## VERSION 0.1 | 04APR2012                ##
## TESTED ON RHEL 5-6 / UBUNTU 9          ##
############################################

TODAY=`date +%Y%m%d`
PATH_TO_KS="/root/kickstart6.2"
PATH_ISO="/home/common"
DVD_NAME="SKI_KS$TODAY"
KS_NAME="ski_$TODAY"

## CHECK HIDDEN FILES ARE PRESENT
if [[ ! -f $PATH_TO_KS/.discinfo ]]; then
   echo "Missing .discinfo in $PATH_TO_KS"
   exit
fi

if [[ ! -f $PATH_TO_KS/.treeinfo ]]; then
   echo "Missing .treeinfo in $PATH_TO_KS"
   exit
fi


## MOVE OLD ISO IF EXISTS
if [[ -f $PATH_ISO/$KS_NAME.iso ]]; then
   mv -fv $PATH_ISO/$KS_NAME.iso $PATH_ISO/$KS_NAME.old 
fi


## UPDATE TODAY'S AV DEFS
cd $PATH_TO_KS/overlays
wget -N http://db.local.clamav.net/daily.cvd
wget -N http://db.local.clamav.net/main.cvd


## REMOVE ~ FILES THAT MAY HAVE BEEN SAVED FROM EDITING FILES
rm -fv `find $PATH_TO_KS | grep '\~'` 


## CREATE ISO FROM CURRENT KICKSTART CONFIGS
mkisofs -o $PATH_ISO/$KS_NAME.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -T -V "$DVD_NAME" $PATH_TO_KS


## BURN DVD FROM ISO
growisofs -dvd-compat -Z /dev/dvd=$PATH_ISO/$KS_NAME.iso 


#eject
#eject -T
#sleep 10
#mount /dev/dvd /media
#clamscan -ri /media
#eject

## LIST ISO's AND OLD ISO's
echo ""
ls $PATH_ISO/ski_*iso 2>/dev/null
ls $PATH_ISO/ski_*old 2>/dev/null
