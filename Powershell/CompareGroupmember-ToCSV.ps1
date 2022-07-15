#___________A_MODIFIER________________
#Divers chemin
$macropath="\\srv-file\f\Echange\_DEPOT_TEMPORAIRE\TMP\INFO\MigrationFSLOGIX\Traitement\Macro5.bas"
$csv = "\\srv-file\f\Echange\_DEPOT_TEMPORAIRE\TMP\INFO\MigrationFSLOGIX\Traitement\doublons_updateee.csv"
$xlsx = "\\srv-file\f\Echange\_DEPOT_TEMPORAIRE\TMP\INFO\MigrationFSLOGIX\Traitement\doublons_updateee.xlsx"
#____________________________________

#Récupère info dans l'AD
$Usersold = Get-ADGroupMember -Identity "GS-RDS-SESSION-NIGAY-DESKTOP" -Recursive
$Usersnew = Get-ADGroupMember -Identity "GS-RDS-CARADESK-FSLOGIX" -Recursive

#Récupère les personnes qui sont dans les 2 groupes
$all = Compare-Object $Usersold $Usersnew -IncludeEqual -ExcludeDifferent | Select * 
#La variable all est un objet, je la transforme en string pour la traité a ma manière
$ress = Out-String -InputObject $all -Width 110
#Déclaration
$ress = $ress.Split("`n")
$test = 0
$nbrdouble = 0
#Nom des colonnes
$evenement="Nom ; OU ; DC ; Statut"
#Ecriture dans le fichier
ADD-content -path $csv -value $evenement
#Parcours ligne par ligne
foreach ( $event in $ress )
{
    $texte = $event.split(",")
    #Test si on est sur une ligne contenant des informations
    if ( $texte.count -gt 1 )
    {
        $test=1
    }
    else{
    $test =0
    }
    #Si bonne ligne, on commence le traitement
    if ($test -eq 1){
        #Remise à zero des variables
        $nom=''
        $OU=''
        $DC=''
        $nbrdouble = $nbrdouble + 1
        foreach ( $i in $texte ){
            $splitegal = $i.split("=")
            if ($splitegal[0] -eq "CN"){
                $nom=$splitegal[1]}
            if ($splitegal[0] -eq "OU"){
                $OU=$OU + " - " + $splitegal[1]}
            if ($splitegal[0] -eq "DC"){
                $DC=$DC + " " + $splitegal[1]}
        }
		$DC = "=SUPPRESPACE(" + "`""+$DC+"`""+")"
        $evenement=$nom + ';' + $OU  + ';' + $DC 
        ADD-content -path $csv -value $evenement
    }
}
#CSV TO XLSX
#Definie quel fichier on prend, et ou on met le fichier transformé ainsi que le déliminteur

$delimiter = ";" #Specify the delimiter used in the file

#Crée un nouveau fichier excel vide
$excel = New-Object -ComObject excel.application 
$workbook = $excel.Workbooks.Add(1)
$worksheet = $workbook.worksheets.Item(1)

#Ecris dans le fichier xlx à partir du fichier csv
$TxtConnector = ("TEXT;" + $csv)
$Connector = $worksheet.QueryTables.add($TxtConnector,$worksheet.Range("A1"))
$query = $worksheet.QueryTables.item($Connector.name)
$query.TextFileOtherDelimiter = $delimiter
$query.TextFileParseType  = 1
$query.TextFileColumnDataTypes = ,1 * $worksheet.Cells.Columns.Count
$query.AdjustColumnWidth = 1

# Execute et supprime le querry
$query.Refresh()
$query.Delete()

#Sauvergarde et ferme le fichier xlsx
$Workbook.SaveAs($xlsx,51)
$excel.Quit()
Remove-Item $csv

#Ouvre excel et l'affiche
$xl = New-Object -ComObject Excel.Application
$xl.Visible = $true
$xl.DisplayAlerts = $false
$workbook = $xl.Workbooks.Open($xlsx)
$worksheet = $workbook.worksheets.item(1)
#Ajoute la macro
$xlmodule = $workbook.VBProject.VBComponents.Import($macropath)
#Lance la macro
$xl.Run("Macro1")
$excel.quit()
