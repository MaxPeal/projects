#!/usr/bin/python3
# -*- coding: utf-8 -*-

#from yaml import load, dump
#try:
#    from yaml import CLoader as Loader, CDumper as Dumper
#except:
#    from yaml import Loader, Dumper

import yaml

document = """
a: 1
b:
  c: 3
  d: 4

"""

print(yaml.dump(yaml.load(document)))

o = yaml.load(document)
print(o)

#print(o[0])
print(o['a'])
print(o.a)
