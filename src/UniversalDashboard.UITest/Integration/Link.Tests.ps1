param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

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
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should open link in new tab" {
            Find-SeElement -Driver $Cache:Driver -LinkText "Google" | Get-SeElementAttribute -Attribute "target" | Should be "_blank"
            Find-SeElement -Driver $Cache:Driver -LinkText "Boogle" | Get-SeElementAttribute -Attribute "target" | Should be "_self"
        }

        It "should have color" {
            Find-SeElement -Driver $Cache:Driver -LinkText "MICROSOFT" | Get-SeElementAttribute -Attribute "style" | Should be "color: rgb(255, 83, 13);"
        }

       Stop-SeDriver $Cache:Driver
       Stop-UDDashboard -Server $Server 
    }
}
