param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Counter" {
    Context "Custom Counter" {

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Test" -Id "Counter" -TextAlignment Left -TextSize Small -Icon user -Endpoint {
                1000
            } -OnClick {
                $Cache:Data = 'Counter OnClick Event'
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        #Open firefox
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have counter" {
            Find-SeElement -Id "Counter" -Driver $Driver | Should not be $null
        }

        Invoke-SeClick -Element (Find-SeElement -Id 'Counter' -Driver $Driver)

        Start-Sleep 3

        It "should have OnClick event" {
            $Cache:Data | Should Be 'Counter OnClick Event'
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

}
