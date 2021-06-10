

#Addiert zur zum TimeStamp 1970 um die Aktuele Zeit und datum zu erhalten. 
function GetTimefromTimeStamp {
    param (
        $TimeStamp
    )

    #Ruckgabe der Aktuelen zeit
    return (Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds($TimeStamp))
}
