# -*- coding: utf-8 -*-

import jinja2
import yaml
# schema
with open("sa01.yml", "r") as stream:
    s = yaml.load(stream)
#stream.close()
# data
with open(s["meta"]["data"]+".yml", "r") as stream:
    d = yaml.load(stream)
#stream.close()

TEMPLATE_DIR = "./"
TEMPLATE_FILE = "sa01.j2"
OUTPUT_FILE = "sa01.py"
DML_TEMP="sa01_dml.j2"
DML_FILE="sa01_dml.py"
templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)
template = templateEnv.get_template(TEMPLATE_FILE)
outputText = template.render(database=s["database"], tables=s["tables"]) # this is where to put args to the template renderer
with open(OUTPUT_FILE, "w") as f:
    f.write(outputText)
#f.close()
print(outputText)

template = templateEnv.get_template(DML_TEMP)
outputText = template.render(tables=d["data"]["tables"])
with open(DML_FILE, "w") as f:
    f.write(outputText)
#f.close()
print(outputText)
