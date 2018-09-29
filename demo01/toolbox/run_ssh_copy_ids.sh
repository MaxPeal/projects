#!/bin/bash
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@control
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@nat01
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@client00
