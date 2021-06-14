#/--------------------------------------------------------------------------------------/
#/ FileExport - PostgreSQL, CSV to MSSQL and Reporting                                  /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Schreiben der Logs und Errormeldungen
function WriteLog {

    param(  
        $Output = $(throw "Now output defined"), 
        $errors = $false,
        $Logspfad = $(throw "Now outputfile defined")
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

# Erstellen der Logdatei
function CreateLog {

    param(  
        $Logspfad = $(throw "Now outputfile defined")
    )
    
    # Erstellen der Logdateien
    Out-File -FilePath ($Logspfad + "\ErrorLogs.csv")
    Out-File -FilePath ($Logspfad + "\Logs.csv")
}

# Erstellen der Ordnerstruktur
function CreateOrdner {

    param(  
        $stampfad = $(throw "Now outputfile defined")
    )
    
    # Erstellen der Logdateien
    $a = mkdir -Force ($stampfad + "\Export-HTML")
    $a = mkdir -Force ($stampfad + "\\Export-CSV")
    $a = mkdir -Force ($stampfad + "\Logs")
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
    try {
         
        # Convert Tabele zu PsObject
        $tabelleObject = DataTableToPSObject -DataTable $tabelle
    
        # Outputfille Erstellen
        $tabelleout = $tabelleObject | ConvertTo-Html -Title $Title -body ('<h1 style="color:Black;font-size:40px;">' + $Title + '</h1>') 

        # Schreiben des Outputfilles
        $tabelleout | Out-File -FilePath ($pfadExportHTML+$Title + ".html")
        
        # Schreiben des Logs
        WriteLog -Output ("Exporting" + $pfadExportCSV+$FileName) -errors $false -Logspfad $Logspfad
    }
    catch {

        # Schreiben des Logs
        WriteLog -Output ("Exporting" + $pfadExportCSV+$FileName) -errors $true -Logspfad $Logspfad        
    }
}


# Exportieren der Tabellen
function ExportTabellenToCSV {

    param(  
        $tabelle = $(throw "tabelle is required."), 
        $pfadExportCSV= $(throw "Path is requierd."),
        $FileName = $(throw "No FileName.")
    )

    try {
        # Convert Tabele zu PsObject
        $tabelleObject = DataTableToPSObject -DataTable $tabelle

        # Outputfille Erstellen
        $tabelleout = $tabelleObject | ConvertTo-Csv 

        # Schreiben des Outputfilles
        $tabelleout | Out-File -FilePath ($pfadExportCSV+$FileName)

        # Schreiben des Logs
        WriteLog -Output ("Exporting" + $pfadExportCSV+$FileName) -errors $false -Logspfad $Logspfad
    }

    catch {

        # Schreiben des Logs
        WriteLog -Output ("Exporting" + $pfadExportCSV+$FileName) -errors $true -Logspfad $Logspfad
    }
}