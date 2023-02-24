#!/bin/sh
#
# Start the USB device network interface
# Copyright 2010 Guido Classen, SWARCO Traffic Systems GmbH <clagix@gmail.com>
#                    
# Licensed under the GNU General Public License v2 or later
#

start() {
 	echo "Starting USB device network interface..."
	insmod /lib/modules/`uname -r`/kernel/drivers/usb/gadget/g_ether.ko \
                host_addr=00:dc:c8:f7:75:05 dev_addr=00:dd:dc:eb:6d:f1
        ifconfig usb0 169.254.17.101 netmask 255.255.255.0
        # start dhcp server for USB-gadget RNDIS interface!
        udhcpd /etc/udhcp-usb0.conf
}	
stop() {
	echo -n "Stopping USB device network interface..."
        ifconfig usb0 down
}
restart() {
	stop
	start
}	

case "$1" in
  start)
  	start
	;;
  stop)
  	stopq
	;;
  restart|reload)
  	restart
	;;
  *)
	echo $"Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?

# Local Variables:
# mode: shell-script
# backup-inhibited: t
# End:
