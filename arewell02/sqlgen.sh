#!/bin/bash

# Core Fields
TBL_THEME="MyTheme"
TBL_RECORDS="${TBL_THEME}Records"
FLD_RECORD_ID="Record_ID"
FLD_RECORD_DATE="Record_Date"
FLD_RECORD_TAG="Record_Tag"
FLD_RECORD_MARK_DELETED="Record_Mark_Deleted"
FLD_RECORD_MARK_INVALID="Record_Mark_Invalid"
FLD_FEED_ID1="Feed_ID"
FLD_FEED_ID2="Feed_ID2"

SQL_ALIAS_RECORD_DATE_OF_MAX="${FLD_RECORD_DATE}OfMax"
TBL_MASTER_LINKED_NAME="${TBL_THEME}Master"

# Setting fields
declare -A FLDS_NAME
declare -A FLDS_TYPE
declare -a FLDS_INDEX
declare -a FLDS_PK1
declare -a FLDS_PK2
declare -a FLDS_GRP1

# Setting querys
declare -a QRYS_NAME
declare -a QRYS_SQL

n=0
FLDS_NAME[$n]=${FLD_RECORD_ID}
	FLDS_TYPE[$n]="INTEGER"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="yes"
	FLDS_PK2[$n]="no"
	FLDS_GRP1[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_DATE}
	FLDS_TYPE[$n]="DATETIME"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="no"
	FLDS_PK2[$n]="no"
	FLDS_GRP1[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_TAG}
	FLDS_TYPE[$n]="CHAR"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="no"
	FLDS_PK2[$n]="no"
	FLDS_GRP1[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_MARK_DELETED}
	FLDS_TYPE[$n]="BIT"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="no"
	FLDS_PK2[$n]="no"
	FLDS_GRP1[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_MARK_INVALID}
	FLDS_TYPE[$n]="BIT"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="no"
	FLDS_PK2[$n]="no"
	FLDS_GRP1[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_FEED_ID1}
	FLDS_TYPE[$n]="INTEGER"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="no"
	FLDS_PK2[$n]="yes"
	FLDS_GRP1[$n]="no"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_FEED_ID2}
	FLDS_TYPE[$n]="INTEGER"
	FLDS_INDEX[$n]="yes"
	FLDS_PK1[$n]="no"
	FLDS_PK2[$n]="yes"
	FLDS_GRP1[$n]="no"

### Composing sql

#
S="CREATE TABLE $TBL_RECORDS( "
for i in "${!FLDS_NAME[@]}"
do
	S="${S}${FLDS_NAME[$i]} ${FLDS_TYPE[$i]}"
	echo "i = $i ans = $((${#FLDS_NAME[@]}-1))"
	if [ "$i" -lt "$((${#FLDS_NAME[@]}-1))" ]; then
		S="$S, "
	fi
done
S="$S);"
TBL_RECORDS_SQL_CREATE=$S

#
QVIEW_RECORDS_VALID_NAME="${TBL_THEME}RecordsValid"
QVIEW_RECORDS_VALID_SQL_SELECT="SELECT Records.*\
	FROM Records\
	WHERE (((Records.${FLD_RECORD_MARK_INVALID})=No));\
"

#
QVIEW_SNAPSHOT_DELETED_NAME="${TBL_THEME}SnapshotDeleted"
S="SELECT"
for i in ${!FLDS_NAME[@]}
do
	if [ ${FLDS_PK2[$i]} = "yes" ]; then 
		S="${S} ${QVIEW_RECORDS_VALID_NAME}.[${FLDS_NAME[$i]}],"
	fi
done
S="$S Max(${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_DATE}) AS ${SQL_ALIAS_RECORD_DATE_OF_MAX},\
 ${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_DELETED},\
 ${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_INVALID},\
 FROM ${QVIEW_RECORDS_VALID_NAME}\
 GROUP BY"
for i in ${!FLDS_NAME[@]}
do
	if [ ${FLDS_PK2[$i]} = "yes" ]; then 
		S="${S} ${QVIEW_RECORDS_VALID_NAME}.[${FLDS_NAME[$i]}],"
	fi
done
S="$S ${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_DELETED},\
	${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_INVALID}\
 HAVING (((${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_DELETED})=Yes));\
"
QVIEW_SNAPSHOT_DELETED_SQL_SELECT="$S"

#
QVIEW_RECORDS_ACTIVE_NAME="${TBL_THEME}RecordsActive"
S="SELECT\
	${QVIEW_RECORDS_VALID_NAME}.*\
 FROM ${QVIEW_SNAPSHOT_DELETED_NAME}, ${QVIEW_RECORDS_VALID_NAME}\
 WHERE (("
#for i in "${!IDXS_FEED[@]}"
for i in "${!FLDS_NAME[@]}"
do
	if [ ${FLDS_PK2[$i]} = "yes" ]; then
 		S="${S}(${QVIEW_RECORDS_VALID_NAME}.${FLDS_NAME[$i]})<>[${QVIEW_SNAPSHOT_DELETED_NAME}]![${FLDS_NAME[$i]}]"
		if [ "$i" -lt "$((${#FLDS_NAME[@]}-1))" ]; then
			S="${S} OR "
		fi
	fi
done
S="${S}));"
QVIEW_RECORDS_ACTIVE_SQL_SELECT="$S"

