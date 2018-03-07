<#
    Provides an example of providing custom help text on the input
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Input - Custom Help Text" -Content {
    New-UDInput -Title "Input" -Endpoint {
        param([Parameter(HelpMessage="Enter your text here")]$Text) 
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080