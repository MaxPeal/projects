#!/bin/bash

# installing apache
sudo apt-get update
sudo apt-get install -y apache2
sudo apache2ctl configtest


sudo sed -i -e "/#>>>>>/,/#<<<<</d" /etc/apache2/apache2.conf
cat <<EOF | sudo tee -a /etc/apache2/apache2.conf
#>>>>>
ServerName $(hostname)
#<<<<<
EOF
sudo apache2ctl configtest

sudo systemctl restart apache2

# allow apache in firewall
sudo ufw allow in "Apache Full"

# enable ssl on apache2
./ssl_apache_install_ubuntu.sh
# installing mysql
./mariadb_install_ubuntu.sh

# installing php
sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql

# making apache first look for index.php
DIR_CONF=/etc/apache2/mods-enabled/dir.conf
sudo cp $DIR_CONF ${DIR_CONF}.backup
cat <<EOF | sudo tee $DIR_CONF
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
EOF

sudo systemctl restart apache2
#sudo systemctl status apache2

# info.php
cat <<EOF | sudo tee /var/www/html/info.php
<?php
phpinfo();
?>
EOF


