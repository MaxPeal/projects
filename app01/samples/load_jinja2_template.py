
import jinja2
import yaml

SCHEMA_FILE="test.yml"
TEMPLATE_DIR = "./"
TEMPLATE_FILE = "test.j2"
OUTPUT_FILE = "test.py"
# loading yaml file
with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
    s = yaml.load(f)

# loading jinja2 template
templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)
template = templateEnv.get_template(TEMPLATE_FILE)
renderedText = template.render(database=s["database"]) # this is where to put args to the template renderer

# writing rendered output
with open(OUTPUT_FILE, "w") as f:
    f.write(renderedText)
print(renderedText)
