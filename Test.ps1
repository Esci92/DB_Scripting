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