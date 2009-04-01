#!/bin/sh
SERVERIP=10.0.0.1

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
pand --listen --role NAP --master --autozap

i=1
while [ $i -le 10 ]; do
	i=$(($i + 1))
	if [ -d /sys/class/net/bnep0 ]; then
		ifconfig bnep0 $SERVERIP
		echo "set IP address"
		exit
	fi
	sleep 1 # wait
done

echo "Can not create bnep0"

#pand --connect サーバドングルのMAC --service NAP --autozap
#ifconfig bnep0 192.168.0.1
