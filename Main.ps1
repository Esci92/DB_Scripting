# 31.03.2021 - CE

$sqlServerIP = "192.168.10.246"
$sqlusername = "username"
$sqlpassword = "password"

Import-Module "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Powershell\SQLConnctors.psm1" -Verbose

GetProstgresSQLData -PostgreIP $sqlServerIP -Username $sqlusername -Password $sqlpassword -Database "nv_alarm" -SqlQuery "SELECT * FROM public.alarm_data ORDER BY id ASC LIMIT 100"

