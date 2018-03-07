<#
    Provides an example of using custom columns.
#>
Import-Module UniversalDashboard

$Data = @(
    [PSCustomObject]@{Animal="Frog";Order="Anura";Article=(New-UDLink -Text "Wikipedia" -Url "https://en.wikipedia.org/wiki/Frog")}
    [PSCustomObject]@{Animal="Tiger";Order="Carnivora";Article=(New-UDLink -Text "Wikipedia" -Url "https://en.wikipedia.org/wiki/Tiger")}
    [PSCustomObject]@{Animal="Bat";Order="Chiroptera";Article=(New-UDLink -Text "Wikipedia" -Url "https://en.wikipedia.org/wiki/Bat")}
    [PSCustomObject]@{Animal="Fox";Order="Carnivora";Article=(New-UDLink -Text "Wikipedia" -Url "https://en.wikipedia.org/wiki/Fox")}
)

$Dashboard = New-UDDashboard -Title "Grids - Custom Columns" -Content {
    New-UDGrid -Title "Animals" -Headers @("Animal", "Order", "Wikipedia") -Properties @("Animal", "Order", "Article") -Endpoint {
        $Data | Out-UDGridData
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080