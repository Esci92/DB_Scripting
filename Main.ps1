# 31.03.2021 - CE
#

$sqlPostgreServerIP = "192.168.10.246"
$sqlPostgreusername = "username"
$sqlPostgrepassword = "password"

$sqlMSServerIP = "192.168.7.156"
$sqlMSusername = "username"
$sqlMSpassword = "password"

Import-Module "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Powershell\SQLConnctors.psm1" -Verbose
Import-Module "C:\Users\Christian\Desktop\Sync\HF\DB2\DB\Powershell\PostgreSQLConnector.psm1" -Verbose

$test = GetProstgresSQLData -PostgreIP $sqlPostgreServerIP -Username $sqlPostgreusername -Password $sqlPostgrepassword -Database "nv_alarm" -SqlQuery "SELECT * FROM public.alarm_data ORDER BY id ASC LIMIT 100"

#
#$i = 0
#$test | foreach  {
#    $a = $test[$i]
#    $i += 1
#}
GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm" -SqlQuery "SET IDENTITY_INSERT AlarmStat off"

GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm" -SqlQuery "SET IDENTITY_INSERT AlarmStat off; insert into AlarmStat(AlarmStatID,alrnumber) values(1,9867);"

GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "Alarm" -SqlQuery "SELECT * FROM AlarmStat"
