#!/bin/bash

PASSWORD=Super123
export DEBIAN_FRONTEND="noninteractive"
#sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $PASSWORD"
#sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $PASSWORD" 

echo "mariadb-server mysql-server/root_password password $PASSWORD" | sudo debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password $PASSWORD" | sudo debconf-set-selections
sudo apt-get install -y mariadb-server python-mysqldb
