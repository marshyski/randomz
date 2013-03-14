#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## SPIN UP VIRTUALBOX VM                  ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

VM="OpenVAS-5"
OSTYPE="Linux26"
DAYMONTH=`date +%d%b`
VM_DIR="/home/common/VirtualBox"
ISO="/root/html/CentOS-5.8-i386-bin-DVD-1of2.iso"
#VM_DSK="$VM_DIR/$VM_hdd.vdi"
VM_DSK="/root/common/VirtualBox/OpenVAS-5_DEMO_1.0/OpenVAS-5-DEMO-1.0-disk1.vmdk"
RAM="1536" #MB
DSK_SIZE="10000" #MB
LOG="$VM_DIR/$VM$DAYMONTH.log"

mkdir -p $VM_DIR

cd $VM_DIR

#Create vm
VBoxManage createvm --name $VM --ostype $OSTYPE --register

#Allocate all appropriate parameters
VBoxManage modifyvm $VM --memory $RAM --boot1 dvd --boot2 disk --clipboard bidirectional

VBoxManage modifyvm $VM --acpi on

VBoxManage modifyvm $VM --cpus 1

VBoxManage modifyvm $VM --ioapic on

VBoxManage modifyvm $VM --vram 32

VBoxManage modifyvm $VM --vrde on

VBoxManage modifyvm $VM --vrdeport 3390

VBoxManage modifyvm $VM --vrdeaddress 192.168.10.115

VBoxManage modifyvm $VM --usb off

VBoxManage modifyvm $VM --audio none

VBoxManage modifyvm $VM --nic1 bridged

VBoxManage modifyvm $VM --bridgeadapter1 eth0

VBoxManage modifyvm $VM --nictype1 Am79C973

VBoxManage modifyvm $VM --cableconnected1 on

VBoxManage storagectl $VM --name "IDE Controller" --add ide

#VBoxManage createhd --filename $VM_DSK --size $DSK_SIZE

VBoxManage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium $VM_DSK

#VBoxManage storageattach $VM --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium '$ISO'

#VBoxManage modifyvm $VM -dvd $ISO

echo ""
VBoxManage showvminfo $VM --details | tee $LOG

echo "Run Command When Ready: VBoxHeadless -startvm $VM &"
echo ""
