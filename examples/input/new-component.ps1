<#
    Provides an example of returning a new component after taking input.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Input - New Component" -Content {
    New-UDInput -Title "Input" -Endpoint {
        param($Text) 

        New-UDInputAction -Content @(
            New-UDCard -Title $Text -Text "This is text"
        )
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080