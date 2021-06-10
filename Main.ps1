# 31.03.2021 - CE
#

#/--------------------------------------------------------------------------------------/
#/ Main File - PostgreSQL, CSV to MSSQL and Reporting                                  /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# PostgreSQL Variablen
$sqlPostgreServerIP = "192.168.10.246"
$sqlPostgreusername = "username"
$sqlPostgrepassword = "password"

# MSSQL Variablen
$sqlMSServerIP = "192.168.10.144"
$sqlMSusername = "username"
$sqlMSpassword = "password"

$PfadModules = "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Powershell\"
$pfadCSV = "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Exports\"
$pfadExportHTML = "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Export-HTML\"

# Importieren der Module
Import-Module ($PfadModules + "MSSQLConnctor.psm1") -Verbose
Import-Module ($PfadModules + "MSSQLBusinessLogic.psm1") -Verbose
Import-Module ($PfadModules + "PostgreSQLConnector.psm1") -Verbose
Import-Module ($PfadModules + "CSVImport.psm1") -Verbose

# Zusammenbauen Verbindungs Strings 
$MSSQLConnectionString = CreateMSSQLConnectionString -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm"
$PostgresConnectionString = CreatePostgresConnectionString -PostgreIP $sqlPostgreServerIP -Username $sqlPostgreusername -Password $sqlPostgrepassword -Database "nv_alarm"

# einlesen der Daten Postgres
$PostgresData = GetProstgrsSQLData -PostgreSQLConnection $PostgresConnectionString -SqlQuery "select * from public.alarm_data ORDER BY id DESC Limit 30000"

# einlesen der Daten CSV
$CSVGrupen = GetImportFormatiertGruppen -Pfad ($pfadCSV + "groups_export-20210330.csv")
$CSVPersonen = GetImportFormatiertPersonen -Pfad ($pfadCSV + "nvpers-20210330.csv")
$CSVGrupenPersonen = GetImportFormatiertPersonenGruppen -Pfad ($pfadCSV + "nv_accountpers-group_20210330.csv") -GrupenListe $CSVGrupen

# Schreiben aller MedienTyoen in die Datenbank 
SetMSSQLMedium -MSSQLConnection $MSSQLConnectionString -CSVPersonen $CSVPersonen

# Schreiben aller Grupen in die Datenbank / Updaten der Namen
SetMSSQLGrupen -MSSQLConnection $MSSQLConnectionString -CSVGrupen $CSVGrupen

# Schreiben der Alarmstatistik in die Datenbank / Updaten der Namen
SetMSSQLAlarmStat -MSSQLConnection $MSSQLConnectionString -PostgresData $PostgresData

# Schreiben aller Personen in die Datenbank / Updaten der Namen
SetMSSQLPersonen -MSSQLConnection $MSSQLConnectionString -CSVPersonen $CSVPersonen

# Schreiben Personen Gruppen in die Datenbank
SetMSSQLGrupenPersonen -MSSQLConnection $MSSQLConnectionString -CSVGrupenPersonen $CSVGrupenPersonen -CSVGrupen $CSVGrupen

# Exportieren der BusinessCases auf HTML
ExportAllToHTML -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML