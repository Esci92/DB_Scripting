# 30.03.2021 - CE
# 31.03.2021 - CE
# 22.05.2021 - CE

#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Erstellen MSSQL Verbindungs String

Import-Module ($PfadModules + "Logs.psm1") -Verbose

function SetMSSQLMedium {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVPersonen = $(throw "No list submited")
    )
    
    foreach ($medium in ($CSVPersonen.Medium | Select-Object -Unique)){
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspMediumInsert '"+ $medium + "'")
    }
}

function SetMSSQLGrupen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVGrupen = $(throw "No list submited")
    )
    
    foreach ($Grupen in $CSVGrupen){
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspGruppeUpdateInsert @GName = '" + $Grupen.Gruppenname + "', @GNumber = " + $Grupen.Gruppennummer) 
    }
}
function SetMSSQLPersonen {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $CSVPersonen = $(throw "No list submited")
    )

    foreach ($pers in $CSVPersonen[11] ){
        SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") 
    sleep 1
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
            $SQLExec = "exec uspAlarmStatInsert "
            $SQLExec += "@tstamp = " + $PData.tstamp 
            $SQLExec += ",@sstamp = " + $PData.starttime
            $SQLExec += ",@msg = '"+ $PData.msg + "'"
            $SQLExec += ",@launchedby = '" + $PData.launchedby + "'"
            $SQLExec += ",@alrname = '" + $PData.alrname + "'"
            $SQLExec += ",@alrnumber = " + $PData.alrnumber
            $SQLExec += ",@GruppenID = " + $PData.grpnumber
            
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
            if ($Grpers.($Gr) -gt 0){
            $a =    SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("uspBenutzerGruppeUpdateInsert @GNumber = " + $Gr + ", @Kontakt = '" + $Grpers.H8 + "', @Medium = '" + $Grpers.H9 + "'")
            if ($a -eq 1){
                $i += 1
            }
            else {
                write ("uspBenutzerGruppeUpdateInsert @GNumber = " + $Gr + ", @Kontakt = '" + $Grpers.H8 + "', @Medium = '" + $Grpers.H9 + "'")
                }
            }
        }
    }
}
