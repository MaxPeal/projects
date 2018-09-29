#!/bin/bash

echo "SCRIPT: bootstrap_ssh_keygen.sh"
# create ssh knstall sshpass 
sudo apt-get install -y sshpass > /dev/null 2>&1
# create ssh key pair (under vagrant account) 
su - vagrant -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'

