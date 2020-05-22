$OutputPath = "$PSScriptRoot\..\..\..\output"
$Address = 'http://localhost:5000'

Remove-Item "$Env:ProgramData\UniversalAutomation" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$Env:ProgramData\PowerShellUniversal" -Force -Recurse -ErrorAction SilentlyContinue

Push-Location "$PSScriptRoot\..\..\..\"
Start-Process "$OutputPath\Universal.Server.exe"
Pop-Location

Import-Module "Universal"

while($true) {
    try {
        Invoke-WebRequest "$Address/api/v1/alive" | Out-null
        break
    }
    catch {}
}

try 
{

    Invoke-WebRequest "$Address/api/v1/signin" -Method Post -Body (@{ username = 'admin'; password = '1234' } | ConvertTo-Json) -SessionVariable 'PUWS' -ContentType 'application/json' | out-null
    $AppToken = (Invoke-WebRequest "$Address/api/v1/apptoken/grant" -WebSession $PUWS).Content | ConvertFrom-Json

    Connect-UAServer -ComputerName $Address -AppToken $AppToken.Token
    $Framework = Add-UDDashboardFramework -Name 'Test' -Version 'Test' -Path "$PSScriptRoot\..\output"
    Add-UDDashboard -Name 'Test' -FilePath "$PSScriptRoot\dashboard.ps1" -Framework $Framework -BaseUrl '/' 
}
catch 
{
    Get-Process "Universal.Server" | Stop-Process
    throw $_
}