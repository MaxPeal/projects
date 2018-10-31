#!/bin/bash
sudo apt-get update
sudo apt-get install -y phpmyadmin php-mbstring php-gettext

sudo phpenmod mcrypt
sudo phpenmod mbstring

sudo systemctl restart apache2


