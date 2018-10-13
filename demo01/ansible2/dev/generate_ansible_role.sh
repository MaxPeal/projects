#!/bin/bash
CMT=""
CMT2="#"
ROLE=${1:-test}
ROLE_BASE_DIR=roles/$ROLE
DEFAULTS_DIR=$ROLE_BASE_DIR/defaults
FILES_DIR=$ROLE_BASE_DIR/files
HANDLERS_DIR=$ROLE_BASE_DIR/handlers
META_DIR=$ROLE_BASE_DIR/meta
TASKS_DIR=$ROLE_BASE_DIR/tasks
TEMPLATES_DIR=$ROLE_BASE_DIR/templates
TEMPLATE_PLAYBOOK_DIR=. #$ROLE_BASE_DIR
TEMPLATE_VARSFILES_DIR=. #$ROLE_BASE_DIR
TESTS_DIR=$ROLE_BASE_DIR/tests
VARS_DIR=$ROLE_BASE_DIR/vars
mkdir -p $DEFAULTS_DIR
mkdir -p $FILES_DIR
mkdir -p $HANDLERS_DIR
mkdir -p $META_DIR
mkdir -p $TASKS_DIR
mkdir -p $TEMPLATES_DIR
mkdir -p $TEMPLATE_PLAYBOOK_DIR
mkdir -p $TEMPLATE_VARSFILES_DIR
mkdir -p $TESTS_DIR
mkdir -p $VARS_DIR
DEFAULTS_FILE=$DEFAULTS_DIR/main.yml
HANDLERS_FILE=$HANDLERS_DIR/main.yml
TASKS_FILE_MAIN=$TASKS_DIR/main.yml
TASKS_FILE_CREATE=$TASKS_DIR/${ROLE}_create.yml
TASKS_FILE_READ=$TASKS_DIR/${ROLE}_read.yml
TASKS_FILE_UPDATE=$TASKS_DIR/${ROLE}_update.yml
TASKS_FILE_DELETE=$TASKS_DIR/${ROLE}_delete.yml
TEMPLATE_FILE=$TEMPLATES_DIR/${ROLE}_conf.j2
PLAYBOOK_TEMPLATE_FILE=$TEMPLATE_PLAYBOOK_DIR/${ROLE}_playbook_template.yml
VARSFILE_TEMPLATE_FILE_MAIN=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_main_template.yml
VARSFILE_TEMPLATE_FILE_CREATE=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_create_template.yml
VARSFILE_TEMPLATE_FILE_READ=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_read_template.yml
VARSFILE_TEMPLATE_FILE_UPDATE=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_update_template.yml
VARSFILE_TEMPLATE_FILE_DELETE=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_delete_template.yml
VARS_FILE=$VARS_DIR/main.yml





###### defaults/main.yml
#PURPOSE="default"
#SPECIFICATION="from ${ROLE} defaults"
#cat <<EOF > $DEFAULTS_FILE
#---
#### ${ROLE}_main_variables
#${CMT2}${ROLE}_main_var_0: "${SPECIFICATION} 0"
#${CMT2}${ROLE}_main_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
#${CMT2}${ROLE}_main_vars_0: 
#${CMT2}  - ${SPECIFICATION} 0
#${CMT2}  - ${SPECIFICATION} 1
#${CMT2}  - ${SPECIFICATION} 2
#${CMT2}${ROLE}_main_vars_1: 
#${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
#${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
#### ${ROLE}_create_variables
#${CMT2}${ROLE}_create_var_0: "${SPECIFICATION} 0"
#${CMT2}${ROLE}_create_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
#${CMT2}${ROLE}_create_vars_0: 
#${CMT2}  - ${SPECIFICATION} 0
#${CMT2}  - ${SPECIFICATION} 1
#${CMT2}  - ${SPECIFICATION} 2
#${CMT2}${ROLE}_create_vars_1: 
#${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
#${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
#### ${ROLE}_read_variables
#${CMT2}${ROLE}_read_var_0: "${SPECIFICATION} 0"
#${CMT2}${ROLE}_read_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
#${CMT2}${ROLE}_read_vars_0: 
#${CMT2}  - ${SPECIFICATION} 0
#${CMT2}  - ${SPECIFICATION} 1
#${CMT2}  - ${SPECIFICATION} 2
#${CMT2}${ROLE}_read_vars_1: 
#${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
#${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
#### ${ROLE}_update_variables
#${CMT2}${ROLE}_update_var_0: "${SPECIFICATION} 0"
#${CMT2}${ROLE}_update_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
#${CMT2}${ROLE}_update_vars_0: 
#${CMT2}  - ${SPECIFICATION} 0
#${CMT2}  - ${SPECIFICATION} 1
#${CMT2}  - ${SPECIFICATION} 2
#${CMT2}${ROLE}_update_vars_1: 
#${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
#${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
#### ${ROLE}_delete_variables
#${CMT2}${ROLE}_delete_var_0: "${SPECIFICATION} 0"
#${CMT2}${ROLE}_delete_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
#${CMT2}${ROLE}_delete_vars_0: 
#${CMT2}  - ${SPECIFICATION} 0
#${CMT2}  - ${SPECIFICATION} 1
#${CMT2}  - ${SPECIFICATION} 2
#${CMT2}${ROLE}_delete_vars_1: 
#${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
#${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
#EOF

