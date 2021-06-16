#/--------------------------------------------------------------------------------------/
#/ FileExport - PostgreSQL, CSV to MSSQL and Reporting                                  /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Schreiben der Logs und Errormeldungen
function WriteLog {

    <#
        .SYNOPSIS
        Schreiben der Logs und Errormeldungen

        .DESCRIPTION
        Schreiben der Logs und Errormeldungen
        
        .EXAMPLE
        > Error
        PS> WriteLog -Output "Error Msg" -errors $true -Logspfad "C:\Logs" 

        .EXAMPLE
        > Succes
        PS> WriteLog -Output "Succes Msg" -errors $false -Logspfad "C:\Logs" 
        
        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $Output, 
        [parameter(Mandatory=$true)] $errors,
        [parameter(Mandatory=$true)] $Logspfad
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

    <#
        .SYNOPSIS
        Erstellen der Logdateien

        .DESCRIPTION
        Erstellen der Logdateien
        
        .EXAMPLE
        PS> CreateLog -Logspfad "C:\Logs" 

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $Logspfad
    )
    
    # Erstellen der Logdateien
    Out-File -FilePath ($Logspfad + "\ErrorLogs.csv")
    Out-File -FilePath ($Logspfad + "\Logs.csv")
}

# Erstellen der Ordnerstruktur
function CreateOrdner {

    <#
        .SYNOPSIS
        Erstellen der Ordner

        .DESCRIPTION
        Erstellen der Ordner
        
        .EXAMPLE
        PS> CreateOrdner -Logspfad "C:\Logs" 

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $stampfad
    )
    
    # Erstellen der Logdateien
    $a = mkdir -Force ($stampfad + "\Export-HTML")
    $a = mkdir -Force ($stampfad + "\\Export-CSV")
    $a = mkdir -Force ($stampfad + "\Logs")
}

# Convert Tabele zu PsObject
function DataTableToPSObject {

    <#
        .SYNOPSIS
        Convert Tabele zu PsObject

        .DESCRIPTION
        Convert Tabele zu PsObject
        
        .EXAMPLE
        PS> DataTableToPSObject -DataTable "Tabellen" 

        .OUTPUTS
        PSObejects
        
        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $DataTable
    )

    # Löschen der ersten Zeile
    $OutTable = $DataTable | Select-Object -skip 1 
    
    # Rückgabe des PSObjects
    return $OutTable | ConvertTo-CSV  | ConvertFrom-Csv
}

# Exportieren der Tabellen in HTML Files
function ExportTabelleToHTML {

    <#
        .SYNOPSIS
        Exportieren der Tabellen in HTML Files

        .DESCRIPTION
        Exportieren der Tabellen in HTML Files
        
        .EXAMPLE
        PS> ExportTabelleToHTML -Title "Am wenigsten verwendeter Alarm" -tabelle "Tabellen" -pfadExportHTML "C:\Export-HTML"

        .OUTPUTS
        HTML
        
        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $tabelle, 
        [parameter(Mandatory=$true)] $pfadExportHTML,
        [parameter(Mandatory=$true)] $Title
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

    <#
        .SYNOPSIS
        Exportieren der Tabellen in HTML Files

        .DESCRIPTION
        Exportieren der Tabellen in HTML Files
        
        .EXAMPLE
        PS> ExportTabellenToCSV -tabelle "Tabellen" -pfadExportCSV "C:\Export-CSV" -FileName "MediumBenutzer.csv" 

        .OUTPUTS
        CSV
        
        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $tabelle, 
        [parameter(Mandatory=$true)] $pfadExportCSV,
        [parameter(Mandatory=$true)] $FileName
    )

    try {
        # Convert Tabele zu PsObject
        $tabelleObject = DataTableToPSObject -DataTable $tabelle

        # Outputfille Erstellen
        $tabelleout = $tabelleObject | ConvertTo-Csv -Delimiter ";"

        # Schreiben des Outputfilles
        $tabelleout | Out-File -FilePath ($pfadExportCSV+$FileName) -Encoding utf8

        # Schreiben des Logs
        WriteLog -Output ("Exporting" + $pfadExportCSV+$FileName) -errors $false -Logspfad $Logspfad
    }

    catch {

        # Schreiben des Logs
        WriteLog -Output ("Exporting" + $pfadExportCSV+$FileName) -errors $true -Logspfad $Logspfad
    }
}