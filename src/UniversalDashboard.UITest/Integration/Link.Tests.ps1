param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1" -Force 

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Get-UDDashboard | Stop-UDDashboard

Describe "New-UDLink" {
    Context "Link in card" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(New-UDLink -Url "http://www.microsoft.com" -Text "Microsoft" -FontColor "#FF530D")
        } -NavbarLinks @(
            New-UDLink -Url "http://www.google.com" -Text "Google" -OpenInNewWindow
            New-UDLink -Url "http://www.google.com" -Text "Boogle"
        )

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should open link in new tab" {
            Find-SeElement -Driver $Driver -LinkText "Google" | Get-SeElementAttribute -Attribute "target" | Should be "_blank"
            Find-SeElement -Driver $Driver -LinkText "Boogle" | Get-SeElementAttribute -Attribute "target" | Should be "_self"
        }

        It "should have color" {
            Find-SeElement -Driver $Driver -LinkText "Microsoft" | Get-SeElementAttribute -Attribute "style" | Should be "color: rgb(255, 83, 13);"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}
