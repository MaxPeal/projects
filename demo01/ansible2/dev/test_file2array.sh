#!/bin/bash

# for bash 4.x
#readarray a < test_array.txt
#
#for key in ${!a[@]}; do
#echo -n "$key -> ${a[key]}"
#done

SRC_DATA_FILE=test_dict.txt
DELIMITER=','
declare -A dict
while read line
do
	key=$(echo $line | cut -d $DELIMITER -f 1)
	value=$(echo $line | cut -d $DELIMITER -f 2)
	dict["$key"]=$value
	echo "$key -> ${dict["$key"]}"
done < $SRC_DATA_FILE
#done < <(cat $SRC_DATA_FILE)
