#!/bin/bash

# modify sshd configuration file
# allow password authentication
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
sudo service sshd restart
