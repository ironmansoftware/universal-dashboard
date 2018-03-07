<#
    Provides an example of the different type of input types.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Input - Input Types" -Content {
    New-UDInput -Title "Input" -Endpoint {
        param($Text, [bool]$CheckBox, [System.DayOfWeek]$SelectBox, [ValidateSet("One", "Two", "Three")]$SelectBox2) 

        New-UDInputAction -Toast "Clicked!"
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080