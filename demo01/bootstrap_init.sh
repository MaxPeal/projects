#!/bin/bash

echo "SCRIPT: bootstrap_init.sh"

sudo apt-get update
sudo apt-get install -y tree >/dev/null 2>&1
sudo apt-get install -y traceroute >/dev/null 2>&1
