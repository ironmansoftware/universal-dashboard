Import-Module UniversalDashboard.Community -Force

# First Let's define a list of servers to monitor and if we should automatically ping the server.
$MonitoredServersSetup = @()
$Cache:MonitoredServers = @()
$Cache:AutoPing = $false
$Servers = @("www.google.com", "www.github.com", "8.8.8.8", "192.168.0.130")

# Create some PowerShell objects to feed into our UI / Update Later
$Servers | ForEach-Object {
    $ServerObject = [PSCustomObject]@{
        Server = $_
        LastUp = (Get-Date)
        Status = $false
        Pings = @()
    }
    $MonitoredServersSetup += $ServerObject
}
$Cache:MonitoredServers = $MonitoredServersSetup

###############################

#region dynmaic server page
$ServerPage = New-UDPage -Url "/server/:Name" -Icon home -Endpoint {
    param($Name)

    if($Cache:MonitoredServers.Server -notcontains $Name){
        New-UDHeading -Text "server [$Name] not found."
    }
    else {
        New-UDButton -Text "Clear ping data" -OnClick (New-UDEndpoint -Endpoint {
            $ServerToUpdate = $Cache:MonitoredServers | Where-Object { $_.Server -eq $ArgumentList[0] }
            $ServerToUpdate.Pings = @()
           
            Sync-UDElement -Id "ping_RTT" -Broadcast
            Sync-UDElement -Id "ping_timeout" -Broadcast
            Sync-UDElement -Id "ping_table" -Broadcast

            Show-UDToast -Message ("cleared ping data") -Duration 2000
        } -ArgumentList $Name)

        New-UDTable -Title 'Server' -Headers @("Name", "Value") -AutoRefresh -RefreshInterval 30 -Endpoint {
            $Server = $Cache:MonitoredServers | Where-Object { $_.Server -eq $Name }

            ($Server | Select Server, LastUp, @{Name='Status'; Expression={[string]$_.Status}}).PSObject.Properties | %{Out-UDTableData -Data $_ -Property @("Name", "Value")}
        }

        New-UDRow -Endpoint {
            New-UDColumn -LargeSize 6 -Content {
                New-UDChart -Id 'ping_RTT' -Title "Ping - RoundtripTime (ms)" -Type Line -AutoRefresh -RefreshInterval 30 -Endpoint {
                    $Server = $Cache:MonitoredServers | Where-Object { $_.Server -eq $Name }
        
                    $Server.Pings | ?{$_.PingSucceeded} | Select Timestamp, @{Name='RoundtripTime'; Expression={$_.PingReplyDetails.RoundtripTime}} | Out-UDChartData -LabelProperty "Timestamp" -DataProperty "RoundtripTime"
                } -Options @{legend = @{display = $false}; elements = @{point = @{radius = 0}}; scales = @{xAxes = @(@{type = 'time'}); yAxes = @(@{ticks = @{beginAtZero = $true}})}}     
            }
            New-UDColumn -LargeSize 6 -Content {
                New-UDChart -Id 'ping_timeout' -Title "Ping - Timeout" -Type Line -AutoRefresh -RefreshInterval 30 -Endpoint {
                    $Server = $Cache:MonitoredServers | Where-Object { $_.Server -eq $Name }
        
                    $Server.Pings | Select Timestamp, @{Name='Timeout'; Expression={if($_.PingSucceeded){0}else{1}}} | Out-UDChartData -LabelProperty "Timestamp" -DataProperty "Timeout"
                } -Options @{legend = @{display = $false}; elements = @{point = @{radius = 0}}; scales = @{xAxes = @(@{type = 'time'}); yAxes = @(@{ticks = @{beginAtZero = $true}})}}
            }
        }

        New-UDRow -Endpoint {
            New-UDColumn -LargeSize 12 -Content {
                New-UdGrid -Id 'ping_table' -Title 'Ping' -Headers @('Timestamp', 'Succeeded', 'RoundtripTime (ms)') -Properties @('Timestamp', 'Succeeded', 'RoundtripTime') -AutoRefresh -RefreshInterval 30 -Endpoint {
                    $Server = $Cache:MonitoredServers | Where-Object { $_.Server -eq $Name }
                    
                    $Server.Pings | Select Timestamp, @{Name='Succeeded'; Expression={[string]$_.PingSucceeded}}, @{Name='RoundtripTime'; Expression={$_.PingReplyDetails.RoundtripTime}} | Out-UdGridData
                }
            }
        }
    }
}
#endregion


