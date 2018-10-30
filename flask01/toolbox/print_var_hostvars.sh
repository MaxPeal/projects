#!/bin/bash

#ansible -m debug -a "var=hostvars" all
ansible -m debug -a "var=hostvars" localhost

