<#
    Provides an of example of using a dynamic column.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Formatting - Layout" -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 12 -AutoRefresh -RefreshInterval 5 -Endpoint {
            $Max = Get-Random -Minimum 1 -Maximum 12

            1..$Max | ForEach-Object {
                New-UDCard -Title "Card $_"
            }
        }
        
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080