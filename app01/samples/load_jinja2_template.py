
import jinja2
import yaml

SCHEMA_FILE="test_schema.yml"
TEMPLATE_DIR = "./"
TEMPLATE_FILE_DB_INIT = "test_schema_db_create.j2"
OUTPUT_FILE_DB_INIT = "test_schema_db_create.sh"
TEMPLATE_FILE_TABLE_INIT = "test_schema_table_create.j2"
OUTPUT_FILE_TABLE_INIT = "test_schema_table_create.py"
# loading yaml file
with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
    s = yaml.load(f)


templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)

# generating db init script
template = templateEnv.get_template(TEMPLATE_FILE_DB_INIT)
renderedText = template.render(host=s["host"])
with open(OUTPUT_FILE_DB_INIT, "w") as f:
    f.write(renderedText)
print(renderedText)

# generating table init script
template = templateEnv.get_template(TEMPLATE_FILE_TABLE_INIT)
renderedText = template.render(host=s["host"]) # this is where to put args to the template renderer
with open(OUTPUT_FILE_TABLE_INIT, "w") as f:
    f.write(renderedText)
print(renderedText)
