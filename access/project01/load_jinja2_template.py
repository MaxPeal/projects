
import jinja2
import yaml

SCHEMA_FILE="models.yml"
TEMPLATE_DIR = "./"
J2_TEMPLATE_FILE = "arewell_db_schema.j2"
OUTPUT_FILE = "db_create.sh"

# loading yaml file
with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
    s = yaml.load(f)

# preparing
templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)

# reading j2 template
template = templateEnv.get_template(J2_TEMPLATE_FILE)
# rendering and writing to file
renderedText = template.render(host=s["host"])
with open(OUTPUT_FILE, "w") as f:
    f.write(renderedText)
print(renderedText)