##### handlers/main.yml
PURPOSE="handler"
SPECIFICATION="handler"
cat <<EOF > $HANDLERS_FILE
---
### ${ROLE}_${PURPOSE}_main
${CMT}- name: ${ROLE}_${PURPOSE}_main_0
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_main_0 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_main
${CMT}- name: ${ROLE}_${PURPOSE}_main_1
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_main_1 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_main
### ${ROLE}_${PURPOSE}_create
${CMT}- name: ${ROLE}_${PURPOSE}_create_0
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_create_0 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_create
${CMT}- name: ${ROLE}_${PURPOSE}_create_1
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_create_1 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_create
### ${ROLE}_${PURPOSE}_read
${CMT}- name: ${ROLE}_${PURPOSE}_read_0
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_read_0 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_read
${CMT}- name: ${ROLE}_${PURPOSE}_read_1
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_read_1 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_read
### ${ROLE}_${PURPOSE}_update
${CMT}- name: ${ROLE}_${PURPOSE}_update_0
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_update_0 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_update
${CMT}- name: ${ROLE}_${PURPOSE}_update_1
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_update_1 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_update
### ${ROLE}_${PURPOSE}_delete
${CMT}- name: ${ROLE}_${PURPOSE}_delete_0
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_delete_0 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_delete
${CMT}- name: ${ROLE}_${PURPOSE}_delete_1
${CMT}  debug: {msg: ${ROLE}_${PURPOSE}_delete_1 is notified!}
${CMT}  listen: ${ROLE}_${PURPOSE}_delete


EOF

##### tasks/main.yml
PURPOSE="main"
SPECIFICATION="from ${ROLE} main"
cat <<EOF > $TASKS_FILE_MAIN
---
${CMT}- name: debug for ${ROLE}_${PURPOSE}
${CMT}  debug: {msg: task - ${ROLE}_${PURPOSE} }
${CMT}- debug: {var: action}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_var_0}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_var_1}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_vars_0}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_vars_1}
${CMT}
${CMT}- name: calling task - ${ROLE}_create.yml
${CMT}  import_tasks: ${ROLE}_create.yml
${CMT}  vars:
${CMT}    ${ROLE}_create_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_create_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_create_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_create_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}     
${CMT}  when: action == "create"
${CMT}
${CMT}- name: calling task - ${ROLE}_read.yml
${CMT}  import_tasks: ${ROLE}_read.yml
${CMT}  vars:
${CMT}    ${ROLE}_read_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_read_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_read_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_read_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "read"
${CMT}
${CMT}- name: calling task - ${ROLE}_update.yml
${CMT}  import_tasks: ${ROLE}_update.yml
${CMT}  vars:
${CMT}    ${ROLE}_update_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_update_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_update_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_update_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "update"
${CMT}
${CMT}- name: calling task - ${ROLE}_delete.yml
${CMT}  import_tasks: ${ROLE}_delete.yml
${CMT}  vars:
${CMT}    ${ROLE}_delete_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_delete_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_delete_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_delete_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "delete"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_create.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_create
${CMT}  vars:
${CMT}    ${ROLE}_create_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_create_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_create_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_create_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "${ROLE}_create"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_read.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_read
${CMT}  vars:
${CMT}    ${ROLE}_read_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_read_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_read_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_read_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "${ROLE}_read"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_update.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}
${CMT}    tasks_from: ${ROLE}_update
${CMT}  vars:
${CMT}    ${ROLE}_update_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_update_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_update_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_update_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "${ROLE}_update"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_delete.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_delete
${CMT}  vars:
${CMT}    ${ROLE}_delete_var_0: "${SPECIFICATION} 0"
${CMT}    ${ROLE}_delete_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT}    ${ROLE}_delete_vars_0: 
${CMT}      - ${SPECIFICATION} 0
${CMT}      - ${SPECIFICATION} 1
${CMT}      - ${SPECIFICATION} 2
${CMT}    ${ROLE}_delete_vars_1: 
${CMT}      - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT}      - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
${CMT}  when: action == "${ROLE}_delete"

