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
TASK0=main
TASK1=create
TASK2="read"
TASK3=update
TASK4=delete
DEFAULTS_FILE=$DEFAULTS_DIR/main.yml
HANDLERS_FILE=$HANDLERS_DIR/main.yml
TASKS_FILE_TASK0=$TASKS_DIR/main.yml
TASKS_FILE_TASK1=$TASKS_DIR/${ROLE}_create.yml
TASKS_FILE_TASK2=$TASKS_DIR/${ROLE}_read.yml
TASKS_FILE_TASK3=$TASKS_DIR/${ROLE}_update.yml
TASKS_FILE_TASK4=$TASKS_DIR/${ROLE}_delete.yml
TEMPLATE_FILE=$TEMPLATES_DIR/${ROLE}_conf.j2
PLAYBOOK_TEMPLATE_FILE=$TEMPLATE_PLAYBOOK_DIR/${ROLE}_playbook_template.yml
VARSFILE_TEMPLATE_FILE_TASK0=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_main_template.yml
VARSFILE_TEMPLATE_FILE_TASK1=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_create_template.yml
VARSFILE_TEMPLATE_FILE_TASK2=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_read_template.yml
VARSFILE_TEMPLATE_FILE_TASK3=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_update_template.yml
VARSFILE_TEMPLATE_FILE_TASK4=$TEMPLATE_VARSFILES_DIR/${ROLE}_vars_delete_template.yml
VARS_FILE=$VARS_DIR/main.yml
# task variables
VAR_TASK0=${ROLE}_main_var
VAR_TASK0_ACTION_TASK1=${ROLE}_main_var_as_action_create
VAR_TASK0_ACTION_TASK2=${ROLE}_main_var_as_action_read
VAR_TASK0_ACTION_TASK3=${ROLE}_main_var_as_action_update
VAR_TASK0_ACTION_TASK4=${ROLE}_main_var_as_action_delete
VAR_TASK0_ACTION_ROLE_TASK1=${ROLE}_main_var_as_action_${ROLE}_create
VAR_TASK0_ACTION_ROLE_TASK2=${ROLE}_main_var_as_action_${ROLE}_read
VAR_TASK0_ACTION_ROLE_TASK3=${ROLE}_main_var_as_action_${ROLE}_update
VAR_TASK0_ACTION_ROLE_TASK4=${ROLE}_main_var_as_action_${ROLE}_delete
VAR_TASK1=${ROLE}_create_var
VAR_TASK2=${ROLE}_read_var
VAR_TASK3=${ROLE}_update_var
VAR_TASK4=${ROLE}_delete_var

