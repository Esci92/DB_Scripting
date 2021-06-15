#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

function SetMSSQLMedium {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVPersonen = $(throw "No list submited"),
        $Logspfad = $(throw "No Path submited")
    )
    
    $Logspfad

    foreach ($medium in ($CSVPersonen.Medium | Select-Object -Unique)){

        # Abrufen der Gespeicherten Prozedur
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspMediumInsert '"+ $medium + "'") -Logspfad $Logspfad
    }
}

function SetMSSQLGrupen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVGrupen = $(throw "No list submited"),
        $Logspfad = $(throw "No Path submited")
    )
    
    foreach ($Grupen in $CSVGrupen){

        # Abrufen der Gespeicherten Prozedur
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspGruppeUpdateInsert @GName = '" + $Grupen.Gruppenname + "', @GNumber = " + $Grupen.Gruppennummer) -Logspfad $Logspfad
    }
}

function SetMSSQLPersonen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVPersonen = $(throw "No list submited"),
        $Logspfad = $(throw "No Path submited")
    )

    foreach ($pers in $CSVPersonen ){
            
        # Senden der Daten zum SQL
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") -Logspfad $Logspfad
    }
}

function SetMSSQLAlarmStat {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $PostgresData = $(throw "No list submited"),
        $Logspfad = $(throw "No Path submited")
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
            SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery $SQLExec -Logspfad $Logspfad
    
        }
    }
}

function SetMSSQLGrupenPersonen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVGrupenPersonen = $(throw "No list submited"),
        $CSVGrupen = $(throw "No list submited"),
        $Logspfad = $(throw "No Path submited")
    )

    foreach ($Grpers in $CSVGrupenPersonen){

        foreach ($Gr in $CSVGrupen.Gruppennummer){

            #Abfrage ob der User Teil der Gruppe ist
            if ($Grpers.($Gr) -gt 0){

                # Abrufen der Gespeicherten Prozedur
                SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("uspBenutzerGruppeInsert @GNumber = " + $Gr + ", @Kontakt = '" + $Grpers.H8 + "', @Medium = '" + $Grpers.H9 + "'") -Logspfad $Logspfad
            }
        }
    }
}
