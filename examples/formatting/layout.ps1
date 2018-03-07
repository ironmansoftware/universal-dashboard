<#
    Provides an example of using a simple layout.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Formatting - Layout" -Content {
    New-UDLayout -Columns 3 -Content {
        New-UDCard -Title "Card 1"
        New-UDCard -Title "Card 2"
        New-UDCard -Title "Card 3"
        New-UDCard -Title "Card 4"
        New-UDCard -Title "Card 5"
        New-UDCard -Title "Card 6"
        New-UDCard -Title "Card 7"
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080