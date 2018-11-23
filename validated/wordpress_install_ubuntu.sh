#!/bin/bash

sudo apt-get update

sudo apt-get install apache2 apache2-utils
sudo systemctl enable apache2
sudo systemctl start apache2


# install php and modules
#sudo apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
sudo apt-get install php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
udo systemctl restart apache2

cat <<EOF | sudo tree -a /etc/apache2/apache2.conf
#>>>>>
<Directory /var/www/html/>
    AllowOverride All
</Directory>
#<<<<<
EOF

sudo a2enmod rewrite
sudo apache2ctl configtest

sudo systemctl restart apache2

# mariadb install
./mariadb_install_ubuntu.sh

# setting up mariadb
PASSWORD=Super123
DB=wp_myblog
DBADMIN=wordpress
DBPASSWORD=Super123
#DBHOST=localhost
DBHOST=% # for remote user
sudo mysql -uroot -p${PASSWORD} -e "CREATE DATABASE $DB;" 2> /dev/null
sudo mysql -uroot -p${PASSWORD} -e "DROP USER '${DBADMIN}'@'${DBHOST}';" 2> /dev/null
sudo mysql -uroot -p${PASSWORD} -e "CREATE USER '${DBADMIN}'@'${DBHOST}' IDENTIFIED BY '${DBPASSWORD}';"
sudo mysql -uroot -p${PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${DBADMIN}'@'${DBHOST}' WITH GRANT OPTION;"
sudo mysql -uroot -p${PASSWORD} -e "FLUSH PRIVILEGES;"


# downloading wordpress cms
cd /tmp
wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
touch /tmp/wordpress/.htaccess
chmod 660 /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
sudo cp -a /tmp/wordpress/. /var/www/html



#sudo rsync -av wordpress/* /var/www/html/

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chmod -R g+w /var/www/html/wp-content/plugins


WP_CONF=/var/www/html/wp-config.php
#sudo mv /var/www/html/wp-config-sample.php $WP_CONF
sudo cp /var/www/html/wp-config-sample.php $WP_CONF
#sudo sed -i -e "s/database_name_here/$DB/" $WP_CONF
sudo sed -i -e "s/'DB_NAME', 'database_name_here'/'DB_NAME', '$DB'/" $WP_CONF
sudo sed -i -e "s/'DB_USER', 'username_here'/'DB_USER', '$DBADMIN'/" $WP_CONF
sudo sed -i -e "s/'DB_PASSWORD', 'password_here'/'DB_PASSWORD', '$DBPASSWORD'/" $WP_CONF

#cat <<EOF | sudo tee /var/www/html/wp-config.php
#//>>>>>
#define('DB_NAME', '$DB');
#define('DB_USER', '$DBADMIN');
#define('DB_PASSWORD', '$DBPASSWORD');
#define('DB_HOST', 'localhost');
#define('DB_CHARSET', 'utf8');
#define('DB_COLLATE', '');
#
#define('AUTH_KEY',         'put your unique phrase here');
#define('SECURE_AUTH_KEY',  'put your unique phrase here');
#define('LOGGED_IN_KEY',    'put your unique phrase here');
#define('NONCE_KEY',        'put your unique phrase here');
#define('AUTH_SALT',        'put your unique phrase here');
#define('SECURE_AUTH_SALT', 'put your unique phrase here');
#define('LOGGED_IN_SALT',   'put your unique phrase here');
#define('NONCE_SALT',       'put your unique phrase here');
#
#/** The Database Collate type. Don't change this if in doubt. */
#
#//<<<<<
#EOF

sudo systemctl restart apache2.service 
sudo systemctl restart mysql.service 




