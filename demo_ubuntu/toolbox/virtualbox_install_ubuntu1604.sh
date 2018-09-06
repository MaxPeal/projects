#!/bin/bash

# Reference: https://garywoodfine.com/install-virtual-box-5-2-ubuntu-16-04/

# for Ubuntu 16.04
# Add a new repository
OSDIST=xenial
sudo sh -c "echo \"deb http://download.virtualbox.org/virtualbox/debian $OSDIST contrib\" >> /etc/apt/sources.list.d/virtualbox.list"

# Setup the keyring to enable a trust relationship with the new repository
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# We can now update the repository listings and install virtualbox 5.2
sudo apt update
sudo apt install virtualbox-5.2

sudo /sbin/vboxconfig



