#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## BUILD RHEL/CENTOS KICKSTART IMAGE      ##
## 14MAR2013                              ##
## TESTED ON RHEL 5-6		          ##
############################################

TODAY=`date +%Y%m%d`
PATH_ISO="/kickstart"


## CHECK FOR INVAILD COMMAND-LINE ARGUMENTS
if [[ $1 != "-c" ]]; then
   if [[ $1 != "-r" ]]; then
      echo "'$1' invaild command-line argument"
      echo ""
      echo "  build_kickstart.sh -c | Build CentOS 6.4 kickstart"
      echo "  build_kickstart.sh -r | Build RHEL 6.4 kickstart"
      echo ""
      exit
   fi
fi


## MOVE KS.CFG TO KICKSTART DIRECTORY
if [[ $1 = "-c" ]]; then
   PATH_TO_KS="/kickstart/centos6.4"
   DVD_NAME="CENTOS_KS$TODAY"
   KS_NAME="CENTOS_KS$TODAY"
fi

if [[ $1 = "-r" ]]; then
   PATH_TO_KS="/kickstart/rhel6.4"
   DVD_NAME="RHEL_KS$TODAY"
   KS_NAME="RHEL_KICKSTART$TODAY"
fi


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
chmod -f 0444 $PATH_ISO/$KS_NAME.iso


## GENERATE SHA256 SUM
echo ""
sha256sum $PATH_ISO/$KS_NAME.iso | tee $KS_NAME.sha256
chmod -f 0440 $KS_NAME.sha256 


## BURN DVD FROM ISO
#growisofs -dvd-compat -Z /dev/dvd=$PATH_ISO/$KS_NAME.iso

#eject
#eject -T
#sleep 10
#mount /dev/dvd /media
#clamscan -ri /media
#eject


## LIST ISO's AND OLD ISO's
echo ""
ls $PATH_ISO/*iso 2>/dev/null
ls $PATH_ISO/*old 2>/dev/null
