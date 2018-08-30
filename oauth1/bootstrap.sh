#!/bin/bash

##### This script is for Ubuntu 16.04
# Install virtual env on ubuntu 16.04
# Ref: https://gist.github.com/Geoyi/d9fab4f609e9f75941946be45000632b

### Setup SSH
# ssh: enable password authentication
sudo sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
# restart ssh
sudo service sshd restart

### Setup ansible (Ubuntu Specific)
# install ansible
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible


### Setup flask
# install pip
sudo apt-get update
sudo apt-get install python3-pip -y
# install virtual environment
sudo pip3 install virtualenv 

# create virtual environment
virtualenv venv
# activate virtual environment
source venv/bin/activate

# install flask
pip install Flask

