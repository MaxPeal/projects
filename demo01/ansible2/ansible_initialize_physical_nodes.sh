#!/bin/bash

ssh-keygen -R phy01
ssh-keygen -R phy02
ssh-keygen -R phy03
ansible-playbook -i ansible_hosts_step1 test_sshd_auth_allow.yml
ansible-playbook -i ansible_hosts_step1 user_add.yml 

