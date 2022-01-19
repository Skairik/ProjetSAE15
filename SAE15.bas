Attribute VB_Name = "Module2"
Sub tri()

    Columns("B:B").Select
    Application.CutCopyMode = False
    ActiveSheet.ListObjects.Add(xlSrcRange, Range("$B:$B"), , xlYes).Name = _
        "Tableau3"
    Columns("B:B").Select
    ActiveSheet.ListObjects("Tableau3").TableStyle = "TableStyleMedium1"
    Range("Tableau3[[#Headers],[ Envoyeur ]]").Select
    Application.CutCopyMode = False
    Sheets.Add
    ActiveWorkbook.PivotCaches.Create(SourceType:=xlDatabase, SourceData:= _
        "Tableau3", Version:=7).CreatePivotTable TableDestination:="Feuil1!R3C1", _
        TableName:="Tableau croisé dynamique1", DefaultVersion:=7
    Sheets("Feuil1").Select
    Cells(3, 1).Select
    With ActiveSheet.PivotTables("Tableau croisé dynamique1")
        .ColumnGrand = True
        .HasAutoFormat = True
        .DisplayErrorString = False
        .DisplayNullString = True
        .EnableDrilldown = True
        .ErrorString = ""
        .MergeLabels = False
        .NullString = ""
        .PageFieldOrder = 2
        .PageFieldWrapCount = 0
        .PreserveFormatting = True
        .RowGrand = True
        .SaveData = True
        .PrintTitles = False
        .RepeatItemsOnEachPrintedPage = True
        .TotalsAnnotation = False
        .CompactRowIndent = 1
        .InGridDropZones = False
        .DisplayFieldCaptions = True
        .DisplayMemberPropertyTooltips = False
        .DisplayContextTooltips = True
        .ShowDrillIndicators = True
        .PrintDrillIndicators = False
        .AllowMultipleFilters = False
        .SortUsingCustomLists = True
        .FieldListSortAscending = False
        .ShowValuesRow = False
        .CalculatedMembersInFilters = False
        .RowAxisLayout xlCompactRow
    End With
    With ActiveSheet.PivotTables("Tableau croisé dynamique1").PivotCache
        .RefreshOnFileOpen = False
        .MissingItemsLimit = xlMissingItemsDefault
    End With
    ActiveSheet.PivotTables("Tableau croisé dynamique1").RepeatAllLabels _
        xlRepeatLabels
    ActiveSheet.PivotTables("Tableau croisé dynamique1").AddDataField ActiveSheet. _
        PivotTables("Tableau croisé dynamique1").PivotFields(" Envoyeur "), _
        "Nombre de  Envoyeur ", xlCount
    With ActiveSheet.PivotTables("Tableau croisé dynamique1").PivotFields( _
        " Envoyeur ")
        .Orientation = xlRowField
        .Position = 1
    End With
    Range("D6").Select
End Sub


