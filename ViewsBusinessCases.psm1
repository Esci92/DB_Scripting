# 31.03.2021 - CE
#

#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Finden der meist ausgelösene gruppe und exportieren in einem HTML
function GetvMaxAusgelöseneGruppe {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    # Finden der meist ausgelösene gruppe
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxAusgelöseneGruppe"    
    ExportTabelleToHTML -Title "Am meisten verwendete Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der am wenigsten ausgelösene gruppe und exportieren in einem HTML
function GetvMinAusgelöseneGruppe {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der am wenigsten ausgelösene gruppe
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinAusgelöseneGruppe"    
    ExportTabelleToHTML -Title "Am wenigsten Verwendete Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der am meist ausgelösener Alarm und exportieren in einem HTML
function GetvMaxAusgelöseneAlarm {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der am meist ausgelösener Alarm
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxAusgelöseneAlarm"    
    ExportTabelleToHTML -Title "Am meisten verwendeter Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der am wenigsten ausgelösener Alarm und exportieren in einem HTML
function GetvMinAusgelöseneAlarm {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der am wenigsten ausgelösener Alarm
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinAusgelöseneAlarm"    
    ExportTabelleToHTML -Title "Am wenigsten verwendeter Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat und exportieren in einem HTML
function GetvMaxLanuchedBy {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxLanuchedBy"    
    ExportTabelleToHTML -Title "Die Meisten Alarme ausgelöst durch" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der Gruppe mit den meisten Usern und exportieren in einem HTML
function GetvMaxUserinGruppe {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der Gruppe mit den meisten Usern
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxUserinGruppe"   
    ExportTabelleToHTML -Title "Grösste Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der Gruppe mit den wenigsten Usern und exportieren in einem HTML
function GetvMinUserinGruppe {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der Gruppe mit den wenigsten Usern
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinUserinGruppe"    
    ExportTabelleToHTML -Title "Kleinste Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Altesten Alarms und exportieren in einem HTML
function GetvErsterAusgelösterAlarm{
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden des Altesten Alarms
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vErsterAusgelösterAlarm"    
    ExportTabelleToHTML -Title "Erster Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Jungsten Alarms und exportieren in einem HTML
function GetvLetzterAusgelösterAlarm {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden des Jungsten Alarms
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vLetzterAusgelösterAlarm"    
    ExportTabelleToHTML -Title "Letzter Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Mediums der am meisten Getverwendet wird und exportieren in einem HTML
function GetvMaxVerwendetesMedium {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden des Mediums der am meisten Getverwendet wird
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxVerwendetesMedium"    
    ExportTabelleToHTML -Title "Am meisten verwendetes Medium" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Mediums der am wenigsten Getverwendet wird und exportieren in einem HTML
function GetvMinVerwendetesMedium {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden des Mediums der am wenigsten Getverwendet wird
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinVerwendetesMedium"    
    ExportTabelleToHTML -Title "Am wenigsten verwendetes Medium" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der User die nicht verwendet werden und exportieren in einem HTML
function GetvNichtVerwendeteUser {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden der User die nicht verwendet werden
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vNichtVerwendeteUser"    
    ExportTabelleToHTML -Title "User nicht im einsatz" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden Getvon usern mit leeren Namen/Vornamen und exportieren in einem HTML
function GetvLeereNamen {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden vLeereNamen usern mit leeren Namen/Vornamen
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vLeereNamen"    
    ExportTabelleToHTML -Title "Leere Namen" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
function GetvLangsamsterAlarm {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vLangsamsterAlarm"    
    ExportTabelleToHTML -Title "Langsamster Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
function GetvSchnellsterAlarm {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vSchnellsterAlarm"
    ExportTabelleToHTML -Title "Schnellster Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

function ExportAllToHTML{
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportHTML= $(throw "Path is requierd.")
    )

    # Finden der meist ausgelösene gruppe und exportieren in einem HTML
    GetvMaxAusgelöseneGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML
    
    #  Finden der am wenigsten ausgelösene gruppe und exportieren in einem HTML
    GetvMinAusgelöseneGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der am meist ausgelösener Alarm und exportieren in einem HTML
    GetvMaxAusgelöseneAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der am wenigsten ausgelösener Alarm und exportieren in einem HTML
    GetvMinAusgelöseneAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat und exportieren in einem HTML
    GetvMaxLanuchedBy -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der Gruppe mit den meisten Usern und exportieren in einem HTML
    GetvMaxUserinGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der Gruppe mit den wenigsten Usern und exportieren in einem HTML
    GetvMinUserinGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Altesten Alarms und exportieren in einem HTML
    GetvErsterAusgelösterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Altesten Alarms und exportieren in einem HTML
    GetvLetzterAusgelösterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Mediums der am meisten Getverwendet wird und exportieren in einem HTML
    GetvMaxVerwendetesMedium -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Mediums der am wenigsten Getverwendet wird und exportieren in einem HTML
    GetvMinVerwendetesMedium -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der User die nicht verwendet werden und exportieren in einem HTML
    GetvNichtVerwendeteUser -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden Getvon usern mit leeren Namen/Vornamen und exportieren in einem HTML
    GetvLeereNamen -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
    GetvLangsamsterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
    GetvSchnellsterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML
}