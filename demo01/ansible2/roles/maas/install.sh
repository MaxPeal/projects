#!/bin/bash
sudo apt-add-repository -yu ppa:maas/stable

sudo apt install -y maas

#sudo apt install -y maas-region-controller
# at rack controller on another
#sudo apt install -y maas-rack-controller
#sudo maas-rack register

PROFILE="admin"
EMAIL_ADDRESS="admin@smci"
PASSWORD="Super123"
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS --password=$PASSWORD
