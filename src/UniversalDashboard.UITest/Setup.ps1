Write-Host "Starting Test Dashboard"
Start-UDDashboard -Port 10001 -Name 'Dashboard_For_Tests' -Content {
    New-UDDashboard -Title 'Speed Test' -Content {} -FontIconStyle FontAwesome
} -UpdateToken 'TestDashboard'

Write-Host "Import Selenium Module"
Import-Module "$PSScriptRoot\Integration\Selenium\Selenium.psm1" -Force 

Write-Host "Start Selenium FireFox Driver"
$Cache:Driver = Start-SeFirefox

Write-Host "Open FireFox Browser With http://localhost:10001"
Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:10001"
