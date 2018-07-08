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
Describe "Sync-UDElement" {
    Context "Sync Counter" {
        $Dashboard = New-UdDashboard -Title "Sync Counter" -Content {
            New-UDButton -Text "Button" -Id "Button" -OnClick {
                $Session:Clicked = $true
                Sync-UDElement -Id 'Counter'
            }

            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                if ($Session:Clicked) {
                    1
                } else {
                    0
                }
            }
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should update number in background" {
            $Element = Find-SeElement -Driver $Driver -Id 'Counter'
            $Text = $Element.Text

            $Element = Find-SeElement -Driver $Driver -Id 'Button'
            Invoke-SeClick -Element $Element

            Start-Sleep 2

            (Find-SeElement -Driver $Driver -Id 'Counter').Text | Should not be $Text
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}






