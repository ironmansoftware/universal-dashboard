Import-Module UniversalDashboard -Force

# First Let's define a list of servers to monitor
$MonitoredServersSetup = @()
$Cache:MonitoredServers
$Servers = @("www.google.com", "www.github.com", "8.8.8.8","192.168.0.1")

# Create some powershell objects to feed into our UI / Update Later
$Servers | ForEach-Object{
    $ServerObject = [PSCustomObject]@{
        Server = $_
        LastUp = (Get-Date)
        Status = $false
    }
    $MonitoredServersSetup += $ServerObject
}
$Cache:MonitoredServers = $MonitoredServersSetup

# Setup new Dashboard with Grid
Get-UDDashboard | Stop-UDDashboard
$Dashboard = New-UDDashboard -Title "PowerShell Ping Buddy" -Content {

    New-UDGrid -Id "PingStatusGrid" -Title "Ping Buddy" -Headers @("Server", "LastUp","Status") -Properties @("Server","LastUp","Status") -Endpoint {
        $Cache:MonitoredServers | Out-UDGridData
    }

}

# New 30 second schedule
$30SecSchedule = New-UDEndpointSchedule -Every 30 -Second

# New Endpoint to ping the server address of my "MonitoredServers Object - we'll also refresh the UD grid."
$PingEndpoint = New-UDEndpoint -Schedule $30SecSchedule -Endpoint {
    
    $Cache:MonitoredServers | ForEach-Object{
        $pingResult = Test-NetConnection $_.Server
        if($pingResult.PingSucceeded -eq $true)
        {
            $_.Status = $true
            $_.LastUp = (Get-Date)
        }
        else {
            $_.Status = $false
        }
    }

    Sync-UDElement -Id "PingStatusGrid" -Broadcast

}

Get-UDDashboard -Name 'PowerShell Ping Buddy' | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dashboard -Port 10000 -Endpoint $PingEndpoint
Start http://localhost:10000