#!/bin/bash

# Reference: https://howtoprogram.xyz/2016/07/23/install-vagrant-ubuntu-16-04/

# For Ubuntu 1604
# Download package
wget https://releases.hashicorp.com/vagrant/2.1.4/vagrant_2.1.4_x86_64.deb

# Install vagrant
sudo dpkg -i vagrant_2.1.4_x86_64.deb

vagrant -v

# Uninstall vagrant
#sudo dpkg -r vagrant