$HomePage = New-UDPage -Url "/dashboard" -Title "This is my homepage" -Endpoint {
    New-UDGrid -Id "PingStatusGrid" -Title "Ping List" -Headers @("Server", "LastUp", "Status", "Ping", "Remove") -Properties @("Server", "LastUp", "Status", "Ping", "Remove") -Endpoint {
        
        $Cache:MonitoredServers | ForEach-Object {    

            [PSCustomObject]@{
                Server = New-UDLink -Text $_.Server -Url "/server/$($_.Server)"
                LastUp = $_.LastUp
                Status = $_.Status
                
                # Add a PING button to PING the specific server NOW and update grid. https://docs.universaldashboard.io/components/button
                Ping   = New-UDButton -Text "Ping Now" -BackgroundColor "#4caf50" -OnClick (New-UDEndpoint -Endpoint {
                        Show-UDToast -Message ("Pinging: $ArgumentList") -Duration 2000
                        $PingResult = Test-NetConnection $ArgumentList[0] | Select *, @{Name='Timestamp'; Expression={Get-Date}}
                        $ServerToUpdate = $Cache:MonitoredServers | Where-Object { $_.Server -eq $ArgumentList[0] }
                        $ServerToUpdate.Pings += $PingResult
                        if ($pingResult.PingSucceeded -eq $true) {
                            $ServerToUpdate.Status = $true
                            $ServerToUpdate.LastUp = (Get-Date)
                        }
                        else {
                            $ServerToUpdate.Status = $false
                        }
                        
                        Sync-UDElement -Id "PingStatusGrid" -Broadcast
                    } -ArgumentList $_.Server)
                # Remove button to remove the server from our ping list https://docs.universaldashboard.io/components/button
                Remove = New-UDButton -Text "Remove" -BackgroundColor "#f44336" -OnClick (New-UDEndpoint -Endpoint {
                        Show-UDToast -Message ("Removing: $ArgumentList") -Duration 2000
                        $ServerToRemove = $Cache:MonitoredServers | Where-Object { $_.Server -eq $ArgumentList[0] }
                        $NewMonitoredServers = @()
                        $Cache:MonitoredServers | ForEach-Object {
                            if ($_ -ne $ServerToRemove) {
                                $NewMonitoredServers += $_
                            }
                        }
                        $Cache:MonitoredServers = $NewMonitoredServers
                        Sync-UDElement -Id "PingStatusGrid" -Broadcast
                    } -ArgumentList $_.Server)
            }
        } | Out-UDGridData

    }

    # New Button to add a new server to the ping list and refresh the list https://docs.universaldashboard.io/components/button
    New-UDButton -Id "btnAddNewServer" -Text "New Server" -BackgroundColor "#03a9f4" -OnClick( New-UDEndpoint -Endpoint {
            Show-UDModal -Content {
                # New Input Form - https://docs.universaldashboard.io/components/inputs
                New-UDInput -Title "Add New Server to Ping List" -SubmitText "Add" -Content {
                    New-UDInputField -Name "Server" -Placeholder "Hostname, or IP" -Type "textbox"
                } -Endpoint {
                    if ($Server) {
                        # Don't Add new Server if it is already in the list as this causes bugs!
                        if ($Cache:MonitoredServers.Server -notcontains $Server) {
                            $NewMonitoredServers = @()
                            $Cache:MonitoredServers | ForEach-Object { $NewMonitoredServers += $_ }
                            $ServerObject = [PSCustomObject]@{
                                Server = $Server
                                LastUp = (Get-Date)
                                Status = $false
                                Pings = @()
                            }
                            $NewMonitoredServers += $ServerObject
                            $Cache:MonitoredServers = $NewMonitoredServers
                        }
                        else {
                            Show-UDToast -Message ("$Server already exists in ping list!") -Duration 5000 -BackgroundColor "#f44336" -MessageColor "#ffffff"
                        }
                    }
                    Sync-UDElement -Id "PingStatusGrid" -Broadcast
                    Hide-UDModal
                }
            }
        })

    # New Automation value to control if the scheduled endpoint should be auto-pinging
    New-UDButton -Id "btnAutomation" -Text "Automation" -BackgroundColor "#ff9800" -OnClick( New-UDEndpoint -Endpoint {   
            # Show New Modal https://docs.universaldashboard.io/components/modal
            Show-UDModal -Content {
                # New Input Form - https://docs.universaldashboard.io/components/inputs
                New-UDInput -Title "Automated Ping Control" -SubmitText "Set" -Content {
                    New-UDInputField -Name "AutoPing" -Placeholder "Should Automatically Ping?" -Type "checkbox" -DefaultValue ($Cache:AutoPing)
                } -Endpoint {
                    if ($AutoPing -eq $true) {
                        $Cache:AutoPing = $true
                    }
                    else {
                        $Cache:AutoPing = $false
                    }
                    Hide-UDModal
                }
                
            }
        })
}

# Setup new Dashboard with Grid
$Navigation = New-UDSideNav -None
$Dashboard = New-UDDashboard -Title "PowerShell Ping Buddy" -Navigation $Navigation -Pages @($HomePage, $ServerPage)

########################

# New 30 second schedule
$30SecSchedule = New-UDEndpointSchedule -Every 30 -Second

# New Endpoint to ping the server address of my "MonitoredServers Object - we'll also refresh the UD grid."
$PingEndpoint = New-UDEndpoint -Schedule $30SecSchedule -Endpoint {
    if ($Cache:AutoPing -eq $true) {
        $Cache:MonitoredServers | ForEach-Object {
            $pingResult = Test-NetConnection $_.Server | Select *, @{Name='Timestamp'; Expression={Get-Date}}
            $_.Pings += $pingResult

            if ($pingResult.PingSucceeded -eq $true) {
                $_.Status = $true
                $_.LastUp = (Get-Date)
            }
            else {
                $_.Status = $false
            }
        }
    
        Sync-UDElement -Id "PingStatusGrid" -Broadcast
    }
}

Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dashboard -Port 10000 -Endpoint $PingEndpoint 
Start http://localhost:10000