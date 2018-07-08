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






