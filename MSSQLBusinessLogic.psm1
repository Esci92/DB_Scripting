#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Abrufen der Gespeicherten Prozedur insert Media
function SetMSSQLMedium {

    <#
        .SYNOPSIS
        Abrufen der Gespeicherten Prozedur insert Media

        .DESCRIPTION
        Abrufen der Gespeicherten Prozedur insert Media
        
        .EXAMPLE
        PS> SetMSSQLMedium -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -CSVPersonen "Person.csv" -Logspfad "C:\Export-CSV"

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $CSVPersonen,
        [parameter(Mandatory=$true)] $Logspfad
    )
    
    $Logspfad

    foreach ($medium in ($CSVPersonen.Medium | Select-Object -Unique)){

        # Abrufen der Gespeicherten Prozedur
        SetMSSQLData -MSSQLConnection $MSSQLConnection -SqlQuery ("exec uspMediumInsert '"+ $medium + "'") -Logspfad $Logspfad
    }
}

# Abrufen der Gespeicherten Prozedur insert Gruppen
function SetMSSQLGrupen {

    <#
        .SYNOPSIS
        Abrufen der Gespeicherten Prozedur insert Gruppe

        .DESCRIPTION
        Abrufen der Gespeicherten Prozedur insert Gruppe
        
        .EXAMPLE
        PS> SetMSSQLGrupen -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -CSVGrupen "Gruppen.csv" -Logspfad "C:\Export-CSV"

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $CSVGrupen,
        [parameter(Mandatory=$true)] $Logspfad
    )
    
    foreach ($Grupen in $CSVGrupen){

        # Abrufen der Gespeicherten Prozedur
        SetMSSQLData -MSSQLConnection $MSSQLConnection -SqlQuery ("exec uspGruppeUpdateInsert @GName = '" + $Grupen.Gruppenname + "', @GNumber = " + $Grupen.Gruppennummer) -Logspfad $Logspfad
    }
}

function SetMSSQLPersonen {

    <#
        .SYNOPSIS
        Abrufen der Gespeicherten Prozedur insert Benutzer

        .DESCRIPTION
        Abrufen der Gespeicherten Prozedur insert Benutzer
        
        .EXAMPLE
        PS> SetMSSQLPersonen -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -CSVPersonen "Person.csv" -Logspfad "C:\Export-CSV"

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $CSVPersonen,
        [parameter(Mandatory=$true)] $Logspfad
    )

    foreach ($pers in $CSVPersonen ){
            
        # Senden der Daten zum SQL
        SetMSSQLData -MSSQLConnection $MSSQLConnection -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") -Logspfad $Logspfad
    }
}

function SetMSSQLAlarmStat {

    <#
        .SYNOPSIS
        Abrufen der Gespeicherten Prozedur insert Alarmstat

        .DESCRIPTION
        Abrufen der Gespeicherten Prozedur insert Alarmstat
        
        .EXAMPLE
        PS> SetMSSQLAlarmStat -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -PostgresData "PostgreTabellen" -Logspfad "C:\Export-CSV"

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $PostgresData,
        [parameter(Mandatory=$true)] $Logspfad
    )
    
    foreach ($PData in $PostgresData){
    
        if ($PData.grpnumber -lt 10){
            # Löschen von unrelevanten Systemdaten.
        }
        else{

            # Zusammenbauen der Abfrage
            $SQLExec = "exec uspAlarmStatInsert "
            $SQLExec += "@tstamp = " + $PData.tstamp 
            $SQLExec += ",@sstamp = " + $PData.starttime
            $SQLExec += ",@msg = '"+ $PData.msg + "'"
            $SQLExec += ",@launchedby = '" + $PData.launchedby + "'"
            $SQLExec += ",@alrname = '" + $PData.alrname + "'"
            $SQLExec += ",@alrnumber = " + $PData.alrnumber
            $SQLExec += ",@GruppeID = " + $PData.grpnumber 
            
            # Abrufen der Gespeicherten Prozedur        
            SetMSSQLData -MSSQLConnection $MSSQLConnection -SqlQuery $SQLExec -Logspfad $Logspfad
    
        }
    }
}

function SetMSSQLGrupenPersonen {

    <#
        .SYNOPSIS
        Abrufen der Gespeicherten Prozedur insert Alarmstat

        .DESCRIPTION
        Abrufen der Gespeicherten Prozedur insert Alarmstat
        
        .EXAMPLE
        PS> SetMSSQLGrupenPersonen -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -CSVPersonen "Personen.csv" -CSVGrupenPersonen "GruppenPersonen.csv" -Logspfad "C:\Export-CSV"

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $CSVGrupenPersonen,
        [parameter(Mandatory=$true)] $CSVGrupen,
        [parameter(Mandatory=$true)] $Logspfad
    )

    foreach ($Grpers in $CSVGrupenPersonen){

        foreach ($Gr in $CSVGrupen.Gruppennummer){

            #Abfrage ob der User Teil der Gruppe ist
            if ($Grpers.($Gr) -gt 0){

                # Abrufen der Gespeicherten Prozedur
                SetMSSQLData -MSSQLConnection $MSSQLConnection -SqlQuery ("uspBenutzerGruppeInsert @GNumber = " + $Gr + ", @Kontakt = '" + $Grpers.H8 + "', @Medium = '" + $Grpers.H9 + "'") -Logspfad $Logspfad
            }
        }
    }
}
