param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "Invoke-UDRedirect" {
    Context "redirect to google" {
        $Dashboard = New-UdDashboard -Title "Sync Counter" -Content {
            New-UDButton -Text "Button" -Id "Button" -OnClick {
                Invoke-UDRedirect -Url "https://www.google.com"
            }
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should redirect to google" {
            $Element = Find-SeElement -Driver $Driver -Id 'Counter'
            $Text = $Element.Text

            $Element = Find-SeElement -Driver $Driver -Id 'Button'
            Invoke-SeClick -Element $Element

            Start-Sleep 2

            $Driver.Url.ToLower().COntains("https://www.google.com") | Should be $true 
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}






