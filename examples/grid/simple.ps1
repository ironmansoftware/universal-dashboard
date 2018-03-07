<#
    Provides an example of a simple grid.
#>
Import-Module UniversalDashboard

$Data = @(
    [PSCustomObject]@{Animal="Frog";Order="Anura"}
    [PSCustomObject]@{Animal="Tiger";Order="Carnivora"}
    [PSCustomObject]@{Animal="Bat";Order="Chiroptera"}
    [PSCustomObject]@{Animal="Fox";Order="Carnivora"}
)

$Dashboard = New-UDDashboard -Title "Grids - Simple" -Content {
    New-UDGrid -Title "Animals" -Headers @("Animal", "Order") -Properties @("Animal", "Order") -Endpoint {
        $Data | Out-UDGridData
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080