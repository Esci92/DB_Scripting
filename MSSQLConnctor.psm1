# 30.03.2021 - CE
# 31.03.2021 - CE
# 22.05.2021 - CE

#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Erstellen MSSQL Verbindungs String
function CreateMSSQLConnectionString { 

    param (
        $MSSQLIP = $(throw "IP or FQDN is required."), 
        $MSSQLPort = "1433", 
        $Username = $(throw "Username is required."), 
        $Password = $(throw "Password is required."), 
        $Database = $(throw "Database is required.")
    )
    
    # Connection String für MSSQL zusammen setzen
    $MSSQLConnection = ("Server=" + $MSSQLIP + ",")
    $MSSQLConnection += ($MSSQLPort + ";")
    $MSSQLConnection += ("Database=" + $Database + ";")
    $MSSQLConnection += (";Integrated Security=false;Uid=" + $Username + ";")
    $MSSQLConnection += ("Pwd=" + $Password + ";")

    # Rückgabe Zusammengebauter String
    return $MSSQLConnection
}

 # Einlesen der Datan aus der DB
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

# Daten Schreiben in der Tabelle
function MSSQLWriteData { 

    param (
        $SQLConnection = $(throw "Now Connection String"), 
        $SQLQuery = $(throw "Missing SQL Querry") 
    )

    # Definieren Connection String und Command Sting
    $MSSQLConnection = New-Object System.Data.SqlClient.SqlConnection
    $cmd = New-Object System.Data.SqlClient.SqlCommand

    # Vorbereiten der Verbindung
    $MSSQLConnection.ConnectionString = $SQLConnection

    # Abfüllen des Befels im SQL Command
    $cmd.Connection = $MSSQLConnection
    $cmd.CommandText = $SQLQuery
    $cmd.CommandTimeout = 0

    # Öffnen der Verbindung
    $MSSQLConnection.Open()

    # Definieren Rückgabe, keine.
    $cmd.ExecuteNonQuery()

    # Schliessen der Verbindung
    $MSSQLConnection.Dispose()
    $cmd.Dispose()
}

# Get MSSQL Data Get Funktion
function GetMSSQLData {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $SqlQuery = $(throw "SQL Comannd is required.")
    )

    # Abrufen der Funktion und Return
    return MSSQLReadData -SQLConnection $MSSQLConnection -SqlQuery $SqlQuery
}

# Set MSSQL Data Set function
function SetMSSQLData {

    param(  
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $SqlQuery = $(throw "SQL Comannd is required.")
    )
    
    try {
        # Senden der Daten zum SQL
        MSSQLWriteData -SQLConnection $MSSQLConnection -SqlQuery $SqlQuery
        
        # Schreiben der Log
        WriteLog -Output $SqlQuery -errors $false -Logsfile $Logspfad
    } 
    catch {
                    
        # Schreiben der ErrorLog
        WriteLog -Output $SqlQuery -errors $true -Logsfile $Logspfad
    } 
}

# Update MSSQLData AddRow or Update Tabells
function UpdateMSSQLData {
    param (
        $MSSQLConnection = $(throw "IP or FQDN is required."), 
        $SelectCommand = $(throw "Select * is Missing."),
        [switch]$AddRow,
        $RowNum,
        $ColumName,
        $UpdateValue
    )

    # Erstellen der Objekte
    $SQLConnection = new-object System.Data.SqlClient.SqlConnection($MSSQLConnection)
    $DataSet = new-object System.Data.DataTable

    # Offnen der Verbindung
    $SQLConnection.open()

    # Vorbereiten SQL Tabele
    $sqlCommand = $SQLConnection.CreateCommand()
    $sqlCommand.CommandText = $SelectCommand

    # Erstellen des SQL Adapter Objekte
    $SQLAdapter = new-object System.Data.SqlClient.SqlDataAdapter($sqlCommand)

    # Laden der Daten ins Dataset
    $SQLAdapter.Fill($DataSet)

    # Hinzufügen einer Row oder Updaten der Tabelle
    if($AddRow -eq $true){

        # Hinzufügen Zeile
        $DataSet.Rows.add([Object[]]@()+$UpdateValue)

    }
    else {

        # Updaten der Zeile
        $DataSet.Rows[$RowNum].BeginEdit()
        $DataSet.Rows[$RowNum][$ColumName] = $UpdateValue
        $DataSet.Rows[$RowNum].EndEdit()

    }

    # Befehl zusammen setzen
    $UpdateCommand = new-object system.data.sqlclient.sqlcommandbuilder($SQLAdapter)
    $SQLAdapter.UpdateCommand = $UpdateCommand.GetUpdateCommand()

    #Update der Datenbank.
    $SQLAdapter.Update($DataSet)

    # Verbindung Schliessen
    $SQLConnection.Close()
}