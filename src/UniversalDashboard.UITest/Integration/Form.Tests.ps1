param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Forms" {
    Context "Forms" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDTextbox -Label "Click me" -Id "txtBox"
            New-UDSelect -Label "Select me" -Id "select" -Option {
                New-UDSelectOption -Name "test1" -Value 1
                New-UDSelectOption -Name "test2" -Value 2
                New-UDSelectOption -Name "test3" -Value 3
                New-UDSelectOption -Name "test4" -Value 4
            } -OnChange {
                $Cache:SelectData = $EventData
            }

            New-UDCounter -Title "Select" -Id "SelectValue" -Endpoint {
                $Cache:SelectData 
            } -AutoRefresh -RefreshInterval 1
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have title text" {
            $Element = Find-SeElement -Id "txtBox" -Driver $Driver
            Send-SeKeys -Element $Element -Keys 'hey'
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}