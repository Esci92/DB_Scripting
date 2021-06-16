#/--------------------------------------------------------------------------------------/
#/ CSV Imports - Formatieren der Daten                                                  /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Einlesen CSV Personen Daten und Formatieren für die Weiter Vearbeitung
function GetImportFormatiertPersonen {

        <#
        .SYNOPSIS
        Einlesen CSV Personen Daten und Formatieren für die Weiter Vearbeitung

        .DESCRIPTION
        Einlesen CSV Personen Daten und Formatieren für die Weiter Vearbeitung
        
        .EXAMPLE
        PS> GetImportFormatiertPersonen -Pfad "C:\nvpers-20210330.csv"

        .Outputs
        Personen Liste Formatiert

        .Link
        Keiner
    #>

    param (
        [parameter(Mandatory=$true)] $Pfad
    )
    
    # Einlesen der CSV
    $PersonListe = Import-Csv -Delimiter ";" -LiteralPath $Pfad

    # Jedes Element in einer Liste abfüllen
    $PersonenisteFormatiert = foreach ($aa in $PersonListe)  {

        # Erstellen der Liste
        New-Object -TypeName PSObject -Property @{
            "Vorname" = $aa.Vorname
            "Nachname" = $aa.Nachname
            "Medium" = $aa.Typ1
            "Number" = $aa.Kontakt1
        }
    }

    # Ruckgabe der Liste Frormatiert
    return $PersonenisteFormatiert
}

# Einlesen CSV Gruppen Daten und Formatieren für die Weiter Vearbeitung
function GetImportFormatiertGruppen {

    <#
        .SYNOPSIS
        Einlesen CSV Gruppen Daten und Formatieren für die Weiter Vearbeitung

        .DESCRIPTION
        Einlesen CSV Gruppen Daten und Formatieren für die Weiter Vearbeitung
        
        .EXAMPLE
        PS> GetImportFormatiertGruppen -Pfad "C:\nvpgruppen-20210330.csv"

        .Outputs
        Grupen Liste Formatiert

        .Link
        Keiner
    #>

    param (
        [parameter(Mandatory=$true)] $Pfad
    )
    
    # Einlesen der CSV
    $GrupenListe = Import-Csv -Delimiter ";" -LiteralPath $Pfad -Header ("Gruppennummer","Gruppenname")

    # Ruckgabe der Liste Formatiert
    return $GrupenListe
}

# Einlesen CSV Personen Gruppen Zuweisung Daten und Formatieren für die Weiter Vearbeitung
function GetImportFormatiertPersonenGruppen {

    <#
        .SYNOPSIS
        Einlesen CSV Personen Gruppen Zuweisung Daten und Formatieren für die Weiter Vearbeitung

        .DESCRIPTION
        Einlesen CSV Personen Gruppen Zuweisung Daten und Formatieren für die Weiter Vearbeitung
        
        .EXAMPLE
        PS> GetImportFormatiertGruppen -Pfad "C:\nvpersGrupps-20210330.csv"

        .Outputs
        Grupen Personen Liste Formatiert

        .Link
        Keiner
    #>

    param (
        [parameter(Mandatory=$true)] $Pfad,
        [parameter(Mandatory=$true)] $GrupenListe
    )
    
    # Importieren der Personen Gruppen Zuweisungen, Skipen info linien, Als CSV Convertieren
    $GrupenPersonenListe = Get-Content -path $Pfad | Select-Object -skip 2 | ConvertFrom-Csv -Delimiter ";" | Select-Object  ([Object[]]@("h8","h9")+$GrupenListe.Gruppennummer)
    
    # Löschen Leerer Linie
    $GrupenPersonenListe = $GrupenPersonenListe | Select-Object -Skip 1 

    # Ruckgabe der Liste
    return $GrupenPersonenListe

} 