# 30.03.2021 - CE
# 31.03.2021 - CE
# 22.05.2021 - CE

#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

function SetMSSQLMedium {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVPersonen = $(throw "No list submited")
    )
    
    foreach ($medium in ($CSVPersonen.Medium | Select-Object -Unique)){

        # Abrufen der Gespeicherten Prozedur
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspMediumInsert '"+ $medium + "'")
    }
}

function SetMSSQLGrupen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVGrupen = $(throw "No list submited")
    )
    
    foreach ($Grupen in $CSVGrupen){

        # Abrufen der Gespeicherten Prozedur
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspGruppeUpdateInsert @GName = '" + $Grupen.Gruppenname + "', @GNumber = " + $Grupen.Gruppennummer) 
    }
}

function SetMSSQLPersonen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVPersonen = $(throw "No list submited")
    )

    foreach ($pers in $CSVPersonen ){
            
        # Senden der Daten zum SQL
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'")
    }
}

function SetMSSQLAlarmStat {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $PostgresData = $(throw "No list submited")
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
            SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery $SQLExec
    
        }
    }
}

function SetMSSQLGrupenPersonen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVGrupenPersonen = $(throw "No list submited"),
        $CSVGrupen = $(throw "No list submited")
    )

    foreach ($Grpers in $CSVGrupenPersonen){

        foreach ($Gr in $CSVGrupen.Gruppennummer){

            #Abfrage ob der User Teil der Gruppe ist
            if ($Grpers.($Gr) -gt 0){

                # Abrufen der Gespeicherten Prozedur
                SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("uspBenutzerGruppeInsert @GNumber = " + $Gr + ", @Kontakt = '" + $Grpers.H8 + "', @Medium = '" + $Grpers.H9 + "'")
            }
        }
    }
}
