
    Dim db As Database
    Set db = CurrentDb
    On Error Resume Next

    db.QueryDefs.Delete "QVIEW_TEST0"
    On Error GoTo 0
    db.CreateQueryDef "QVIEW_TEST0", "select * from Master"
    
    
    db.Close
    Set db = Nothing

