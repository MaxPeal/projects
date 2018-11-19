
import jinja2
import yaml

SCHEMA_FILE="models.yml"
TEMPLATE_DIR = "./"
TEMPLATE_FILE_DB_CREATE = "db_create.j2"
OUTPUT_FILE_DB_CREATE = "db_create.sh"
TEMPLATE_FILE_SQLAORM_DB_CONNECT = "db.j2"
OUTPUT_FILE_SQLAORM_DB_CONNECT = "db.py"
TEMPLATE_FILE_SQLAORM_TABLE_CREATE = "models.j2"
OUTPUT_FILE_SQLAORM_TABLE_CREATE = "models.py"
TEMPLATE_FILE_APP_INIT = "app_init.j2"
OUTPUT_FILE_APP_INIT = "app_init.py"
TEMPLATE_FILE_APP = "app.j2"
OUTPUT_FILE_APP = "app.py"
# loading yaml file
with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
    s = yaml.load(f)


templateLoader = jinja2.FileSystemLoader(searchpath=TEMPLATE_DIR)
templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)

# generating db init script
template = templateEnv.get_template(TEMPLATE_FILE_DB_CREATE)
renderedText = template.render(host=s["host"])
with open(OUTPUT_FILE_DB_CREATE, "w") as f:
    f.write(renderedText)
print(renderedText)

# generating script
template = templateEnv.get_template(TEMPLATE_FILE_SQLAORM_DB_CONNECT)
renderedText = template.render(host=s["host"]) # this is where to put args to the template renderer
with open(OUTPUT_FILE_SQLAORM_DB_CONNECT, "w") as f:
    f.write(renderedText)
print(renderedText)

# generating script
template = templateEnv.get_template(TEMPLATE_FILE_SQLAORM_TABLE_CREATE)
renderedText = template.render(host=s["host"]) # this is where to put args to the template renderer
with open(OUTPUT_FILE_SQLAORM_TABLE_CREATE, "w") as f:
    f.write(renderedText)
print(renderedText)

# generating script
template = templateEnv.get_template(TEMPLATE_FILE_APP_INIT)
renderedText = template.render(host=s["host"]) # this is where to put args to the template renderer
with open(OUTPUT_FILE_APP_INIT, "w") as f:
    f.write(renderedText)
print(renderedText)

# generating script
template = templateEnv.get_template(TEMPLATE_FILE_APP)
renderedText = template.render(host=s["host"]) # this is where to put args to the template renderer
with open(OUTPUT_FILE_APP, "w") as f:
    f.write(renderedText)
print(renderedText)
