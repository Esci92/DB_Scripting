#/--------------------------------------------------------------------------------------/
#/ # MSSQL Server - MSSQL Views                                                         /
#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
#/--------------------------------------------------------------------------------------/

# Finden der meist ausgeloesene gruppe und exportieren in einem HTML
function GetvMaxAusgeloeseneGruppe {

    <#
        .SYNOPSIS
        Finden der meist ausgeloesene gruppe und exportieren in einem HTML

        .DESCRIPTION
        Finden der meist ausgeloesene gruppe und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMaxAusgeloeseneGruppe -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
                
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    # Finden der meist ausgeloesene gruppe
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxAusgeloeseneGruppe"    
    ExportTabelleToHTML -Title "Am meisten verwendete Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der am wenigsten ausgeloesene gruppe und exportieren in einem HTML
function GetvMinAusgeloeseneGruppe {

    <#
        .SYNOPSIS
        Finden der am wenigsten ausgeloesene gruppe und exportieren in einem HTML

        .DESCRIPTION
        Finden der am wenigsten ausgeloesene gruppe und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMinAusgeloeseneGruppe -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
                
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der am wenigsten ausgeloesene gruppe
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinAusgeloeseneGruppe"    
    ExportTabelleToHTML -Title "Am wenigsten Verwendete Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der am meist ausgelösener Alarm und exportieren in einem HTML
function GetvMaxAusgeloeseneAlarm {

    <#
        .SYNOPSIS
        Finden der am meist ausgelösener Alarm und exportieren in einem HTML

        .DESCRIPTION
        Finden der am meist ausgelösener Alarm und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMaxAusgeloeseneAlarm -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der am meist ausgelösener Alarm
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxAusgeloeseneAlarm"    
    ExportTabelleToHTML -Title "Am meisten verwendeter Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der am wenigsten ausgelösener Alarm und exportieren in einem HTML
function GetvMinAusgeloeseneAlarm {

    <#
        .SYNOPSIS
        Finden der am wenigsten ausgelösener Alarm und exportieren in einem HTML

        .DESCRIPTION
        Finden der am wenigsten ausgelösener Alarm und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMinAusgeloeseneAlarm -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der am wenigsten ausgelösener Alarm
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinAusgeloeseneAlarm"    
    ExportTabelleToHTML -Title "Am wenigsten verwendeter Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat und exportieren in einem HTML
function GetvMaxLanuchedBy {

    <#
        .SYNOPSIS
        Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat und exportieren in einem HTML

        .DESCRIPTION
        Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMaxLanuchedBy -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der des User/Schnittstelle die die meisten Alarme ausgeloeset hat
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxLanuchedBy"    
    ExportTabelleToHTML -Title "Die Meisten Alarme ausgeloest durch" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der Gruppe mit den meisten Usern und exportieren in einem HTML
function GetvMaxUserinGruppe {

    <#
        .SYNOPSIS
        Finden der Gruppe mit den meisten Usern und exportieren in einem HTML

        .DESCRIPTION
        Finden der Gruppe mit den meisten Usern und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMaxUserinGruppe -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der Gruppe mit den meisten Usern
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxUserinGruppe"   
    ExportTabelleToHTML -Title "Groesste Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der Gruppe mit den wenigsten Usern und exportieren in einem HTML
function GetvMinUserinGruppe {

    <#
        .SYNOPSIS
        Finden der Gruppe mit den wenigsten Usern und exportieren in einem HTML

        .DESCRIPTION
        Finden der Gruppe mit den wenigsten Usern und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMinUserinGruppe -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der Gruppe mit den wenigsten Usern
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinUserinGruppe"    
    ExportTabelleToHTML -Title "Kleinste Gruppe" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Altesten Alarms und exportieren in einem HTML
function GetvErsterAusgeloesterAlarm{

    <#
        .SYNOPSIS
        Finden des Altesten Alarms und exportieren in einem HTML

        .DESCRIPTION
        Finden des Altesten Alarms und exportieren in einem HTML

        .EXAMPLE
        PS> GetvErsterAusgeloesterAlarm -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden des Altesten Alarms
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vErsterAusgeloesterAlarm"    
    ExportTabelleToHTML -Title "Erster Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Jungsten Alarms und exportieren in einem HTML
function GetvLetzterAusgeloesterAlarm {

    <#
        .SYNOPSIS
        Finden des Jungsten Alarms und exportieren in einem HTML

        .DESCRIPTION
        Finden des Jungsten Alarms und exportieren in einem HTML

        .EXAMPLE
        PS> GetvLetzterAusgeloesterAlarm -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden des Jungsten Alarms
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vLetzterAusgeloesterAlarm"    
    ExportTabelleToHTML -Title "Letzter Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Mediums der am meisten Getverwendet wird und exportieren in einem HTML
function GetvMaxVerwendetesMedium {

    <#
        .SYNOPSIS
        Finden des Mediums der am meisten Getverwendet wird und exportieren in einem HTMLL

        .DESCRIPTION
        Finden des Mediums der am meisten Getverwendet wird und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMaxVerwendetesMedium -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden des Mediums der am meisten Getverwendet wird
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMaxVerwendetesMedium"    
    ExportTabelleToHTML -Title "Am meisten verwendetes Medium" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Mediums der am wenigsten Getverwendet wird und exportieren in einem HTML
function GetvMinVerwendetesMedium {

    <#
        .SYNOPSIS
        Finden des Mediums der am wenigsten Getverwendet wird und exportieren in einem HTML

        .DESCRIPTION
        Finden des Mediums der am wenigsten Getverwendet wird und exportieren in einem HTML

        .EXAMPLE
        PS> GetvMinVerwendetesMedium -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden des Mediums der am wenigsten Getverwendet wird
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vMinVerwendetesMedium"    
    ExportTabelleToHTML -Title "Am wenigsten verwendetes Medium" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden der User die nicht verwendet werden und exportieren in einem HTML
function GetvNichtVerwendeteUser {
    <#
        .SYNOPSIS
        Finden der User die nicht verwendet werden und exportieren in einem HTML

        .DESCRIPTION
        Finden der User die nicht verwendet werden und exportieren in einem HTML

        .EXAMPLE
        PS> GetvNichtVerwendeteUser -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden der User die nicht verwendet werden
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vNichtVerwendeteUser"    
    ExportTabelleToHTML -Title "User nicht im einsatz" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden Getvon usern mit leeren Namen/Vornamen und exportieren in einem HTML
function GetvLeereNamen {

    <#
        .SYNOPSIS
        Finden Getvon usern mit leeren Namen/Vornamen und exportieren in einem HTML

        .DESCRIPTION
        Finden Getvon usern mit leeren Namen/Vornamen und exportieren in einem HTML

        .EXAMPLE
        PS> GetvLeereNamen -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden vLeereNamen usern mit leeren Namen/Vornamen
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vLeereNamen"    
    ExportTabelleToHTML -Title "Leere Namen" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
function GetvLangsamsterAlarm {

    <#
        .SYNOPSIS
        Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML

        .DESCRIPTION
        Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML

        .EXAMPLE
        PS> GetvLangsamsterAlarm -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vLangsamsterAlarm"    
    ExportTabelleToHTML -Title "Langsamster Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

#  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
function GetvSchnellsterAlarm {

    <#
        .SYNOPSIS
        Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML

        .DESCRIPTION
        Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML

        .EXAMPLE
        PS> GetvSchnellsterAlarm -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )
    
    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
    $exp = GetMSSQLData -MSSQLConnection $MSSQLConnectionString -SqlQuery "select * from vSchnellsterAlarm"
    ExportTabelleToHTML -Title "Schnellster Alarm" -tabelle $exp -pfadExportHTML $pfadExportHTML
}

# Exportieren Aller View zu HTML
function ExportAllToHTML{

    <#
        .SYNOPSIS
        Exportieren Aller View zu HTML

        .DESCRIPTION
        Exportieren Aller View zu HTML

        .EXAMPLE
        PS> ExportAllToHTML -MSSQLConnection "Server=192.168.10.144,1433;Database=Alarm;;Integrated Security=false;Uid=username;Pwd=password;" -pfadExportHTML "C:\Export-HTML"
        
        .OUTPUTS
        HTML File.

        .Link
        Keiner
    #>

    param(
        [parameter(Mandatory=$true)] $MSSQLConnectionString,
        [parameter(Mandatory=$true)] $pfadExportHTML
    )

    # Finden der meist ausgelösene gruppe und exportieren in einem HTML
    GetvMaxAusgeloeseneGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML
    
    #  Finden der am wenigsten ausgelösene gruppe und exportieren in einem HTML
    GetvMinAusgeloeseneGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der am meist ausgelösener Alarm und exportieren in einem HTML
    GetvMaxAusgeloeseneAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der am wenigsten ausgelösener Alarm und exportieren in einem HTML
    GetvMinAusgeloeseneAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der des User/Schnittstelle die die meisten Alarme ausgeloeset hat und exportieren in einem HTML
    GetvMaxLanuchedBy -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der Gruppe mit den meisten Usern und exportieren in einem HTML
    GetvMaxUserinGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der Gruppe mit den wenigsten Usern und exportieren in einem HTML
    GetvMinUserinGruppe -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Altesten Alarms und exportieren in einem HTML
    GetvErsterAusgeloesterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Altesten Alarms und exportieren in einem HTML
    GetvLetzterAusgeloesterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Mediums der am meisten Getverwendet wird und exportieren in einem HTML
    GetvMaxVerwendetesMedium -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Mediums der am wenigsten Getverwendet wird und exportieren in einem HTML
    GetvMinVerwendetesMedium -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden der User die nicht verwendet werden und exportieren in einem HTML
    GetvNichtVerwendeteUser -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden Getvon usern mit leeren Namen/Vornamen und exportieren in einem HTML
    GetvLeereNamen -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
    GetvLangsamsterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML

    #  Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat und exportieren in einem HTML
    GetvSchnellsterAlarm -MSSQLConnection $MSSQLConnectionString -pfadExportHTML $pfadExportHTML
}