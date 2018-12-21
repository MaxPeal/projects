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

#declare -a IDXS_FEED
#IDXS_FEED[0]=${FLD_FEED_ID1}
#IDXS_FEED[1]=${FLD_FEED_ID2}

SQL_ALIAS_RECORD_DATE_OF_MAX="${FLD_RECORD_DATE}OfMax"

# Setting fields
declare -A FLDS_NAME
declare -A FLDS_TYPE
declare -a FLDS_INDEX
declare -a FLDS_PK
declare -a FLDS_GRP_CORE

# Setting querys
declare -a QRYS

n=0
FLDS_NAME[$n]=${FLD_RECORD_ID}
	FLDS_TYPE[$n]="INTEGER"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="yes"
	FLDS_GRP_CORE[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_DATE}
	FLDS_TYPE[$n]="DATETIME"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="no"
	FLDS_GRP_CORE[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_TAG}
	FLDS_TYPE[$n]="CHAR"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="no"
	FLDS_GRP_CORE[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_MARK_DELETED}
	FLDS_TYPE[$n]="BIT"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="no"
	FLDS_GRP_CORE[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_RECORD_MARK_INVALID}
	FLDS_TYPE[$n]="BIT"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="no"
	FLDS_GRP_CORE[$n]="yes"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_FEED_ID1}
	FLDS_TYPE[$n]="INTEGER"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="no"
	FLDS_GRP_CORE[$n]="no"
n=$(($n+1))
FLDS_NAME[$n]=${FLD_FEED_ID2}
	FLDS_TYPE[$n]="INTEGER"
	FLDS_INDEX[$n]="yes"
	FLDS_PK[$n]="no"
	FLDS_GRP_CORE[$n]="no"

# Composing sql - create table
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

# Composing sql - query for valid records
QVIEW_RECORDS_VALID_NAME="${TBL_THEME}RecordsValid"
QVIEW_RECORDS_VALID_SQL_SELECT="SELECT Records.*\
	FROM Records\
	WHERE (((Records.${FLD_RECORD_MARK_INVALID})=No));\
"
n=$((n+1))
QRYS_NAME[$n]=${QVIEW_RECORDS_VALID_NAME}
QRYS_SQL[$n]=${QVIEW_RECORDS_VALID_SQL_SELECT}

# Composing sql - query for deleted records snapshot
QVIEW_SNAPSHOT_DELETED_NAME="${TBL_THEME}SnapshotDeleted"
QVIEW_SNAPSHOT_DELETED_SQL_SELECT="SELECT\
	${QVIEW_RECORDS_VALID_NAME}.[${FLD_FEED_ID}],\
	Max(${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_DATE}) AS ${SQL_ALIAS_RECORD_DATE_OF_MAX}\
	${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_DELETED},\
	${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_INVALID},\
 FROM ${QVIEW_RECORDS_VALID_NAME}\
 GROUP BY\
 	${QVIEW_RECORDS_VALID_NAME}.[${FLD_FEED_ID}],\
	${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_DELETED},\
	${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_INVALID}\
 HAVING (((${QVIEW_RECORDS_VALID_NAME}.${FLD_RECORD_MARK_DELETED})=Yes));\
"
n=$((n+1))
QRYS_NAME[$n]=${QVIEW_SNAPSHOT_DELETED_NAME}
QRYS_SQL[$n]=${QVIEW_SNAPSHOT_DELETED_SQL_SELECT}

# Composing sql
#QVIEW_RECORDS_ACTIVE_NAME="${TBL_THEME}レコードアクティブ"
QVIEW_RECORDS_ACTIVE_NAME="${TBL_THEME}RecordsActive"
S="SELECT\
	${QVIEW_RECORDS_VALID_NAME}.*\
 FROM ${QVIEW_SNAPSHOT_DELETED_NAME}, ${QVW_RECORDS_VALID_NAME}\
 WHERE (("
for i in "${!IDXS_FEED[@]}"
do
 	S="${S}(${QVIEW_RECORDS_VALID_NAME}.${IDXS_FEED[$i]})<>[${QVW_SNAPSHOT_DELETED_NAME}]![${IDXS_FEED[$i]}]"
	if [ "$i" -lt "$((${#IDXS_FEED[@]}-1))" ]; then
		S="${S} OR "
	fi
done
S="${S}));"
QVIEW_RECORDS_ACTIVE_SQL_SELECT="$S"


# Composing sql
QVIEW_SNAPSHOT_ACTIVE_NAME="${TBL_THEME}SnapshotActive"
QVIEW_SNAPSHOT_ACTIVE_SQL_SELECT="SELECT\
	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_FEED_ID},\
	Max(${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_DATE}) AS ${SQL_ALIAS_RECORD_DATE_OF_MAX}\ 
	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_DELETED},\
	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_INVALID}\
 FROM ${QVIEW_RECORDS_ACTIVE_NAME}\
 GROUP BY\
 	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_FEED_ID},\
	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_DELETED},\
	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_MARK_INVALID};\
"
QVIEW_MASTER_NAME="${TBL_THEME}Master"
QVIEW_MASTER_SQL_SELECT="SELECT\
	${QVIEW_RECORDS_ACTIVE_NAME}.*\
 FROM\
	${QVIEW_RECORDS_ACTIVE_NAME} INNER JOIN ${QVW_SNAPSHOT_ACTIVE_NAME}\
 ON\
 	${QVIEW_RECORDS_ACTIVE_NAME}.${FLD_RECORD_DATE} = ${QVW_SNAPSHOT_ACTIVE_NAME}.${SQL_ALIAS_RECORD_DATE_OF_MAX}\
"

LINKED_TBL_MASTER_NAME="${TBL_THEME}Master"

#echo $QVIEW_RECORDS_VALID_SQL_SELECT
#echo $QVIEW_SNAPSHOT_DELETED_SQL_SELECT
#echo $QVIEW_MASTER_SQL_SELECT
echo $QVIEW_RECORDS_ACTIVE_SQL_SELECT

# Composing sql for deleting records in master table
QDELETE_MASTER_SQL_DELETE="DELETE $TABLE_NAME.* FROM $TABLE_NAME"
S="INSERT INTO ${LINKED_TBL_MASTER_NAME} ("
for i in "${!FLDS_NAME[@]}"
do
	if [ "${FLDS_PK[$i]}" == "no" ]; then #if the field is not primary key
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
	if [ "${FLDS_PK[$i]}" == "no" ]; then #if the field is not primary key
		S="${S}${QVIEW_MASTER_NAME}.${FLDS_NAME[$i]}"
		if [ "$i" -lt "$((${#FLDS_NAME[@]}-1))" ]; then
			S="${S}, "		
		fi
	fi
done
S="${S} FROM ${QVIEW_MASTER_NAME}"
QAPPEND_MASTER_SQL_APPEND=$S

echo $QAPPEND_MASTER_SQL_APPEND


cat <<EOF > test.vba

    Dim db As Database
    Set db = CurrentDb
    On Error Resume Next

    db.QueryDefs.Delete "QVIEW_TEST0"
    On Error GoTo 0
    db.CreateQueryDef "QVIEW_TEST0", "select * from Master"
    
    
    db.Close
    Set db = Nothing

EOF

TEST="this is a quick test"
VAR_NAME="test"
echo $VAR_NAME
echo "${$VAR_NAME}"