# references:
# https://docs.ansible.com/ansible/latest/modules/import_role_module.html

EOF

##### tasks ${ROLE}_create.yml
PURPOSE="create"
SPECIFICATION="from ${ROLE}_create"
cat <<EOF > $TASKS_FILE_CREATE
---
${CMT}- name: debug for ${ROLE}_${PURPOSE}
${CMT}  debug: {msg: task - ${ROLE}_${PURPOSE} }
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_var_0}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_var_1}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_vars_0}
${CMT}- debug: {var: ${ROLE}_${PURPOSE}_vars_1}

EOF

##### tasks ${ROLE}_read.yml
cp $TASKS_FILE_CREATE $TASKS_FILE_READ
sed -i -e 's/create/read/g' $TASKS_FILE_READ

##### tasks ${ROLE}_update.yml
cp $TASKS_FILE_CREATE $TASKS_FILE_UPDATE
sed -i -e 's/create/update/g' $TASKS_FILE_UPDATE

##### tasks ${ROLE}_delete.yml
cp $TASKS_FILE_CREATE $TASKS_FILE_DELETE
sed -i -e 's/create/delete/g' $TASKS_FILE_DELETE

##### templates ${ROLE}_conf.j2
PURPOSE="template"
SPECIFICATION="template"
cat <<EOF > $TEMPLATE_FILE
#jinja2: lstrip_blocks: True, trim_blocks: True

