#!/bin/bash

HOSTNAME=$(hostname)
cp /vagrant/keys/$HOSTNAME/id_rsa* ~/.ssh
