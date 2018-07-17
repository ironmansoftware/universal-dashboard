param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

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






