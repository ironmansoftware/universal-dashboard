<#
    Provides an example of redirecting to a dynamic page after taking input.
#>

Import-Module UniversalDashboard

$HomePage = New-UDPage -Name "Home" -Content {
    New-UDInput -Title "Input" -Endpoint {
        param($Text) 

        New-UDInputAction -RedirectUrl "/dynamic/$text"
    }
}

$DynamicPage = New-UDPage -Url "/dynamic/:text" -Endpoint {
    param($text)

    New-UDCard -Title $text
}

$Dashboard = New-UDDashboard -Title "Input - Dynamic Page" -Pages @(
    $HomePage
    $DynamicPage
)
Start-UDDashboard -Dashboard $Dashboard -Port 8080