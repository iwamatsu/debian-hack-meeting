#!/bin/sh

if [ -z $1 ] ;then
	echo "Please server MAC address"
	exit 0;
fi

if [ -z $2 ] ;then
	echo "Please server Client IP address"
	exit 0;
fi

modinfo bnep > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Can not found bnet driver module"
	exit 0;
fi

modprobe bnep
# -- log --
# $ lsmod | grep bnep
# bnep                   17024  0 
# l2cap                  23936  10 bnep,rfcomm
# bluetooth              57124  8 bnep,rfcomm,l2cap,hci_usb

pand --connect $1 --service NAP --autozap
ifconfig bnet0 $2
