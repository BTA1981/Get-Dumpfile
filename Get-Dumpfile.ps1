Start-Transcript -Path C:\_Beheer\dumpfiles.log
import-module activedirectory
$ErrorActionPreference = 'silentlycontinue'
$xenappservers = Get-ADComputer -filter * -SearchBase "OU=NVIDIA-GRID,OU=Produktie,OU=XenApp78,OU=Servers,DC=Corp,DC=nl" | Sort-Object Name

foreach ($computer in $xenappservers) {
    $fqdn = ''
    $path = ''
    $fqdn = $computer.DNSHostName.ToString()
    $path = '\\' + $fqdn + '\c$\windows\minidump\' 
    $dmpfiles = ''
    $dmpfiles = get-childitem -Path $path
    write-host $fqdn
    Write-host $dmpfiles
    $dmpfiles = $dmpfiles.ToString()

    $Array += New-Object -TypeName PSObject -Property @{ # Fill Array with custom objects
        'ServerName' = $fqdn
        'DUMPfiles' = $dmpfiles
} # End PS Object




}
foreach ($computer in $array) {
write-host $computer.servername
write-host $computer.DUMPfiles
}

Stop-Transcript


