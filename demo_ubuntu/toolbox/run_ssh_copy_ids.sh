#!/bin/bash
sshpass -f ./password.txt ssh-copy-id vagrant@node-2
sshpass -f ./password.txt ssh-copy-id vagrant@node-3
