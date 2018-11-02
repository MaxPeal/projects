#!/usr/bin/python3
# -*- coding: utf-8 -*-


import yaml


with open("sa01.yml", "r") as stream:
	
	s = yaml.load(stream)
print(s["tables"][0])

