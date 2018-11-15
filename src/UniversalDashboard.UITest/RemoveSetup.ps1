Write-Host "Stoping Dashboard."
Stop-UDDashboard -Name 'Dashboard_For_Tests'

Write-Host "Stop Selenium Driver"
Stop-SeDriver -Driver $Cache:Driver

Stop-Service -Name UniversalDashboard -ErrorAction SilentlyContinue

