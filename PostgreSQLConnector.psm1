# 30.03.2021 - CE
# 31.03.2021 - CE
# 21.05.2021 - CE
# 22.05.2021 - CE

#/--------------------------------------------------------------------------------------/
#/ PostgreSQL Server - PostgreSQL Connection and Methodes                               /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Connection String für PostgresSQL zusammen setzen
function CreatePostgresConnectionString{

    param(  
        $PostgreIP=$(throw "IP or FQDN is required."), 
        $PostgrePort="5432", 
        $Username=$(throw "Username is required."), 
        $Password=$(throw "Password is required."), 
        $Database=$(throw "Database is required.")
        )

    # Connection String für PostgresSQL zusammen setzen
    $PostgreSQLConnection =  "Driver={PostgreSQL Unicode(x64)};"
    $PostgreSQLConnection += "Server=" + $PostgreIP + ";"
    $PostgreSQLConnection += "Port=" + $PostgrePort + ";"
    $PostgreSQLConnection += "Database=" + $Database + ";"
    $PostgreSQLConnection += "Uid=" + $Username + ";"
    $PostgreSQLConnection += "Pwd=" + $Password + ";"

    # Rückgabe Zusammengebauter String
    return $PostgreSQLConnection
}
Export-ModuleMember -Function CreatePostgresConnectionString

# Connecting via OBDC zu PostgreSQL
function ConnectODBCData{

    param(  
        [string]$ConectionString=$(throw "ConectionString is required."),
        [string]$SqlQuery=$(throw "SQL Comannd is required.")
    )

    # Erstellen der Objekte
    $ODBCconnector = New-Object System.Data.Odbc.OdbcConnection
    $command = New-Object System.Data.Odbc.OdbcCommand($SqlQuery,$ODBCconnector)
    $ds = New-Object system.Data.DataSet

    # Setzen des Connections String für die Remote Verbindung
    $ODBCconnector.ConnectionString = $ConectionString

    # Öffnen der Verbindung
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

    param(  
        $PostgreSQLConnection = $(throw "PostgresSQL String is required."),
        $SqlQuery = $(throw "SQL Comannd is required.")
    )

    # Verbinden der Datenbank und Holen der Daten
    ConnectODBCData -ConectionString $PostgreSQLConnection -SqlQuery $SqlQuery
}
Export-ModuleMember -Function GetProstgrsSQLData
