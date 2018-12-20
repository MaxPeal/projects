
import jinja2
import yaml

SCHEMA_FILE="query_schema.yml"
TEMPLATE_DIR = "./"
TEMPLATE_FILE = "query_schema.j2"
OUTPUT_FILE = "query_schema.vba"
# loading yaml file
with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
    s = yaml.load(f)


templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)

# generating db init script
template = templateEnv.get_template(TEMPLATE_FILE)
renderedText = template.render(project=s['project'])
with open(OUTPUT_FILE, "w") as f:
    f.write(renderedText)
print(renderedText)

