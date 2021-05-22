# 30.03.2021 - CE
# 31.03.2021 - CE

# SQL Server
# Erstellen MSSQL Verbindungs String
function CreateMSSQLConnetionString {

    param (
        $MSSQLIP = $(throw "IP or FQDN is required."), 
        $MSSQLPort = "1433", 
        $Username = $(throw "Username is required."), 
        [SecureString] $Password = $(throw "Password is required."), 
        $Database = $(throw "Database is required.")
    )
    
    # Connection String für MSSQL zusammen setzen
    $MSSQLConnection += "Server=" + $MSSQLIP + ","
    $MSSQLConnection += $MSSQLPort + ";"
    $MSSQLConnection += "Database=" + $Database + ";"
    $MSSQLConnection += ";Integrated Security=false;Uid=" + $Username + ";"
    $MSSQLConnection += "Pwd=" + $Password + ";"

    # Rückgabe Zusammengebauter String
    return $MSSQLConnection
}

function MSSQLReadData {

    Param (
        $SQLConnection = $(throw "Now Connection String"), 
        $SQLQuery = $(throw "Missing SQL Querry") 
    )

    # Erstellen der Objekte
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter ($SQLQuery, $SQLConnection)
    $DataSet = New-Object System.Data.DataSet

    # Abfüllen der Daten ins Dataset
    $SqlAdapter.Fill($DataSet)

    # Rückgabe Tabelen
    return $DataSet.Tables
}

Function MSSQLWriteData {

    param (
        $SQLConnection = $(throw "Now Connection String"), 
        $SQLQuery = $(throw "Missing SQL Querry") 
    )

    $scon = New-Object System.Data.SqlClient.SqlConnection
    $cmd = New-Object System.Data.SqlClient.SqlCommand

    $scon.ConnectionString = $SQLConnection
    $cmd.Connection = $scon
    $cmd.CommandText = $SQLQuery
    $cmd.CommandTimeout = 0

    $cmd.CommandType

    $scon.Open()
    $cmd.ExecuteNonQuery()
    $scon.Dispose()
    $cmd.Dispose()
}

function GetMSSQLData {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $SqlQuery = $(throw "SQL Comannd is required.")
    )

    return MSSQLReadData -SQLConnection $MSSQLConnection -SqlQuery $SqlQuery
}

function SetMSSQLData {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $SqlQuery = $(throw "SQL Comannd is required.")
    )
    
    return MSSQLWriteData -SQLConnection $MSSQLConnection -SqlQuery $SqlQuery
}


function UpdateMSSQLData {
    param (
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $SelectCommand = $(throw "Select * is Missing."),
        [switch]$AddRow,
        $RowNum,
        $ColumName,
        $UpdateValue
    )

    $SQLConnection = new-object System.Data.SqlClient.SqlConnection($MSSQLConnection)
    $SQLConnection.open()

    $sqlCommand = $SQLConnection.CreateCommand()
    $sqlCommand.CommandText = $SelectCommand

    $dt = new-object System.Data.DataTable
    $adapter = new-object System.Data.SqlClient.SqlDataAdapter($sqlCommand)

    $adapter.Fill($dt)

    if($AddRow -eq $true){
        # edit the rows
        $dt.Rows.add([Object[]]@()+$UpdateValue)
    }
    else {
        $dt.Rows[$RowNum].BeginEdit()
        $dt.Rows[$RowNum][$ColumName] = $UpdateValue
        $dt.Rows[$RowNum].EndEdit()
    }


    # command builder
    $cb = new-object system.data.sqlclient.sqlcommandbuilder($adapter)

    $adapter.UpdateCommand = $cb.GetUpdateCommand()

    $adapter.Update($dt)

    $SQLConnection.Close()
}