param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
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
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should open link in new tab" {
            Find-SeElement -Driver $Driver -LinkText "Google" | Get-SeElementAttribute -Attribute "target" | Should be "_blank"
            Find-SeElement -Driver $Driver -LinkText "Boogle" | Get-SeElementAttribute -Attribute "target" | Should be "_self"
        }

        It "should have color" {
            Find-SeElement -Driver $Driver -LinkText "MICROSOFT" | Get-SeElementAttribute -Attribute "style" | Should be "color: rgb(255, 83, 13);"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}
