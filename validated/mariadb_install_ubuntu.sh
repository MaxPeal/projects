#!/bin/bash

PASSWORD=Super123
DBADMIN=mariadb
#DBHOST=localhost
DBHOST=% # for remote user
export DEBIAN_FRONTEND="noninteractive"
#sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $PASSWORD"
#sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $PASSWORD" 

echo "mariadb-server mysql-server/root_password password $PASSWORD" | sudo debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password $PASSWORD" | sudo debconf-set-selections
sudo sed -i -e "s/^bind-address/#bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo apt-get install -y mariadb-server python-mysqldb

# create new root user (root not longer allow login via phpmyadmin...)
#sudo mysql -uroot -p${PASSWORD} -e "DROP USER IF EXISTS '${DBADMIN}'@'${DBHOST}';"
sudo mysql -uroot -p${PASSWORD} -e "DROP USER '${DBADMIN}'@'${DBHOST}';" 2> /dev/null
sudo mysql -uroot -p${PASSWORD} -e "CREATE USER '${DBADMIN}'@'${DBHOST}' IDENTIFIED BY '${PASSWORD}';"
sudo mysql -uroot -p${PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${DBADMIN}'@'${DBHOST}' WITH GRANT OPTION;"
sudo mysql -uroot -p${PASSWORD} -e "FLUSH PRIVILEGES;"



