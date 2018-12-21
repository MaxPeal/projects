    Dim db As Database
    Set db = CurrentDb
    On Error Resume Next
    db.QueryDefs.Delete "MyThemeRecordsValid"
    db.QueryDefs.Delete "MyThemeSnapshotDeleted"
    db.QueryDefs.Delete "MyThemeRecordsActive"
    db.QueryDefs.Delete "MyThemeSnapshotActive"
    db.QueryDefs.Delete "MyThemeMaster"
    db.QueryDefs.Delete "DeleteMyThemeMaster"
    db.QueryDefs.Delete "MyThemeMaster"
    On Error GoTo 0
    db.CreateQueryDef "MyThemeRecordsValid", "SELECT Records.*	FROM Records	WHERE (((Records.Record_Mark_Invalid)=No));"
    db.CreateQueryDef "MyThemeSnapshotDeleted", "SELECT	MyThemeRecordsValid.[],	Max(MyThemeRecordsValid.Record_Date) AS Record_DateOfMax	MyThemeRecordsValid.Record_Mark_Deleted,	MyThemeRecordsValid.Record_Mark_Invalid, FROM MyThemeRecordsValid GROUP BY 	MyThemeRecordsValid.[],	MyThemeRecordsValid.Record_Mark_Deleted,	MyThemeRecordsValid.Record_Mark_Invalid HAVING (((MyThemeRecordsValid.Record_Mark_Deleted)=Yes));"
    db.CreateQueryDef "MyThemeRecordsActive", "SELECT	MyThemeRecordsValid.* FROM MyThemeSnapshotDeleted,  WHERE (());"
    db.CreateQueryDef "MyThemeSnapshotActive", "SELECT	MyThemeRecordsActive.,	Max(MyThemeRecordsActive.Record_Date) AS Record_DateOfMax\ 
	MyThemeRecordsActive.Record_Mark_Deleted,	MyThemeRecordsActive.Record_Mark_Invalid FROM MyThemeRecordsActive GROUP BY 	MyThemeRecordsActive.,	MyThemeRecordsActive.Record_Mark_Deleted,	MyThemeRecordsActive.Record_Mark_Invalid;"
    db.CreateQueryDef "MyThemeMaster", "SELECT	MyThemeRecordsActive.* FROM	MyThemeRecordsActive INNER JOIN  ON 	MyThemeRecordsActive.Record_Date = .Record_DateOfMax"
    db.CreateQueryDef "DeleteMyThemeMaster", "DELETE .* FROM "
    db.CreateQueryDef "MyThemeMaster", "INSERT INTO MyThemeMaster (Record_Date, Record_Tag, Record_Mark_Deleted, Record_Mark_Invalid, Feed_ID, Feed_ID2) SELECT MyThemeMaster.Record_Date, MyThemeMaster.Record_Tag, MyThemeMaster.Record_Mark_Deleted, MyThemeMaster.Record_Mark_Invalid, MyThemeMaster.Feed_ID, MyThemeMaster.Feed_ID2 FROM MyThemeMaster"
    db.Close
    Set db = Nothing
