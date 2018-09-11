#!/bin/bash
sshpass -p "vagrant" ssh-copy-id -o "StrictHostKeyChecking no" vagrant@node-2
sshpass -p "vagrant" ssh-copy-id -o "StrictHostKeyChecking no" vagrant@node-3
sshpass -p "vagrant" ssh-copy-id -o "StrictHostKeyChecking no" vagrant@node-4
sshpass -p "vagrant" ssh-copy-id -o "StrictHostKeyChecking no" vagrant@node-5
sshpass -p "vagrant" ssh-copy-id -o "StrictHostKeyChecking no" vagrant@node-6
