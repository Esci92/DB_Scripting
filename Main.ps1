#/--------------------------------------------------------------------------------------/
#/ Main File - PostgreSQL, CSV to MSSQL and Reporting                                   /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

#------------------------------------------------------------- Variablen ----------------------------------------------------------------------

# Laden der Standart werte
if ($args[0] -eq $null){
    # PostgreSQL Variablen
    $sqlPostgreServerIP = "192.168.10.246"
    $sqlPostgreusername = "username"
    $sqlPostgrepassword = "password"

    # MSSQL Variablen
    $sqlMSServerIP = "192.168.10.144"
    $sqlMSusername = "username"
    $sqlMSpassword = "password"

    # User fur die DB
    $CreateSQLusername = "Roberto" 
    $CreateSQLpassword = "tshf9999$"
  
    # WorkDirektories Variablen
    $Stammpfad = "C:\Users\Christian\Desktop\Sync\HF\DB2\DB"

    # Warnung
    Write-Host "Es wurden die Standart werte übernommen"
    Write-Host "PostgreSQL IP, Username, Password, MSSQL IP, Username, Password, Neuer SQL username, Neuer SQL password,Pfad"
}

# Laden der Argummente
else {
    # PostgreSQL Variablen
    $sqlPostgreServerIP = $args[0]
    $sqlPostgreusername = $args[1]
    $sqlPostgrepassword = $args[2]

    # MSSQL Variablen
    $sqlMSServerIP = $args[3]
    $sqlMSusername = $args[4]
    $sqlMSpassword = $args[5]

    # User fur die DB
    $CreateSQLusername = $args[6]
    $CreateSQLpassword = $args[7]

    # WorkDirektories Variablen
    $Stammpfad = $args[8]
}

# Variablen
$DatenbankSQL = "Alarm"
$DatenbankPostgre = "nv_alarm"

# WorkDirektories Variablen
$PfadModules = ($Stammpfad + "\Powershell\")
$pfadCSV = ($Stammpfad + "\Exports\")
$pfadExportHTML = ($Stammpfad + "\Export-HTML\")
$pfadExportCSV = ($Stammpfad + "\Export-CSV\")
$Logspfad = ($Stammpfad + "\Logs")

# Importieren der Module
Import-Module ($PfadModules + "CSVImport.psm1")
Import-Module ($PfadModules + "FileExport.psm1")
Import-Module ($PfadModules + "MSSQLBusinessLogic.psm1")
Import-Module ($PfadModules + "MSSQLConnctor.psm1")
Import-Module ($PfadModules + "PostgreSQLConnector.psm1")
Import-Module ($PfadModules + "ViewsBusinessCases.psm1")
Import-Module ($PfadModules + "TabellenExport.psm1")

# Zusammenbauen Verbindungs Strings 
$MSSQLConnectionString = CreateMSSQLConnectionString -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database $DatenbankSQL
$PostgresConnectionString = CreatePostgresConnectionString -PostgreIP $sqlPostgreServerIP -Username $sqlPostgreusername -Password $sqlPostgrepassword -Database $DatenbankPostgre

#----------------------------------------------------------- Erstellen der Strktur ----------------------------------------------------------------------

# Erstellen der Ordner Struktur
CreateOrdner $Stammpfad 

# Estellen der Files
CreateLog $Logspfad

#----------------------------------------------------------- Einlesen von Daten ----------------------------------------------------------------------

# einlesen der Daten CSV
$CSVGrupen = GetImportFormatiertGruppen -Pfad ($pfadCSV + "groups_export-20210330.csv")
$CSVPersonen = GetImportFormatiertPersonen -Pfad ($pfadCSV + "nvpers-20210330.csv")
$CSVGrupenPersonen = GetImportFormatiertPersonenGruppen -Pfad ($pfadCSV + "nv_accountpers-group_20210330.csv") -GrupenListe $CSVGrupen

# einlesen der Daten Postgres
$PostgresData = GetProstgrsSQLData -PostgreSQLConnection $PostgresConnectionString -SqlQuery "select * from public.alarm_data ORDER BY id DESC Limit 30000"

#---------------------------------------------------------- Schreiben von Daten ----------------------------------------------------------------------

# Erstellen des SQL USers
$status = CreateSQLUser -MSSQLConnection $MSSQLConnectionString -User $CreateSQLusername -password $CreateSQLpassword -Datenbank $DatenbankSQL

# Schreiben aller MedienTyoen in die Datenbank 
$status = SetMSSQLMedium -MSSQLConnection $MSSQLConnectionString -CSVPersonen $CSVPersonen -Logspfad $Logspfad

# Schreiben aller Grupen in die Datenbank / Updaten der Namen
$status = SetMSSQLGrupen -MSSQLConnection $MSSQLConnectionString -CSVGrupen $CSVGrupen -Logspfad $Logspfad

# Schreiben der Alarmstatistik in die Datenbank / Updaten der Namen
$status = SetMSSQLAlarmStat -MSSQLConnection $MSSQLConnectionString -PostgresData $PostgresData -Logspfad $Logspfad

# Schreiben aller Personen in die Datenbank / Updaten der Namen
$status = SetMSSQLPersonen -MSSQLConnection $MSSQLConnectionString -CSVPersonen $CSVPersonen -Logspfad $Logspfad

# Schreiben Personen Gruppen in die Datenbank
$status = SetMSSQLGrupenPersonen -MSSQLConnection $MSSQLConnectionString -CSVGrupenPersonen $CSVGrupenPersonen -CSVGrupen $CSVGrupen -Logspfad $Logspfad

# Exportieren der BusinessCases auf HTML
$status = ExportAllToHTML -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

# Exportieren der Daten in CSV
$status = ExportTabellen -MSSQLConnection $MSSQLConnectionString -pfadExportCS $pfadExportCSV
