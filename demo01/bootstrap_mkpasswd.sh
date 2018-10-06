#!/bin/bash

echo "SCRIPT: bootstrap_mkpasswd.sh"

sudo apt-get update
sudo apt-get install -y whois >/dev/null 2>&1

# notes:
# try:
# mkpasswd --method=sha-512 for creating password on user module
# reference:
# https://serversforhackers.com/c/create-user-in-ansible
