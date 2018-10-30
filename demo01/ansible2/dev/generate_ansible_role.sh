#!/bin/bash
CMT=""
CMT2="#"

ROLE=${1:-test}

declare -A DIRS
DIRS["role"]=roles/$ROLE
DIRS["defaults"]=${DIRS["role"]}/defaults
DIRS["files"]=${DIRS["role"]}/files
DIRS["handlers"]=${DIRS["role"]}/handlers
DIRS["meta"]=${DIRS["role"]}/meta
DIRS["tasks"]=${DIRS["role"]}/tasks
DIRS["templates"]=${DIRS["role"]}/templates
DIRS["examples"]=${DIRS["role"]}/examples
DIRS["tests"]=${DIRS["role"]}/tests
DIRS["vars"]=${DIRS["role"]}/vars

for key in "${!DIRS[@]}"; do
	mkdir -p ${DIRS["$key"]}
done

# default 'main.yml' files
declare -A FILES
declare -A VARS
FILES["default_main"]=${DIRS["defaults"]}/main.yml
FILES["handler_main"]=${DIRS["handlers"]}/main.yml
FILES["meta_main"]=${DIRS["meta"]}/main.yml
FILES["var_main"]=${DIRS["vars"]}/main.yml
for resrc in "${!FILES[@]}"
do
	cat <<-EOF > ${FILES["$resrc"]}
	---
	EOF
	# file: meta/main.yml	
	if [[ $resrc == "meta_main" ]]; then
		cat <<-EOF >> ${FILES["$resrc"]}
		# examples
		#dependencies:
		#  - { role: ${ROLE}, task_state: added }
		#  - { role: ${ROLE}, task_state: read }
		#  - { role: ${ROLE}, task_state: updated }
		#  - { role: ${ROLE}, task_state: deleted }
		EOF
	fi
done

# read me file
cat << EOF > ${DIRS["role"]}/README.md
Role Name
=========

Requirements
------------

Role Variables
--------------

Dependencies
------------

Example Playbook
----------------

License
-------

Author Information
------------------

EOF

# specialized task files
TASKS[0]=main
TASKS[1]=added
TASKS[2]="read"
TASKS[3]=updated
TASKS[4]=deleted
#TASKS[5]="start"
#TASKS[6]="restart"
#TASKS[7]="stop"

CMT=''
for index in ${!TASKS[@]}; do

	# varfiles
	VARS["varsfile_${TASKS[$index]}"]=var_varsfile_${ROLE}_${TASKS[$index]}
	FILES["varsfile_${TASKS[$index]}"]=${DIRS["examples"]}/${ROLE}_${TASKS[$index]}_varsfile.yml
   	the_var=${VARS["varsfile_${TASKS[$index]}"]}
	the_file=${FILES["varsfile_${TASKS[$index]}"]}
	cat <<-EOF > $the_file
	---
	EOF

	# playbook
	VARS["playbook_${TASKS[$index]}"]=var_playbook_${ROLE}_${TASKS[$index]}
	FILES["playbook_${TASKS[$index]}"]=${DIRS["examples"]}/${ROLE}_${TASKS[$index]}_playbook.yml
   	the_var=${VARS["playbook_${TASKS[$index]}"]}
	the_file=${FILES["playbook_${TASKS[$index]}"]}
	cat <<-EOF > $the_file
	---
	EOF

	# task
	VARS["task_${TASKS[$index]}_action"]=var_task_${ROLE}_${TASKS[$index]}_action
	VARS["task_${TASKS[$index]}"]=var_task_${ROLE}_${TASKS[$index]}
	VARS["task_${TASKS[$index]}_main"]=var_task_${ROLE}_${TASKS[$index]}_main
	FILES["task_${TASKS[$index]}"]=${DIRS["tasks"]}/${ROLE}_${TASKS[$index]}.yml
   	the_action=${VARS["task_${TASKS[$index]}_action"]}
   	the_var=${VARS["task_${TASKS[$index]}"]}
   	the_val=${VARS["task_${TASKS[$index]}_main"]}
	the_file=${FILES["task_${TASKS[$index]}"]}
	cat <<-EOF > $the_file
	---
	- name: debugging variables for task ${ROLE}_${TASKS[$index]}	
	  debug:
	    var: $the_var

	EOF
	echo "#$the_var: null" >> ${FILES["default_main"]}
	echo "#$the_var: null" >> ${FILES["var_main"]}
	echo "#$the_var: null" >> ${FILES["task_main"]}
	echo "#$the_var: null" >> ${FILES["playbook_main"]}
	echo "#$the_var: null" >> ${FILES["playbook_${TASKS[$index]}"]}
	echo "$the_var: null" >> ${FILES["varsfile_main"]}
	echo "$the_var: null" >> ${FILES["varsfile_${TASKS[$index]}"]}

	echo "#$the_val: null" >> ${FILES["default_main"]}
	echo "#$the_val: null" >> ${FILES["var_main"]}
	echo "#$the_val: null" >> ${FILES["task_main"]}
	echo "#$the_val: null" >> ${FILES["playbook_main"]}
	echo "#$the_val: null" >> ${FILES["playbook_${TASKS[$index]}"]}
	echo "$the_val: null" >> ${FILES["varsfile_main"]}
	#echo "$the_val: null" >> ${FILES["varsfile_${TASKS[$index]}"]}

	cat <<-EOF >> ${FILES["task_main"]}
	#- name: calling task ${ROLE}_${TASKS[$index]}
	#  import_tasks: ${ROLE}_${TASKS[$index]}.yml
	#  vars:
	#    $the_var: "{{ $the_val if $the_val is defined else '_NOT_ASSIGNED_' }}"
	#  when: ${VARS["task_main_action"]} == "${TASKS[$index]}"

	#- name: calling task ${ROLE}_${TASKS[$index]} directly
	#  import_role:
	#    name: ${ROLE}
	#    tasks_from: ${ROLE}_${TASKS[$index]}.yml
	#  when: ${VARS["task_main_action"]} == "${ROLE}_${TASKS[$index]}"

	EOF

   # jinja2 template
	VARS["j2_${TASKS[$index]}"]=var_j2_${ROLE}_${TASKS[$index]}
	FILES["j2_${TASKS[$index]}"]=${DIRS["templates"]}/${ROLE}_${TASKS[$index]}.j2
   	the_var=${VARS["j2_${TASKS[$index]}"]}
	the_file=${FILES["j2_${TASKS[$index]}"]}
	cat <<-EOF > $the_file
	EOF

   # handler
	VARS["handler_${TASKS[$index]}"]=var_handler_${ROLE}_${TASKS[$index]}
	FILES["handler_${TASKS[$index]}"]=${DIRS["handlers"]}/${ROLE}_${TASKS[$index]}_handler.yml
   	the_var=${VARS["handler_${TASKS[$index]}"]}
	the_file=${FILES["handler_${TASKS[$index]}"]}
	cat <<-EOF > $the_file
	---
	EOF

done

cp ${FILES["task_main"]} ${DIRS["tasks"]}/main.yml
cp ${FILES["handler_main"]} ${DIRS["handlers"]}/main.yml

