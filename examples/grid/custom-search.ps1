<#
    Provides an example of creating a grid with a custom filtering algorithm.
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
        #By default, filtering checks all properties. This overrides it to only check the animal property.
        #$filterText is always provided in a grid endpoint
        $Data | Where-Object Animal -Match $filterText | Out-UDGridData -NoAutoFilter
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080