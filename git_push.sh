#!/bin/bash
HOSTNAME=$(hostname)
git config --global user.email "ktaiga@$HOSTNAME"
git config --global user.name "ktaiga"

git add *
git commit -m "wtf"
git push origin master
