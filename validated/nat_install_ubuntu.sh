#!/bin/bash

NAT_EXTIF="ens4"
NAT_INTIF="ens5"

# enable IP forwarding
SYSCTL_CONF=/etc/sysctl.conf
sudo sed -i -e '/#>>>>>/#<<<<</d' $SYSCTL_CONF
cat <<EOF | sudo tee -a $SYSCTL_CONF
#>>>>>
net.ipv4.ip_forward=1
#<<<<<
EOF
# to enable the changes made in sysctl.conf you will need to run the command
sudo sysctl -p /etc/sysctl.conf
# iptable persistent installation in unattended manner
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt-get install -y iptables-persistent

# to backup default iptable setup before enabling nat
if [ ! -f /etc/iptables/rules.v4.default ]; then
  sudo iptables-save | sudo tee /etc/iptables/rules.v4.default
fi
# to backup current iptable setup before enabling nat
  sudo iptables-save | sudo tee /etc/iptables/rules.v4.prev
#
# flush current iptables (ipv4)
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X

# flush current iptables (ipv6)
#sudo ip6tables -P INPUT ACCEPT
#sudo ip6tables -P FORWARD ACCEPT
#sudo ip6tables -P OUTPUT ACCEPT
#sudo ip6tables -t nat -F
#sudo ip6tables -t mangle -F
#sudo ip6tables -F
#sudo ip6tables -X

#
sudo iptables -t nat -A POSTROUTING -o $NAT_EXTIF -j MASQUERADE
sudo iptables -A FORWARD -i $NAT_EXTIF -o $NAT_INTIF -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $NAT_INTIF -o $NAT_EXTIF -j ACCEPT


# to save nat configuration (iptables) in effect after reboot
sudo iptables-save | sudo tee /etc/iptables/rules.v4
