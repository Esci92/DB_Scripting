#/--------------------------------------------------------------------------------------/
#/ PostgreSQL Server - PostgreSQL Connection and Methodes                               /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# inden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
function GetTabelleAlarmStat {

    <#
        .SYNOPSIS
        Exportieren alle Daten in der Tabelle AlarmStat geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in der Tabelle AlarmStat geordnet nach PK
        
        .EXAMPLE
        PS> GetTabelleAlarmStat -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
    )
    
    #  Exportieren alle Daten in der Tabelle AlarmStat geordnet nach PK
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from AlarmStat order by AlarmStatID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "AlarmStat.csv"
}

function GetTabelleBenutzer {

    <#
        .SYNOPSIS
        Exportieren alle Daten in der Tabelle Benutzer geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in der Tabelle Benutzer geordnet nach PK
        
        .EXAMPLE
        PS> GetTabelleBenutzer -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from Benutzer order by BenutzerID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "Benutzer.csv"
}


function GetTabelleBenutzerGruppe {

    <#
        .SYNOPSIS
        Exportieren alle Daten in der Tabelle BenutzerGruppe geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in der Tabelle BenutzerGruppe geordnet nach PK
        
        .EXAMPLE
        PS> GetTabelleBenutzerGruppe -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from BenutzerGruppe order by BenutzerGruppeID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "BenutzerGruppe.csv"
}


function GetTabelleGruppe {

    <#
        .SYNOPSIS
        Exportieren alle Daten in der Tabelle Gruppe geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in der Tabelle Gruppe geordnet nach PK
        
        .EXAMPLE
        PS> GetTabelleGruppe -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from Gruppe order by GruppeID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "Gruppe.csv"
}


function GetTabelleMedium {

    <#
        .SYNOPSIS
        Exportieren alle Daten in der Tabelle Medium geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in der Tabelle Medium geordnet nach PK
        
        .EXAMPLE
        PS> GetTabelleMedium -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery 'select * from "Medium" order by MediumID'
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "Medium.csv"
}

function GetTabelleMediumBenutzer {

    <#
        .SYNOPSIS
        Exportieren alle Daten in der Tabelle MediumBenutzer geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in der Tabelle MediumBenutzer geordnet nach PK
        
        .EXAMPLE
        PS> GetTabelleMediumBenutzer -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from MediumBenutzer order by MediumBenutzerID"
    ExportTabellenToCSV  -tabelle $exp -pfadExportCSV $pfadExportCSV -FileName "MediumBenutzer.csv"
}

function ExportTabellen {

    <#
        .SYNOPSIS
        Exportieren alle Daten in den Tabelle geordnet nach PK

        .DESCRIPTION
        Exportieren alle Daten in den Tabelle geordnet nach PK
        
        .EXAMPLE
        PS> ExportTabellen -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportCSV "C:\Export-CSV"
        
        .OUTPUTS
        CSV File.

        .Link
        Keiner
    #>

    param (
		[parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportCSV
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