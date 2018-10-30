#!/bin/bash

# tftp installation
sudo apt-get install -y apache2 tftpd-hpa inetutils-inetd

# tftp configuration

TFTP_DEFAULT=/etc/default/tftpd-hpa
TFTP_BOOT=/var/lib/tftpboot
sudo sed -i -e '/#>>>>>/,/#<<<<</d' $TFTP_DEFAULT
cat <<EOF | sudo tee -a $TFTP_DEFAULT
#>>>>>
RUN_DAEMON="yes"
OPTIONS="-l -s $TFTP_BOOT"
#<<<<<
EOF

INETD_CONF=/etc/inetd.conf
# adding 
sudo sed -i -e '/#>>>>>/,/#<<<<</d' $INETD_CONF
cat <<EOF | sudo tee -a $INETD_CONF
#>>>>>
tftp	dgram	udp	wait	root	/usr/sbin/in.tftpd -s $TFTP_BOOT
#<<<<<
EOF

sudo /etc/init.d/tftpd-hpa restart

# downloading iso image
ISO=ubuntu-16.04.5-server-amd64.iso
INSTALLER_SRC=http://releases.ubuntu.com/16.04/$ISO
INSTALLER_DEST=/var/www/ubuntu160405
if [ ! -f ./$ISO ]; then
wget http://releases.ubuntu.com/16.04/$ISO
fi

# mounting iso to mnt
sudo mount -o loop ./$ISO /mnt

# copy the installation files to pxe server
cd /mnt
# kernel and ram disk
sudo cp -fr install/netboot/* $TFTP_BOOT
# os image
sudo mkdir -p $INSTALLER_DEST
sudo cp -fr /mnt/* $INSTALLER_DEST


# modify pxe config file
INSTALLER_IPADDR=192.168.100.1
sudo sed -i -e '/#>>>>>/,/#<<<<</d' $TFTP_BOOT/pxelinux.cfg/default
cat <<EOF | sudo tee -a $TFTP_BOOT/pxelinux.cfg/default
#>>>>>
lable linux
kernel ubuntu-installer/amd64/linux
append ks=http://$INSTALLER_IPADDR/ks.cfg vga=normal initrd=ubuntu-installer/amd64/initrd.gz
ramdisk_size=16432 root=/dev/rd/0 rw --
#<<<<<
EOF

# installing dhcp
sudo apt-get install -y isc-dhcp-server

DHCP_INTERFACES="ens5" # e.g. "ens3 ens4 ens5"
DHCP_DEFAULT=/etc/default/isc-dhcp-server
DHCP_CONF=/etc/dhcp/dhcpd.conf

sudo sed -i -e "s/^INTERFACES/#INTERFACES/" $DHCP_DEFAULT
sudo sed -i -e '/#>>>>>/,/#<<<<</d' $DHCP_DEFAULT
cat <<EOF | sudo tee -a $DHCP_DEFAULT
#>>>>>
INTERFACES="$DHCP_INTERFACES"
#<<<<<
EOF

#sudo service isc-dhcp-server restart

# dhcp conf
DHCP_SUBNET=192.168.100.0
DHCP_NETMASK=255.255.255.0
DHCP_RANGE="192.168.100.101 192.168.100.109"
DHCP_ROUTERS_IPADDR="192.168.100.1" # require pxe server to enable nat
DHCP_TFTP_IPADDR="192.168.100.1"
sudo sed -i -e '/#>>>>>/,/#<<<<</d' $DHCP_CONF
cat <<EOF | sudo tee -a $DHCP_CONF
#>>>>>
subnet $DHCP_SUBNET netmask $DHCP_NETMASK {
  range $DHCP_RANGE;
}
allow booting;
allow bootp;
#option option-128 code 128 = string;
#option option-129 code 129 = text;
option domain-name-servers 10.100.204.254;
option routers $DHCP_ROUTERS_IPADDR;
next-server $DHCP_TFTP_IPADDR;
filename "pxelinux.0";
#<<<<<
EOF

sudo service isc-dhcp-server restart

# required: enable nat after this installation
