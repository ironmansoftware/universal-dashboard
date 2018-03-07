<#
    Provides an example of a Microsoft Account login page.
#>
Import-Module UniversalDashboard

$MicrosoftLogin = New-UDAuthenticationMethod -AppId "xyz" -AppSecret "123" -Provider Microsoft 

$LoginPage = New-UDLoginPage -AuthenticationMethod @($MicrosoftLogin)

$MyDashboardPage = New-UDPage -Url "/myDashboard" -Endpoint {
    New-UDCard -Title "Welcome, $User" -Text "This is your custom dashboard."
}

$Dashboard = New-UDDashboard -LoginPage $LoginPage -Page @(
    $MyDashboardPage
)

Start-UDDashboard -Dashboard $Dashboard -Port 8080