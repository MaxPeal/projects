#!/bin/bash

sudo apt-get udpate
sudo apt-get -y install apache2


SSL_C=US #country
SSL_ST=CA #state
SSL_L="San Jose" #city
SSL_O="My Company (Example)" # company name
SSL_OU="My Dept. (Example)" # dept. name
SSL_HOST_NAME=$(hostname)
SSL_SERVER_ADMIN=$(whoami)@$(hostname)
SSL_CN=$SSL_HOST_NAME # common name (host name, server name, fqdn etc.)

SSL_PARAMS_CONF=/etc/apache2/conf-available/ssl-params.conf
# Step 1: Create the SSL Certificate

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=$SSL_C/ST=$SSL_ST/L=$SSL_L/O=$SSL_O/OU=$SSL_OU/CN=$SSL_CN"

sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Step 2: Configure Apache to Use SSL
cat <<EOF | sudo tee $SSL_PARAMS_CONF
# from https://cipherli.st/
# and https://raymii.org/s/tutorials/Strong_SSL_Security_On_Apache2.html

SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3
SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
#Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains; preload"
Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains"
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
SSLCompression off 
SSLSessionTickets Off
SSLUseStapling on 
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"

SSLOpenSSLConfCmd DHParameters "/etc/ssl/certs/dhparam.pem"
EOF
SSL_DEFAULT_SSL_CONF=/etc/apache2/sites-available/default-ssl.conf
SSL_DEFAULT_SSL_CONF_BACKUP=${SSL_DEFAULT_SSL_CONF}.backup
if [ !-f $SSL_DEFAULT_SSL_CONF_BACKUP ]; then
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak
fi

cat <<EOF | sudo tee $SSL_DEFAULT_SSL_CONF
#>>>>>
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin $SSL_SERVER_ADMIN
		ServerName $SSL_HOST_NAME

                DocumentRoot /var/www/html

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

                # BrowserMatch "MSIE [2-6]" \
                #               nokeepalive ssl-unclean-shutdown \
                #               downgrade-1.0 force-response-1.0

        </VirtualHost>
</IfModule>
#<<<<<
EOF

# (Recommended) Modify the Unencrypted Virtual Host File to Redirect to HTTPS
cat<<EOF | sudo tee /etc/apache2/sites-available/000-default.conf
#>>>>>
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin $SSL_SERVER_ADMIN
        DocumentRoot /var/www/html

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
	Redirect permanent "/" "https://$SSL_HOST_NAME/"
</VirtualHost>
#<<<<<
EOF

# Step 3: Adjust the Firewall
sudo ufw app list
sudo ufw status
sudo ufw allow 'Apache Full'
sudo ufw delete allow 'Apache'
sudo ufw status

# Step 4: Enable the Changes in Apache
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite default-ssl
sudo a2enconf ssl-params
sudo apache2ctl configtest
sudo systemctl restart apache2

