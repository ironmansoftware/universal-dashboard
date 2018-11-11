param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
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
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should redirect to google" {
            $Element = Find-SeElement -Driver $Cache:Driver -Id 'Counter'
            $Text = $Element.Text

            $Element = Find-SeElement -Driver $Cache:Driver -Id 'Button'
            Invoke-SeClick -Element $Element

            Start-Sleep 2

            $Cache:Driver.Url.ToLower().COntains("https://www.google.com") | Should be $true 
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }
}