##### handlers/main.yml
PURPOSE="handler"
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
SPECIFICATION="value from ${ROLE}_main"
cat <<EOF > $TASKS_FILE_TASK0
---
${CMT}- name: debug for ${ROLE}_${PURPOSE}
${CMT}  debug: {msg: task - ${ROLE}_${PURPOSE} }
${CMT}- debug: {var: action}
${CMT}- debug: {var: $VAR_TASK0}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_TASK1}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_TASK2}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_TASK3}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_TASK4}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_ROLE_TASK1}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_ROLE_TASK2}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_ROLE_TASK3}
${CMT}#- debug: {var: $VAR_TASK0_ACTION_ROLE_TASK4}
${CMT}
${CMT}- name: calling task - ${ROLE}_create.yml
${CMT}  import_tasks: ${ROLE}_create.yml
${CMT}  vars:
${CMT}    $VAR_TASK1: "{{ $VAR_TASK0_ACTION_TASK1 if $VAR_TASK0_ACTION_TASK1 is defined else '_undefined_' }}"
${CMT}  when: action == "create"
${CMT}
${CMT}- name: calling task - ${ROLE}_read.yml
${CMT}  import_tasks: ${ROLE}_read.yml
${CMT}  vars:
${CMT}    $VAR_TASK2: "{{ $VAR_TASK0_ACTION_TASK2 if $VAR_TASK0_ACTION_TASK2 is defined else '_undefined_' }}"
${CMT}  when: action == "read"
${CMT}
${CMT}- name: calling task - ${ROLE}_update.yml
${CMT}  import_tasks: ${ROLE}_update.yml
${CMT}  vars:
${CMT}    $VAR_TASK3: "{{ $VAR_TASK0_ACTION_TASK3 if $VAR_TASK0_ACTION_TASK3 is defined else '_undefined_' }}"
${CMT}  when: action == "update"
${CMT}
${CMT}- name: calling task - ${ROLE}_delete.yml
${CMT}  import_tasks: ${ROLE}_delete.yml
${CMT}  vars:
${CMT}    $VAR_TASK4: "{{ $VAR_TASK0_ACTION_TASK4 if $VAR_TASK0_ACTION_TASK4 is defined else '_undefined_' }}"
${CMT}  when: action == "delete"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_create.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_create
${CMT}  #vars:
${CMT}  #  $VAR_TASK1: "{{ $VAR_TASK0_ACTION_ROLE_TASK1 if $VAR_TASK0_ACTION_ROLE_TASK1 is defined else '_undefined_' }}"
${CMT}  when: action == "${ROLE}_create"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_read.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_read
${CMT}  #vars:
${CMT}  #  $VAR_TASK2: "{{ $VAR_TASK0_ACTION_ROLE_TASK2 if $VAR_TASK0_ACTION_ROLE_TASK2 is defined else '_undefined_' }}"
${CMT}  when: action == "${ROLE}_read"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_update.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_update
${CMT}  #vars:
${CMT}  #  $VAR_TASK3: "{{ $VAR_TASK0_ACTION_ROLE_TASK3 if $VAR_TASK0_ACTION_ROLE_TASK3 is defined else '_undefined_' }}"
${CMT}  when: action == "${ROLE}_update"
${CMT}
${CMT}- name: calling directly task - ${ROLE}_delete.yml under role - ${ROLE}
${CMT}  import_role:
${CMT}    name: ${ROLE}
${CMT}    tasks_from: ${ROLE}_delete
${CMT}  #vars:
${CMT}  #  $VAR_TASK4: "{{ $VAR_TASK0_ACTION_ROLE_TASK4 if $VAR_TASK0_ACTION_ROLE_TASK4 is defined else '_undefined_' }}"
${CMT}  when: action == "${ROLE}_delete"

# references:
# https://docs.ansible.com/ansible/latest/modules/import_role_module.html

EOF

##### tasks ${ROLE}_create.yml
PURPOSE="create"
SPECIFICATION="from ${ROLE}_create"
cat <<EOF > $TASKS_FILE_TASK1
---
${CMT}- name: debug for ${ROLE}_${PURPOSE}
${CMT}  debug: {msg: task - ${ROLE}_${PURPOSE} }
${CMT}- debug: {var: $VAR_TASK1}

EOF

##### tasks ${ROLE}_read.yml
cp $TASKS_FILE_TASK1 $TASKS_FILE_TASK2
sed -i -e 's/create/read/g' $TASKS_FILE_TASK2

##### tasks ${ROLE}_update.yml
cp $TASKS_FILE_TASK1 $TASKS_FILE_TASK3
sed -i -e 's/create/update/g' $TASKS_FILE_TASK3

##### tasks ${ROLE}_delete.yml
cp $TASKS_FILE_TASK1 $TASKS_FILE_TASK4
sed -i -e 's/create/delete/g' $TASKS_FILE_TASK4

##### templates ${ROLE}_conf.j2
PURPOSE="template"
SPECIFICATION="template"
cat <<EOF > $TEMPLATE_FILE
#jinja2: lstrip_blocks: True, trim_blocks: True

