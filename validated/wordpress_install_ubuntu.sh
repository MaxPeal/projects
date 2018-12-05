#!/bin/bash

sudo apt-get update

./lamp_install_ubuntu.sh

# setting up mariadb
PASSWORD=Super123
DB=wordpress
DBADMIN=wordpressuser
DBPASSWORD=Super123
#DBHOST=localhost
DBHOST=% # for remote user
sudo mysql -uroot -p${PASSWORD} -e "CREATE DATABASE $DB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" 2> /dev/null
sudo mysql -uroot -p${PASSWORD} -e "DROP USER '${DBADMIN}'@'${DBHOST}';" 2> /dev/null
sudo mysql -uroot -p${PASSWORD} -e "CREATE USER '${DBADMIN}'@'${DBHOST}' IDENTIFIED BY '${DBPASSWORD}';"
sudo mysql -uroot -p${PASSWORD} -e "GRANT ALL PRIVILEGES ON $DB.* TO '${DBADMIN}'@'${DBHOST}' WITH GRANT OPTION;"
sudo mysql -uroot -p${PASSWORD} -e "FLUSH PRIVILEGES;"

# installing additional php extensions
sudo apt-get update
sudo apt-get install -y php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc

sudo systemctl restart apache2

# 
sudo sed -i -e "/#>>>>>/,/#<<<<</d" /etc/apache2/apache2.conf
cat <<EOF | sudo tee -a /etc/apache2/apache2.conf
#>>>>>

<Directory /var/www/html/>
    AllowOverride All
</Directory>

#<<<<<
EOF

sudo a2enmod rewrite
sudo apache2ctl configtest

sudo systemctl restart apache2



# downloading wordpress cms
cd /tmp
wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
touch /tmp/wordpress/.htaccess
chmod 660 /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
sudo rm -Rf /var/www/html
sudo cp -a /tmp/wordpress/. /var/www/html

# configure the wordpress directory
#WPUSER=vagrant
#usermod -aG www-data vagrant
WPUSER=www-data
sudo chown -R ${WPUSER}:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chmod -R g+w /var/www/html/wp-content/plugins


WP_CONF=/var/www/html/wp-config.php
sudo cp /var/www/html/wp-config-sample.php $WP_CONF

cat <<EOF | sudo tee $WP_CONF
<?php
define('DB_NAME', '$DB');
define('DB_USER', '$DBADMIN');
define('DB_PASSWORD', '$DBPASSWORD');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('FS_METHOD', 'direct');

/**#@+*/
EOF

curl -s https://api.wordpress.org/secret-key/1.1/salt/ | sudo tee -a $WP_CONF

cat <<EOF | sudo tee -a $WP_CONF

/**#@-*/

\$table_prefix  = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');

EOF

sudo systemctl restart apache2.service 
sudo systemctl restart mysql.service 


echo "setting password for user: www-data"
sudo passwd www-data
sudo chsh -s /bin/bash www-data

# install phpmyadmin
~/projects/validated/phpmyadmin_install_ubuntu.sh
 
