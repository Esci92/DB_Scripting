function WriteLog {

    param(  
        $Output = $(throw "IP or FQDN is required."), 
        $Error,
        $errorfile,
        $logfile
    )
    
    ($Error -eq $false){
        "Succes;" | Out-File -FilePath $errorfile -Append -NoNewline
    } else {
        
        Success
        "Error;" | Out-File -FilePath $errorfile -Append -NoNewline
    }

    "Error;" | Out-File -FilePath $errorfile -Append -NoNewline

    ## Generieren 1 Zeilen Text
    Get-Date | Out-File -FilePath $errorfile -Append -NoNewline
    ";" | Out-File -FilePath $errorfile -Append -NoNewline
    $Output | Out-File -FilePath $errorfile -Append
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