{# if a variable is defined and not empty #}
{% if	${ROLE}_main_var_0 is defined and
	${ROLE}_main_var_0 | length > 0
%}
${ROLE}_main_var_0: {{ ${ROLE}_main_var_0 }}
{% endif %}

{# handling loop for dictionary #}
{% for key, value in ${ROLE}_main_var_1.iteritems() %} 
${ROLE}_main_var_1.{{key}}: {{value}}
{% endfor %}

{# handling loop for array #}
{% for item in ${ROLE}_main_vars_0 %}
${ROLE}_main_vars_0.{{loop.index0}}: {{ item }}
{% endfor %}

{# handling loop for array #}
{% for dict in ${ROLE}_main_vars_1 %}
{% 	for key, value in dict.iteritems() %} 
${ROLE}_main_vars_1.{{key}}: {{value}}
{% 	endfor %}
{% endfor %}

# references:
# http://jinja.pocoo.org/docs/2.10/templates/#for
	
EOF

##### template playbook (role based)
PURPOSE="template"
SPECIFICATION="template"
cat <<EOF > $PLAYBOOK_TEMPLATE_FILE
---
${CMT}- hosts:
${CMT}    - localhost
${CMT}    #- otherhost
${CMT}  roles:
${CMT}    - {role: ${ROLE}, action: create}
${CMT}    - {role: ${ROLE}, action: read}
${CMT}    - {role: ${ROLE}, action: update}
${CMT}    - {role: ${ROLE}, action: delete}
${CMT}  vars_files:
${CMT}    - $VARSFILE_TEMPLATE_FILE_MAIN
${CMT}    - $VARSFILE_TEMPLATE_FILE_CREATE
${CMT}    - $VARSFILE_TEMPLATE_FILE_READ
${CMT}    - $VARSFILE_TEMPLATE_FILE_UPDATE
${CMT}    - $VARSFILE_TEMPLATE_FILE_DELETE
${CMT}  #vars:
EOF

##### defaults/main.yml
PURPOSE="default"
SPECIFICATION="from ${ROLE} defaults"
cat <<EOF > $DEFAULTS_FILE
---
EOF

##### vars/main.yml
PURPOSE="default"
SPECIFICATION="from ${ROLE} vars"
cat <<EOF > $VARS_FILE
---
EOF

##### template varsfiles (main)
PURPOSE="varsfiles"
SPECIFICATION="varsfiles"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_MAIN
---
### ${ROLE}_main_variables
${CMT2}${ROLE}_main_var_0: "${SPECIFICATION} 0"
${CMT2}${ROLE}_main_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT2}${ROLE}_main_vars_0: 
${CMT2}  - ${SPECIFICATION} 0
${CMT2}  - ${SPECIFICATION} 1
${CMT2}  - ${SPECIFICATION} 2
${CMT2}${ROLE}_main_vars_1: 
${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_MAIN >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_MAIN >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_MAIN >> $PLAYBOOK_TEMPLATE_FILE


##### template varsfiles (create)
PURPOSE="varsfiles"
SPECIFICATION="varsfiles"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_CREATE
---
### ${ROLE}_create_variables
${CMT2}${ROLE}_create_var_0: "${SPECIFICATION} 0"
${CMT2}${ROLE}_create_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT2}${ROLE}_create_vars_0: 
${CMT2}  - ${SPECIFICATION} 0
${CMT2}  - ${SPECIFICATION} 1
${CMT2}  - ${SPECIFICATION} 2
${CMT2}${ROLE}_create_vars_1: 
${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_CREATE >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_CREATE >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_CREATE >> $PLAYBOOK_TEMPLATE_FILE

##### template varsfiles (read)
PURPOSE="varsfiles"
SPECIFICATION="varsfiles"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_READ
---
### ${ROLE}_read_variables
${CMT2}${ROLE}_read_var_0: "${SPECIFICATION} 0"
${CMT2}${ROLE}_read_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT2}${ROLE}_read_vars_0: 
${CMT2}  - ${SPECIFICATION} 0
${CMT2}  - ${SPECIFICATION} 1
${CMT2}  - ${SPECIFICATION} 2
${CMT2}${ROLE}_read_vars_1: 
${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_READ >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_READ >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_READ >> $PLAYBOOK_TEMPLATE_FILE

##### template varsfiles (update)
PURPOSE="varsfiles"
SPECIFICATION="varsfiles"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_UPDATE
---
### ${ROLE}_update_variables
${CMT2}${ROLE}_update_var_0: "${SPECIFICATION} 0"
${CMT2}${ROLE}_update_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT2}${ROLE}_update_vars_0: 
${CMT2}  - ${SPECIFICATION} 0
${CMT2}  - ${SPECIFICATION} 1
${CMT2}  - ${SPECIFICATION} 2
${CMT2}${ROLE}_update_vars_1: 
${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_UPDATE >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_UPDATE >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_UPDATE >> $PLAYBOOK_TEMPLATE_FILE

##### template varsfiles (delete)
PURPOSE="varsfiles"
SPECIFICATION="varsfiles"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_DELETE
---
### ${ROLE}_delete_variables
${CMT2}${ROLE}_delete_var_0: "${SPECIFICATION} 0"
${CMT2}${ROLE}_delete_var_1: {msg1: ${SPECIFICATION} 0, msg2: ${SPECIFICATION} 1}
${CMT2}${ROLE}_delete_vars_0: 
${CMT2}  - ${SPECIFICATION} 0
${CMT2}  - ${SPECIFICATION} 1
${CMT2}  - ${SPECIFICATION} 2
${CMT2}${ROLE}_delete_vars_1: 
${CMT2}  - {key0: ${SPECIFICATION} 0, key1: ${SPECIFICATION} 01}
${CMT2}  - {key0: ${SPECIFICATION} 1, key1: ${SPECIFICATION} 11}
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_DELETE >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_DELETE >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_DELETE >> $PLAYBOOK_TEMPLATE_FILE

#cp $PLAYBOOK_TEMPLATE_FILE
