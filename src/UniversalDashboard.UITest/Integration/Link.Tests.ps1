. "$PSScriptRoot\..\TestFramework.ps1"

Describe "New-UDLink" {
    Context "Link in card" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(New-UDLink -Url "http://www.microsoft.com" -Text "Microsoft" -FontColor "#FF530D")
        } -NavbarLinks @(
            New-UDLink -Url "http://www.google.com" -Text "Google" -OpenInNewWindow
            New-UDLink -Url "http://www.google.com" -Text "Boogle"
        )

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should open link in new tab" {
            Find-SeElement -Driver $Driver -LinkText "Google" | Get-SeElementAttribute -Attribute "target" | Should be "_blank"
            Find-SeElement -Driver $Driver -LinkText "Boogle" | Get-SeElementAttribute -Attribute "target" | Should be "_self"
        }

        It "should have color" {
            Find-SeElement -Driver $Driver -LinkText "MICROSOFT" | Get-SeElementAttribute -Attribute "style" | Should be "color: rgb(255, 83, 13);"
        }
    }
}
