function WriteLog {

    param(  
        $Output = $(throw "IP or FQDN is required."), 
        $Error,
        $errorfile,
        $logfile
    )
    
    ($Error -eq $false){
        "Succes;" | Out-File -FilePath $errorfile -Append -NoNewline
    } else {
        
        Success
        "Error;" | Out-File -FilePath $errorfile -Append -NoNewline
    }

    "Error;" | Out-File -FilePath $errorfile -Append -NoNewline

    ## Generieren 1 Zeilen Text
    Get-Date | Out-File -FilePath $errorfile -Append -NoNewline
    ";" | Out-File -FilePath $errorfile -Append -NoNewline
    $Output | Out-File -FilePath $errorfile -Append
}
