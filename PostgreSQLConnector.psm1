# PostgreSQL Server

function ConnectODBCData{

    param(  
        [string]$ConectionString=$(throw "ConectionString is required."),
        [string]$SqlQuery=$(throw "SQL Comannd is required.")
    )

    $ODBCconnector=New-Object System.Data.Odbc.OdbcConnection
    $ODBCconnector.ConnectionString= $ConectionString
    $ODBCconnector.open()

    $command=new-object System.Data.Odbc.OdbcCommand($SqlQuery,$ODBCconnector)
    $command.CommandTimeout=15

    $ds=New-Object system.Data.DataSet
    $da=New-Object system.Data.odbc.odbcDataAdapter($command)
    [void]$da.fill($ds)
    $ds.Tables[0]

    $ODBCconnector.close()
}

function GetProstgresSQLData{

    param(  
        $PostgreIP=$(throw "IP or FQDN is required."), 
        $PostgrePort="5432", 
        $Username=$(throw "Username is required."), 
        $Password=$(throw "Password is required."), 
        $Database=$(throw "Database is required."),
        $SqlQuery = $(throw "SQL Comannd is required.")
        )

    $PostgreSQLConnection =  "Driver={PostgreSQL Unicode(x64)};"
    $PostgreSQLConnection += "Server=" + $PostgreIP + ";"
    $PostgreSQLConnection += "Port=" + $PostgrePort + ";"
    $PostgreSQLConnection += "Database=" + $Database + ";"
    $PostgreSQLConnection += "Uid=" + $Username + ";"
    $PostgreSQLConnection += "Pwd=" + $Password + ";"
    
    ConnectODBCData -ConectionString $PostgreSQLConnection -SqlQuery $SqlQuery
}
