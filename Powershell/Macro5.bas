Attribute VB_Name = "Module1"
Sub Macro1()
Attribute Macro1.VB_ProcData.VB_Invoke_Func = " \n14"
'
' Macro1 Macro
'

'
    Columns("A:D").Select
    ActiveSheet.ListObjects.Add(xlSrcRange, Range("$A:$D"), , xlYes).Name = _
        "Tableau1"
    Columns("A:D").Select
    ActiveSheet.ListObjects("Tableau1").TableStyle = "TableStyleLight8"
    Selection.FormatConditions.Add Type:=xlExpression, Formula1:="=$D1=""OK"""
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .Color = 5287936
        .TintAndShade = 0
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Selection.FormatConditions.Add Type:=xlExpression, Formula1:= _
        "=$D1=""EN COURS"""
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .Color = 49407
        .TintAndShade = 0
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Range("F1").Select
    ActiveCell.FormulaR1C1 = "Légendes"
    Range("G1").Select
    ActiveCell.FormulaR1C1 = "Explications"
    Range("F2").Select
    ActiveCell.FormulaR1C1 = "OK"
    Range("G2").Select
    ActiveCell.FormulaR1C1 = "Migration effectuée"
    Range("F3").Select
    ActiveCell.FormulaR1C1 = "EN COURS"
    Range("G3").Select
    ActiveCell.FormulaR1C1 = "Personne contacté"
    Range("G3").Select
    ActiveCell.FormulaR1C1 = "Personne contactée"
    Range("G4").Select
    ActiveCell.FormulaR1C1 = "Migration non effectuée"
    Range("F2").Select
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .Color = 5287936
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
    Range("F3").Select
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .Color = 49407
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
    Range("F1:G4").Select
    ActiveSheet.ListObjects.Add(xlSrcRange, Range("$F$1:$G$4"), , xlYes).Name = _
        "Tableau2"
    Range("Tableau2[#All]").Select
    ActiveSheet.ListObjects("Tableau2").TableStyle = "TableStyleLight8"
    Cells.Select
    Selection.Columns.AutoFit
    Columns("A:D").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
End Sub
