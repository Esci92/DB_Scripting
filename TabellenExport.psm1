#/--------------------------------------------------------------------------------------/
#/ PostgreSQL Server - PostgreSQL Connection and Methodes                               /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

function GetTabelleAlarmStat {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from AlarmStat order by AlarmStatID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "AlarmStat.csv"
}

function GetTabelleBenutzer {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from Benutzer order by BenutzerID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "Benutzer.csv"
}


function GetTabelleBenutzerGruppe {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from BenutzerGruppe order by BenutzerGruppeID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "BenutzerGruppe.csv"
}


function GetTabelleGruppe {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from Gruppe order by GruppeID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "Gruppe.csv"
}


function GetTabelleMedium {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery 'select * from "Medium" order by MediumID'
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "Medium.csv"
}

function GetTabelleMediumBenutzer {
    param(
        $MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from MediumBenutzer order by MediumBenutzerID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "MediumBenutzer.csv"
}

function ExportTabellen {
    param (
		$MSSQLConnectionString = $(throw "IP or FQDN is required."),
        $pfadExportCSV= $(throw "Path is requierd.")
    )

	# Exportieren der Daten in der Tabelle AlarmStat in ein CSV
	GetTabelleAlarmStat -MSSQLConnection $MSSQLConnectionString -pfadExportCSV $pfadExportCSV 

	# Exportieren der Daten in der Tabelle Benutzer in ein CSV
	GetTabelleBenutzer -MSSQLConnection $MSSQLConnectionString -pfadExportCSV $pfadExportCSV 

	# Exportieren der Daten in der Tabelle BenutzerGruppe in ein CSV
	GetTabelleBenutzerGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportCSV $pfadExportCSV 

	# Exportieren der Daten in der Tabelle Gruppe in ein CSV
	GetTabelleGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportCSV $pfadExportCSV 

	# Exportieren der Daten in der Tabelle Medium in ein CSV
	GetTabelleMedium -MSSQLConnection $MSSQLConnectionString -pfadExportCSV $pfadExportCSV 

	# Exportieren der Daten in der Tabelle MediumBenutzer in ein CSV
	GetTabelleMediumBenutzer -MSSQLConnection $MSSQLConnectionString -pfadExportCSV $pfadExportCSV 

}