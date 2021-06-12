#/--------------------------------------------------------------------------------------/
#/ FileExport - PostgreSQL, CSV to MSSQL and Reporting                                  /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Schreiben der Logs und Errormeldungen
function WriteLog {

    param(  
        $Output = $(throw "Now output defined"), 
        $errors = $false,
        $Logsfile = $(throw "Now outputfile defined")
    )
    
    if ($errors){

        # Generieren Spalte 1
        $Logsfile = ($Logspfad + "\ErrorLogs.csv")
        "Error;" | Out-File -FilePath $Logsfile -Append -NoNewline
    } 
    else {

        # Generieren Spalte 1
        $Logsfile = ($Logspfad + "\Logs.csv") 
        "Succes;" | Out-File -FilePath $Logsfile -Append -NoNewline
    }

    ## Generieren 1 Zeilen im CSV Format
    Get-Date | Out-File -FilePath $Logsfile -Append -NoNewline
    ";" | Out-File -FilePath $Logsfile -Append -NoNewline
    $Output | Out-File -FilePath $Logsfile -Append
}

# Convert Tabele zu PsObject
function DataTableToPSObject {
    param(
        $DataTable = $(throw "tabelle is required.")
    )

    # Löschen der ersten Zeile
    $OutTable = $DataTable | Select-Object -skip 1 
    
    # Rückgabe des PSObjects
    return $OutTable | ConvertTo-CSV  | ConvertFrom-Csv
}

# Exportieren der Tabellen in HTML Files
function ExportTabelleToHTML {

    param(  
        $tabelle = $(throw "tabelle is required."), 
        $pfadExportHTML= $(throw "Path is requierd."),
        $Title = $(throw "No Title.")
    )

    # Convert Tabele zu PsObject
    $tabelleObject = DataTableToPSObject -DataTable $tabelle
    
    #Outputfille Erstellen
    $tabelleout = $tabelleObject | ConvertTo-Html -Title $Title -body ('<h1 style="color:Black;font-size:40px;">' + $Title + '</h1>') 

    #Schreiben des Outputfilles
    $tabelleout | Out-File -FilePath ($pfadExportHTML+$Title + ".html")
}
