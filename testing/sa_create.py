#!/usr/bin/python3
# -*- coding: utf-8 -*-


import yaml

from jinja2 import 

with open("sa01.yml", "r") as stream:
	
    s = yaml.load(stream)
#print(s["tables"][0])

output_file = "sa_output.txt"
for table in s['tables']:
    with open(output_file, 'w') as f:
        f.write("\n")
    print(table['name'])
    with open(output_file, 'a') as f:
        f.write(str(table['name'])+"\n")
    for column in table['columns']:
        print(column)
        print(column['name'])
        if "column['foreign_key']" in locals(): print(column['foreign_key'])
        if "column['nullable']" in locals(): print(column['nullable'])
        if "column['primary_key']" in locals(): print(column['primary_key'])
        if "column['type']" in locals(): print(column['type'])
        with open(output_file, 'a') as f:
            f.write(str(column)+"\n")

#TODO: https://stackoverflow.com/questions/38642557/how-to-load-jinja-template-directly-from-filesystem/38642558

