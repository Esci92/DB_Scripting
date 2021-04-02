# 31.03.2021 - CE
# 02.04.2021 - CE

#Variablen
$sqlPostgreServerIP = "192.168.10.246"
$sqlPostgreusername = "username"
$sqlPostgrepassword = "password"
$sqlMSServerIP      = "192.168.10.131"
$sqlMSusername      = "username"
$sqlMSpassword      = "password"

# Import der Module
Import-Module "C:\Users\Christian\Documents\Git\DB_Scripting\SQLConnctors.psm1" -Verbose
Import-Module "C:\Users\Christian\Documents\Git\DB_Scripting\HilfsFunktionen.psm1" -Verbose

#Test 
$test = GetProstgresSQLData -PostgreIP $sqlPostgreServerIP -Username $sqlPostgreusername -Password $sqlPostgrepassword -Database "nv_alarm" -SqlQuery "SELECT * FROM public.alarm_data ORDER BY id DESC LIMIT 100"
$Test2 = GetMSSQLData -MSSQLIP $sqlMSServerIP -Username $sqlMSusername -Password $sqlMSpassword -Database "ABO" -SqlQuery "SELECT * FROM Mitglied"

# Interesting
$i = 1
$test[$i].tstamp
$test[$i].starttime
$test[$i].endtime
GetTimefromTimeStamp -TimeStamp $test[$i].tstamp
$test[$i].week
$test[$i].msg
$test[$i].launchedby
$test[$i].alrnumber
$test[$i].alrname
$test[$i].grpnumber
$test[$i].grpname

