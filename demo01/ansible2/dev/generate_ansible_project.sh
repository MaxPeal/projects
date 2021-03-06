#!/bin/bash

PROJECT_NAME=${1:-test}

# project directories
declare -A DIRS # declare associative array
DIRS["PROJECT"]=$PROJECT_NAME
DIRS["ROLES"]=./${DIRS["PROJECT"]}/roles
DIRS["INVENTORIES"]=./${DIRS["PROJECT"]}/inventories
DIRS["PRODUCTION"]=./${DIRS["INVENTORIES"]}/production
DIRS["STAGING"]=./${DIRS["INVENTORIES"]}/staging
DIRS["LIBRARY"]=./${DIRS["PROJECT"]}/library
DIRS["MODULE_UTILS"]=./${DIRS["PROJECT"]}/module_utils
DIRS["FILTER_PLUGINS"]=./${DIRS["PROJECT"]}/filter_plugins

#DIRS["GROUP_VARS_PRODUCTION"]=./${DIRS["PRODUCTION"]}/group_vars
#DIRS["GROUP_VARS_STAGING"]=./${DIRS["STAGING"]}/group_vars
#DIRS["HOST_VARS_PRODUCTION"]=./${DIRS["PRODUCTION"]}/host_vars
#DIRS["HOST_VARS_STAGING"]=./${DIRS["STAGING"]}/host_vars

DIRS["GROUP_VARS"]=./${DIRS["PROJECT"]}/group_vars
DIRS["HOST_VARS"]=./${DIRS["PROJECT"]}/host_vars


for key in "${!DIRS[@]}"
do
  mkdir -p ${DIRS[$key]}
done

declare -A CONFIG_FILES
CONFIG_FILES["DEFAULT"]=./${DIRS["PROJECT"]}/ansible.cfg
for key in "${!CONFIG_FILES[@]}"
do
	cat <<-EOF > ${CONFIG_FILES["$key"]}

	# to ignore ansible SSH authenticity checking 
	# https://stackoverflow.com/questions/32297456/how-to-ignore-ansible-ssh-authenticity-checking
	# command example:
	# ssh -o "StrictHostKeyChecking no" user@host
	host_key_checking = false

	# to hide any skipped tasks
	stdout_callback = skippy


	EOF
done


declare -A INVENTORY_FILES # declare associative array
INVENTORY_FILES["PRODUCTION"]=${DIRS["INVENTORIES"]}/inventory_production
INVENTORY_FILES["STAGING"]=${DIRS["INVENTORIES"]}/inventory_staging
INVENTORY_FILES["DEFAULT"]=${DIRS["PROJECT"]}/ansible_hosts
for key in "${!INVENTORY_FILES[@]}"
do
	if [[ "$key" == "DEFAULT" ]]; then
		cat <<-EOF > ${INVENTORY_FILES["$key"]}
		# auto created by $0	
		EOF
		cat <<-EOF >> ${CONFIG_FILES["DEFAULT"]}
		inventory = ../${INVENTORY_FILES["$key"]}
		EOF
	else
		cat <<-EOF > ${INVENTORY_FILES["$key"]}
		# auto created by $0	
		EOF
		cat <<-EOF >> ${CONFIG_FILES["DEFAULT"]}
		#inventory = ../${INVENTORY_FILES["$key"]}
		EOF

	fi
done

declare -A YAML_FILES # declare associative array
YAML_FILES["GROUP_VARS_GROUP_1"]=${DIRS["GROUP_VARS"]}/group_1.yml
YAML_FILES["GROUP_VARS_GROUP_2"]=${DIRS["GROUP_VARS"]}/group_2.yml

YAML_FILES["HOST_VARS_HOSTNAME_1"]=${DIRS["HOST_VARS"]}/hostname_1.yml
YAML_FILES["HOST_VARS_HOSTNAME_2"]=${DIRS["HOST_VARS"]}/hostname_2.yml

YAML_FILES["PLAYBOOK_SITE"]=${DIRS["PROJECT"]}/site.yml
YAML_FILES["PLAYBOOK_WEBSERVERS"]=${DIRS["PROJECT"]}/webservers.yml
YAML_FILES["PLAYBOOK_DBSERVERS"]=${DIRS["PROJECT"]}/dbservers.yml

for key in "${!DIRS[@]}"
do
  mkdir -p ${DIRS[$key]}
done



## reading list from a file to array
#SRC_FILE_LIST=test_list.txt
#DELIMITER=','
#INDEX=0
#declare -A dict
#while read line
#do
#	key=$(echo $line | cut -d $DELIMITER -f 1)
#	value=$(echo $line | cut -d $DELIMITER -f 2)
#	# for indexed array
#	INDEX=$((INDEX+1)) 
#done 

cd ${DIRS["PROJECT"]}
../generate_ansible_role.sh
