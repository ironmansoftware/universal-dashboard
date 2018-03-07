<#
    Provides an example of returning a toast message to the user.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Input - Toast" -Content {
    New-UDInput -Title "Input" -Endpoint {
        param($Text) 

        New-UDInputAction -Toast $Text -ClearInput
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080