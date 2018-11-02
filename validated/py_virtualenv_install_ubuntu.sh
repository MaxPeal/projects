#!/bin/bash

sudo apt-get update
sudo apt-get install python3-pip
sudo -H pip3 install virtualenv
sudo -H pip3 install --upgrade pip

# to create virtual environment
#virtualenv venv
#virtualenv -p /usr/bin/python2.7 venv
#virtualenv -p python3 venv

# to activate your virutal environment
#source venv/bin/activate

# to deactivate
#deactivate

virtualenv -p python3 ~/venv
. ~/venv/bin/activate

pip install Flask
pip install sqlalchemy

deactivate

#TODO: try pip install -r requirements.txt
# reference: https://stackoverflow.com/questions/7225900/how-to-install-packages-using-pip-according-to-the-requirements-txt-file-from-a
