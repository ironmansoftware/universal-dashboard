Write-Host "Starting Test Dashboard"
Start-UDDashboard -Port 10001 -Name 'Dashboard_For_Tests' -Content {
    New-UDDashboard -Title 'Speed Test' -Content {}
} -Design

Write-Host "Start Selenium FireFox Driver"
$Cache:Driver = Start-SeFirefox

Write-Host "Open FireFox Browser With http://localhost:10001"
Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:10001"