#
QVIEW_SNAPSHOT_ACTIVE_NAME="${TBL_THEME}SnapshotActive"
S="SELECT"
for i in ${!FLDS_NAME[@]}
do
	if [ ${FLDS_PK2[$i]} = "yes" ]; then 
		S="${S} ${QVIEW_RECORDS_VALID_NAME}.[${FLDS_NAME[$i]}],"
	fi
done
S="$S Max(${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_DATE}) AS ${SQL_ALIAS_RECORD_DATE_OF_MAX},\
 ${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_DELETED},\
 ${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_INVALID}\
 FROM ${QVIEW_RECORDS_ACTIVE_NAME}\
 GROUP BY\
 ${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_FEED_ID},\
 ${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_DELETED},\
 ${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_INVALID};\
"
QVIEW_SNAPSHOT_ACTIVE_SQL_SELECT=$S

#
QVIEW_MASTER_NAME="${TBL_THEME}Master"
QVIEW_MASTER_SQL_SELECT="SELECT\
 ${QVIEW_RECORDS_ACTIVE_NAME}.*\
 FROM\
 ${QVIEW_RECORDS_ACTIVE_NAME} INNER JOIN ${QVIEW_SNAPSHOT_ACTIVE_NAME}\
 ON\
 ${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_DATE} = ${QVIEW_SNAPSHOT_ACTIVE_NAME}.${SQL_ALIAS_RECORD_DATE_OF_MAX}\
"


# Composing sql for deleting records in master table
QDELETE_MASTER_NAME="Delete${TBL_MASTER_LINKED_NAME}"
QDELETE_MASTER_SQL_DELETE="DELETE ${TBL_MASTER_LINKED_NAME}.* FROM ${TBL_MASTER_LINKED_NAME}"

# Composing sql
QAPPEND_MASTER_NAME="Append${TBL_MASTER_LINKED_NAME}"
S="INSERT INTO ${LINKED_TBL_MASTER_NAME} ("
for i in "${!FLDS_NAME[@]}"
do
	if [ "${FLDS_PK1[$i]}" == "no" ]; then #if the field is not primary key
		S="${S}${FLDS_NAME[$i]}"
		if [ "$i" -lt "$((${#FLDS_NAME[@]}-1))" ]; then
			S="${S}, "		
		fi
	fi
done
S="${S})"
S="${S} SELECT "
for i in "${!FLDS_NAME[@]}"
do
	if [ "${FLDS_PK1[$i]}" == "no" ]; then #if the field is not primary key
		S="${S}${QVIEW_MASTER_NAME}.${FLDS_NAME[$i]}"
		if [ "$i" -lt "$((${#FLDS_NAME[@]}-1))" ]; then
			S="${S}, "		
		fi
	fi
done

S="${S} FROM ${QVIEW_MASTER_NAME}"
QAPPEND_MASTER_SQL_APPEND=$S
echo $QAPPEND_MASTER_SQL_APPEND

n=0
QRYS_NAME[$n]=${QVIEW_RECORDS_VALID_NAME}
QRYS_SQL[$n]=${QVIEW_RECORDS_VALID_SQL_SELECT}
n=$((n+1))
QRYS_NAME[$n]=${QVIEW_SNAPSHOT_DELETED_NAME}
QRYS_SQL[$n]=${QVIEW_SNAPSHOT_DELETED_SQL_SELECT}
n=$((n+1))
QRYS_NAME[$n]=${QVIEW_RECORDS_ACTIVE_NAME}
QRYS_SQL[$n]=${QVIEW_RECORDS_ACTIVE_SQL_SELECT}
n=$((n+1))
QRYS_NAME[$n]=${QVIEW_SNAPSHOT_ACTIVE_NAME}
QRYS_SQL[$n]=${QVIEW_SNAPSHOT_ACTIVE_SQL_SELECT}
n=$((n+1))
QRYS_NAME[$n]=${QVIEW_MASTER_NAME}
QRYS_SQL[$n]=${QVIEW_MASTER_SQL_SELECT}
n=$((n+1))
QRYS_NAME[$n]=${QDELETE_MASTER_NAME}
QRYS_SQL[$n]=${QDELETE_MASTER_SQL_DELETE}
n=$((n+1))
QRYS_NAME[$n]=${QAPPEND_MASTER_NAME}
QRYS_SQL[$n]=${QAPPEND_MASTER_SQL_APPEND}


OUTPUT_FILE=query.vba
cat <<EOF > $OUTPUT_FILE
    Dim db As Database
    Set db = CurrentDb
    On Error Resume Next
EOF

for i in "${!QRYS_NAME[@]}"
do
cat <<EOF >> $OUTPUT_FILE
    db.QueryDefs.Delete "${QRYS_NAME[$i]}"
EOF
done

cat <<EOF >> $OUTPUT_FILE
    On Error GoTo 0
EOF

for i in "${!QRYS_NAME[@]}"
do
cat <<EOF >> $OUTPUT_FILE
    db.CreateQueryDef "${QRYS_NAME[$i]}", "${QRYS_SQL[$i]}"
EOF
done
    
cat <<EOF >> $OUTPUT_FILE
    db.Close
    Set db = Nothing
EOF

TEST="this is a quick test"
VAR_NAME="TEST"
echo $VAR_NAME
echo "${!VAR_NAME}"