# example:
#
#{# if a variable is defined and not empty #}
#{% if	$VAR_TASK0 is defined and
#	$VAR_TASK0 | length > 0
#%}
#$VAR_TASK0: {{ $VAR_TASK0 }}
#{% endif %}
#
#{# handling loop for dictionary #}
#{% for key, value in $VAR_TASK0.iteritems() %} 
#$VAR_TASK0.{{key}}: {{value}}
#{% endfor %}
#
#{# handling loop for array #}
#{% for item in $VAR_TASK0 %}
#$VAR_TASK0.{{loop.index0}}: {{ item }}
#{% endfor %}
#
#{# handling loop for dictionalry within array #}
#{% for dict in $VAR_TASK0 %}
#{% 	for key, value in dict.iteritems() %} 
#$VAR_TASK0.{{key}}: {{value}}
#{% 	endfor %}
#{% endfor %}

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
${CMT}    #- {role: ${ROLE}, action: read}
${CMT}    #- {role: ${ROLE}, action: update}
${CMT}    #- {role: ${ROLE}, action: delete}
${CMT}    #- {role: ${ROLE}, action: ${ROLE}_create}
${CMT}    #- {role: ${ROLE}, action: ${ROLE}_read}
${CMT}    #- {role: ${ROLE}, action: ${ROLE}_update}
${CMT}    #- {role: ${ROLE}, action: ${ROLE}_delete}
${CMT}  vars_files:
${CMT}    - $VARSFILE_TEMPLATE_FILE_TASK0
${CMT}    - $VARSFILE_TEMPLATE_FILE_TASK1
${CMT}    - $VARSFILE_TEMPLATE_FILE_TASK2
${CMT}    - $VARSFILE_TEMPLATE_FILE_TASK3
${CMT}    - $VARSFILE_TEMPLATE_FILE_TASK4
${CMT}  #vars:
EOF

##### defaults/main.yml
cat <<EOF > $DEFAULTS_FILE
---
EOF

##### vars/main.yml
cat <<EOF > $VARS_FILE
---
EOF

##### template varsfiles (main)
SPECIFICATION="value from playbook varsfiles - main"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_TASK0
---
### ${ROLE}_main_variables
${CMT2}$VAR_TASK0: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_TASK1: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_TASK2: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_TASK3: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_TASK4: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_ROLE_TASK1: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_ROLE_TASK2: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_ROLE_TASK3: "${SPECIFICATION}"
${CMT2}$VAR_TASK0_ACTION_ROLE_TASK4: "${SPECIFICATION}"
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK0 >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK0 >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK0 >> $PLAYBOOK_TEMPLATE_FILE
sed -i -e "s/^${CMT2}/${CMT}/" $VARSFILE_TEMPLATE_FILE_TASK0


##### template varsfiles (create)
SPECIFICATION="value from playbook varsfiles - create"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_TASK1
---
### ${ROLE}_create_variables
${CMT2}$VAR_TASK1: "${SPECIFICATION}"
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK1 >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK1 >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK1 >> $PLAYBOOK_TEMPLATE_FILE
sed -i -e "s/^${CMT2}/${CMT}/" $VARSFILE_TEMPLATE_FILE_TASK1

##### template varsfiles (read)
SPECIFICATION="value from playbook varsfiles - read"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_TASK2
---
### ${ROLE}_read_variables
${CMT2}$VAR_TASK2: "${SPECIFICATION}"
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK2 >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK2 >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK2 >> $PLAYBOOK_TEMPLATE_FILE
sed -i -e "s/^${CMT2}/${CMT}/" $VARSFILE_TEMPLATE_FILE_TASK2

##### template varsfiles (update)
SPECIFICATION="value from playbook varsfiles - update"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_TASK3
---
### ${ROLE}_update_variables
${CMT2}$VAR_TASK3: "${SPECIFICATION}"
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK3 >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK3 >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK3 >> $PLAYBOOK_TEMPLATE_FILE
sed -i -e "s/^${CMT2}/${CMT}/" $VARSFILE_TEMPLATE_FILE_TASK3

##### template varsfiles (delete)
SPECIFICATION="value from playbook varsfiles - delete"
cat <<EOF > $VARSFILE_TEMPLATE_FILE_TASK4
---
### ${ROLE}_delete_variables
${CMT2}$VAR_TASK4: "${SPECIFICATION}"
EOF
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK4 >> $DEFAULTS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK4 >> $VARS_FILE
tail -n +2 $VARSFILE_TEMPLATE_FILE_TASK4 >> $PLAYBOOK_TEMPLATE_FILE
sed -i -e "s/^${CMT2}/${CMT}/" $VARSFILE_TEMPLATE_FILE_TASK4

#
sed -i -e "s/from playbook varsfiles/from task defaults/g" $DEFAULTS_FILE
sed -i -e "s/from playbook varsfiles/from task vars/g" $VARS_FILE
sed -i -e "s/from playbook varsfiles/from playbook vars/g" $PLAYBOOK_TEMPLATE_FILE

