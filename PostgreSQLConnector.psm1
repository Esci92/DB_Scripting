#/--------------------------------------------------------------------------------------/
#/ PostgreSQL Server - PostgreSQL Connection and Methodes                               /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Connection String fuer PostgresSQL zusammen setzen
function CreatePostgresConnectionString {

    <#
        .SYNOPSIS
        Connection String fuer PostgresSQL zusammen setzen

        .DESCRIPTION
        Connection String fuer PostgresSQL zusammen setzen

        .EXAMPLE
        PS> CreatePostgresConnectionString -PostgreIP "192.168.10.246" -Username "username" -Password "password" -Database "nv_alarm"

        .OUTPUTS
        String

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $PostgreIP, 
        $PostgrePort="5432", 
        [parameter(Mandatory=$true)] $Username, 
        [parameter(Mandatory=$true)] $Password, 
        [parameter(Mandatory=$true)] $Database
        )

    # Connection String für PostgresSQL zusammen setzen
    $PostgreSQLConnection =  "Driver={PostgreSQL Unicode(x64)};"
    $PostgreSQLConnection += "Server=" + $PostgreIP + ";"
    $PostgreSQLConnection += "Port=" + $PostgrePort + ";"
    $PostgreSQLConnection += "Database=" + $Database + ";"
    $PostgreSQLConnection += "Uid=" + $Username + ";"
    $PostgreSQLConnection += "Pwd=" + $Password + ";"

    # Rueckgabe Zusammengebauter String
    return $PostgreSQLConnection
}

# Connecting via OBDC zu PostgreSQL
function ConnectODBCData{

    <#
        .SYNOPSIS
        Connection String fuer PostgresSQL zusammen setzen

        .DESCRIPTION
        Connection String fuer PostgresSQL zusammen setzen

        .EXAMPLE
        PS> -ConectionString $PostgreSQLConnection -SqlQuery $SqlQuery
        
        .OUTPUTS
        Tabellen.

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)][string] $ConectionString,
        [parameter(Mandatory=$true)][string] $SqlQuery
    )

    # Erstellen der Objekte
    $ODBCconnector = New-Object System.Data.Odbc.OdbcConnection
    $command = New-Object System.Data.Odbc.OdbcCommand($SqlQuery,$ODBCconnector)
    $ds = New-Object system.Data.DataSet

    # Setzen des Connections String für die Remote Verbindung
    $ODBCconnector.ConnectionString = $ConectionString

    # oeffnen der Verbindung
    $ODBCconnector.open()

    # Setzen Timeout
    $command.CommandTimeout=60
    
    # Erstellen des DatenAdapter
    $da=New-Object system.Data.odbc.odbcDataAdapter($command)

    # Abfüllen der daten in das Datenset
    [void]$da.fill($ds)

    # Selectieren der Tabelle
    $ds.Tables[0]

    # Schliessen der Verbindung
    $ODBCconnector.close()
}

# Get Postgres Data Get function
function GetProstgrsSQLData{

    <#
        .SYNOPSIS
        Get Postgres Data Get function

        .DESCRIPTION
        Get Postgres Data Get function

        .EXAMPLE
        PS> ConnectODBCData -PostgreSQLConnection "Driver={PostgreSQL Unicode(x64)};Server=192.168.10.246;Port=5432;Database=nv_alarm;Uid=username;Pwd=password;" -SqlQuery "select * from public.alarm_data ORDER BY id DESC Limit 30000"
        
        .OUTPUTS
        Tabellen.

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $PostgreSQLConnection,
        [parameter(Mandatory=$true)] $SqlQuery
    )

    # Verbinden der Datenbank und Holen der Daten
    ConnectODBCData -ConectionString $PostgreSQLConnection -SqlQuery $SqlQuery
}
