$sqlMSServerIP = "192.168.1.103"
$sqlMSusername = "username"
$sqlMSpassword = "password"

#Import-Module "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Powershell\SQLConnctors.psm1" -Verbose

#GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Abo" -SqlQuery "Database"


#"INSERT INTO Abo VALUES (3, 'Jeff', 'Doe', 16)", 'SELECT * FROM Customers ORDER BY ID' | Invoke-SqlQuery -Provider OleDb -ConnectionString "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=.\Database.accdb;" -Verbose

#SetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Abo" -SqlQuery "CREATE TABLE dbo.HelloWorld (ID INT)"


$mssqlConnection = new-object System.Data.SqlClient.SqlConnection("Server=192.168.1.103,1433; Database=abo;Integrated Security=false;Uid=username;pwd=password;")
$sqlConnection.open()

$sqlCommand = $sqlConnection.CreateCommand()
$sqlCommand = "SELECT * FROM aboart"

$dt = new-object System.Data.DataTable
$adapter = new-object System.Data.SqlClient.SqlDataAdapter($sqlCommand)
$adapter.Fill($dt)

# edit the rows
$dt.Rows.add(1,2,3)

$dt.Rows[1].BeginEdit()
$dt.Rows[1]["Bezeichnung"] = "nacho"
$dt.Rows[1].EndEdit()


# command builder
$cb = new-object system.data.sqlclient.sqlcommandbuilder($adapter)

$adapter.UpdateCommand = $cb.GetUpdateCommand()

$adapter.Update($dt)

$sqlConnection.Close()

# 31.03.2021 - CE
#

$sqlPostgreServerIP = "192.168.10.246"
$sqlPostgreusername = "username"
$sqlPostgrepassword = "password"

$sqlMSServerIP = "192.168.10.144"
$sqlMSusername = "username"
$sqlMSpassword = "password"

Import-Module ($pfad + "SQLConnctors.psm1") -Verbose
Import-Module ($pfad + "PostgreSQLConnector.psm1") -Verbose
Import-Module ($pfad + "CSVImport.psm1") -Verbose

$test = GetProstgrsSQLData -PostgreSQLConnection $PostgreSQLConnectionString -SqlQuery "SELECT * FROM public.alarm_data ORDER BY id ASC LIMIT 100"
$PostgreSQLConnectionString = CreatePostgresConnetionString -Username $sqlPostgreusername -Password $sqlPostgrepassword -Database "nv_alarm" -PostgreIP $sqlPostgreServerIP
#
#$i = 0
#$test | foreach  {
#    $a = $test[$i]
#    $i += 1
#}
GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm" -SqlQuery "SET IDENTITY_INSERT AlarmStat off"

GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm" -SqlQuery "SET IDENTITY_INSERT AlarmStat off; insert into AlarmStat(AlarmStatID,alrnumber) values(1,9867);"

GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm" -SqlQuery "SELECT * FROM AlarmStat"

setMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspMediumUpdateInsert '"+ "566777" + "'")


foreach ($Grupen in $CSVGrupen){
    ("exec uspGruppeUdateInsert @Gname = '"+ $Grupen.Gruppenname  + "',@Gnumber = " + $Grupen.Gruppennummer)
}

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



(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds(1571227882))

$pers = $CSVPersonen[11]
SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") 

$pers = $CSVPersonen[12]
SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") 

$pers = $CSVPersonen[13]
SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") 

$pers = $CSVPersonen[14]
SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") 

$pers = $CSVPersonen[15]
SetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery ("exec uspBenutzerUpdateInsert @Vorname = '"+ $pers.Vorname  + "',@Nachname = '" + $pers.Nachname + "',@Kontakt = '" + $pers.Number + "',@Medium = '" + $pers.Medium + "'") 

$CSVPersonen.object | ConvertTo-Html -Title "test" -body '<h1 style="color:Black;font-size:40px;">Heading</h1>' | Out-File test.html

$exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vSchnellsterAlarm" | Select-Object -skip 1

$tabelle2=| ConvertTo-Json
New-Object 
$tabelle2 = $exp | Select-Object -skip 1
$tabelle = $tabelle2

$tabelle2.alrnumber
$tabelle2.get-type


$a.gettype()

$a = foreach ($el in $exp){
    New-Object -f $el
}

$a = $tabelle2 | ConvertTo-CSV | ConvertFrom-Csv

$tabelle2 | ConvertTo-CSV | ConvertFrom-Csv | ConvertTo-Html -Title $Title -body ('<h1 style="color:Black;font-size:40px;">' + $Title +'</h1>') | Out-File ($pfadExportHTML+$Title + ".html")


$exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vSchnellsterAlarm"

$OutTable = $exp | Select-Object -skip 1 
$tabelleObject | ConvertTo-CSV  | ConvertFrom-Csv
$tabelleout = $tabelleObject | ConvertTo-Html -Title $Title -body ('<h1 style="color:Black;font-size:40px;">' + $Title + '</h1>') 
$tabelleout | Out-File -FilePath ($pfadExportHTML+$Title + ".html")