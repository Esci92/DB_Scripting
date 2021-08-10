#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Connection and Methoden                                       /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Erstellen MSSQL Verbindungs String
function CreateMSSQLConnectionString { 

    <#
        .SYNOPSIS
        Erstellen MSSQL Verbindungs String

        .DESCRIPTION
        Erstellen MSSQL Verbindungs String

        .EXAMPLE
        PS> CreateMSSQLConnectionString -MSSQLIP "192.168.10.144" -Username "username" -Password "password" -Database "Alarm"

        .OUTPUTS
        String

        .Link
        Keiner
    #>

    param (
        [parameter(Mandatory=$true)] $MSSQLIP,
        $MSSQLPort = "1433", 
        [parameter(Mandatory=$true)] $Username, 
        [parameter(Mandatory=$true)] $Password, 
        [parameter(Mandatory=$true)] $Database
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

    <#
        .SYNOPSIS
        Einlesen der Datan aus der DB

        .DESCRIPTION
        Einlesen der Datan aus der DB

        .EXAMPLE
        PS> MSSQLReadData -SQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -SqlQuery "select * from Alarmstat"

        .OUTPUTS
        Dataset

        .Link
        Keiner
    #>

    Param (
        [parameter(Mandatory=$true)] $SQLConnection,
        [parameter(Mandatory=$true)] $SQLQuery
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

    <#
        .SYNOPSIS
        Daten Schreiben in der Tabelle

        .DESCRIPTION
        Daten Schreiben in der Tabelle

        .EXAMPLE
        PS> MSSQLWriteData -SQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -SqlQuery "update benutzer set Name = 'Escolano' where Name = 'Mulder'"

        .OUTPUTS
        Dataset

        .Link
        Keiner
    #>

    param (
        [parameter(Mandatory=$true)] $SQLConnection, 
        [parameter(Mandatory=$true)] $SQLQuery
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

    <#
        .SYNOPSIS
        Get MSSQL Data Get Funktion

        .DESCRIPTION
        Get MSSQL Data Get Funktion

        .EXAMPLE
        PS> GetMSSQLData -MSSQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -SqlQuery "select * from vMinAusgeloeseneAlarm"

        .OUTPUTS
        Dataset

        .Link
        Keiner
    #>

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $SqlQuery
    )

    # Abrufen der Funktion und Return
    return MSSQLReadData -SQLConnection $MSSQLConnection -SqlQuery $SqlQuery
}

# Set MSSQL Data Set function
function SetMSSQLData {

    <#
        .SYNOPSIS
        Set MSSQL Data Set function

        .DESCRIPTION
        Set MSSQL Data Set function

        .EXAMPLE
        PS> SetMSSQLData -MSSQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -SqlQuery "update benutzer set Name = 'Escolano' where Name = 'Mulder'" -Logspfad "C:\Logs"

        .OUTPUTS
        Dataset

        .Link
        Keiner
    #>    

    param(  
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $SqlQuery,
        [parameter(Mandatory=$true)] $Logspfad
    )
    
    $MSSQLConnection
    $SqlQuery
    $Logspfad

    try {
        # Senden der Daten zum SQL
        MSSQLWriteData -SQLConnection $MSSQLConnection -SqlQuery $SqlQuery
        
        # Schreiben der Log
        WriteLog -Output $SqlQuery -errors $false -Logspfad $Logspfad
    } 
    catch {
                    
        # Schreiben der ErrorLog
        WriteLog -Output $SqlQuery -errors $true -Logspfad $Logspfad
    } 
}

# Update MSSQLData AddRow or Update Tabells
function UpdateMSSQLData {

    <#
        .SYNOPSIS
        Update MSSQLData AddRow or Update Tabells

        .DESCRIPTION
        Update MSSQLData AddRow or Update Tabells

        .EXAMPLE
        PS> UpdateMSSQLData -MSSQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -SelectCommand "select * from Gruppe" -addrow -ColumName '2'  $UpdateValue (1,TestGruppe)
        
        .EXAMPLE
        PS> UpdateMSSQLData -MSSQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -SelectCommand "select * from Gruppe" -ColumName '2'  $UpdateValue (1,TestGruppe)
        
        .OUTPUTS
        Dataset

        .Link
        Keiner
    #>    

    param (
        [parameter(Mandatory=$true)] $MSSQLConnection,
        [parameter(Mandatory=$true)] $SelectCommand,
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

# Erstellen des User in SQL für den DB Access
function CreateSQLUser {

    <#
        .SYNOPSIS
        Erstellen des User in SQL für den DB Access

        .DESCRIPTION
        Erstellen des User in SQL für den DB Access

        .EXAMPLE
        PS> CreateSQLUser -MSSQLConnection Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password; -user "Christian" -password "Sicheres PW" -Datenbank "Alarm"
        
        .Link
        Keiner
    #>  

    param (
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $user,
        [parameter(Mandatory=$true)] $password,
        [parameter(Mandatory=$true)] $Datenbank,
        [parameter(Mandatory=$true)] $Logspfad
    )

    $MSSQLConnection
    $SqlQuery
    $Logspfad
    

    # Aufbauen des Strings
    $sql = "CREATE LOGIN " + $user
    $sql += " WITH PASSWORD = '" + $password + "'"
    $sql += ", DEFAULT_DATABASE = "
    $sql += $Datenbank + ", CHECK_EXPIRATION = ON;"  
    $sql += "CREATE USER " + $user 
    $sql += " FOR LOGIN " + $user +";"
    $sql += " GRANT SELECT to " + $user 

    # Erstellen des Users
    SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery $sql -Logspfad $Logspfad
}