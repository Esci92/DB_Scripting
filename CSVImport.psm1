#/--------------------------------------------------------------------------------------/
#/ CSV Imports - Formatieren der Daten                                 /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Einlesen CSV Personen Daten und Formatieren für die Weiter Vearbeitung
function GetImportFormatiertPersonen {

    param (
        $Pfad = $(throw "Pfad is Missing.")
    )
    
    # Einlesen der CSV
    $GrupenListe = Import-Csv -Delimiter ";" -LiteralPath $Pfad

    # Jedes Element in einer Liste abfüllen
    $GrupenListeFormatiert = foreach ($aa in $GrupenListe)  {

        # Erstellen der Liste
        New-Object -TypeName PSObject -Property @{
            "Vorname" = $aa.Vorname
            "Nachname" = $aa.Nachname
            "Medium" = $aa.Typ1
            "Number" = $aa.Kontakt1
        }
    }

    # Ruckgabe der Liste Frormatiert
    return $GrupenListeFormatiert
}

# Einlesen CSV Gruppen Daten und Formatieren für die Weiter Vearbeitung
function GetImportFormatiertGruppen {

    param (
        $Pfad = $(throw "Pfad is Missing.")
    )
    
    # Einlesen der CSV
    $GrupenListe = Import-Csv -Delimiter ";" -LiteralPath $Pfad -Header ("Gruppennummer","Gruppenname")

    # Ruckgabe der Liste Formatiert
    return $GrupenListe
}

# Einlesen CSV Personen Gruppen Zuweisung Daten und Formatieren für die Weiter Vearbeitung
function GetImportFormatiertPersonenGruppen {

    param (
        $Pfad = $(throw "Pfad is Missing."),
        $GrupenListe = $(throw "Liste is Missing.")
    )
    
    # Importieren der Personen Gruppen Zuweisungen, Skipen info linien, Als CSV Convertieren
    $GrupenPersonenListe = Get-Content -path $Pfad | Select-Object -skip 2 | ConvertFrom-Csv -Delimiter ";" | Select-Object  ([Object[]]@("h8","h9")+$GrupenListe.Gruppennummer)
    
    # Löschen Leerer Linie
    $GrupenPersonenListe = $GrupenPersonenListe | Select-Object -Skip 1 

    # Ruckgabe der Liste
    return $GrupenPersonenListe

} 