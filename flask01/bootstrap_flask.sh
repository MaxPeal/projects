#!/bin/bash
# In order to avoid the message
# "==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory"
# use " > /dev/null 2>&1" in order to redirect stdout to /dev/null
# For more info see http://stackoverflow.com/questions/10508843/what-is-dev-null-21
 
#sudo apt-get update
#sudo apt-get install -y python python-pip python-dev build-essential > /dev/null 2>&1

#sudo pip install --upgrade pip > /dev/null 2>&1
#sudo pip install --upgrade virtualenv > /dev/null 2>&1
#sudo pip install --upgrade pip
#sudo pip install --upgrade virtualenv
sudo apt-get install -y python3 python3-pip python3-dev > /dev/null 2>&1
sudo pip3 install --upgrade pip
sudo pip3 install --upgrade virtualenv

mkdir microblog
cd microblog
python3 -m venv venv
#virtualenv venv
#
. venv/bin/activate

pip install flask


