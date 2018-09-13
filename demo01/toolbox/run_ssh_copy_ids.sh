#!/bin/bash
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@control
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@lb01
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@app01
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@app02
sshpass -p 'vagrant' ssh-copy-id -o 'StrictHostKeyChecking no' vagrant@db01
