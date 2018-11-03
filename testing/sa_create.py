#!/usr/bin/python3
# -*- coding: utf-8 -*-

import jinja2
import yaml

with open("sa01.yml", "r") as stream:
	
    s = yaml.load(stream)

TEMPLATE_DIR = "./"
TEMPLATE_FILE = "sa01.j2"
templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader)
template = templateEnv.get_template(TEMPLATE_FILE)
outputText = template.render(tables=s["tables"]) # this is where to put args to the template renderer

print(outputText)
