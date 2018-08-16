$Dashboard = New-UDDashboard -Title Services -Content {
    New-UDRow -Endpoint { 
        Get-Service | ForEach-Object {
            New-UDColumn -Size 2 -Content {
                $BackgroundColor = "Red"
                if ($_.Status -eq 'Running') {
                    $BackgroundColor = "Green"
                }

                New-UDCard -Title $_.Name -Text $_.Status.ToString() -BackgroundColor $BackgroundColor
            } 
        } 
    } -AutoRefresh -RefreshInterval 60
}

Start-UDDashboard -Dashboard $Dashboard -Port 10000