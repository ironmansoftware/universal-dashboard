Write-Host "Installing Universal Dashboard Community Edition..."
Install-module  UniversalDashboard.Community -AllowPrerelease -AcceptLicense -Force 
Import-module UniversalDashboard.Community -Force 

Write-Host "Starting Demo Dashboard..."

Try{
    Get-UDDashboard | Stop-UDDashboard
    Start-UDDashboard -Port 8080
    Read-Host "Universal Dashboard Community Edition is now running!"
}
Catch{
    Write-Host "UniversalDashboard failed to start!"
}
