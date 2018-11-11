param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Select" {
    Context "onSelect" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSelect -Label "Test" -Id 'test' -Option {
                New-UDSelectOption -Nam "Test 1" -Value "1"
                New-UDSelectOption -Nam "Test 2" -Value "2"
                New-UDSelectOption -Nam "Test 3" -Value "3"
            } -OnChange {
                Set-UDElement -Id "output" -Content { $EventData }
            }

            New-UDElement -Id "output" -Tag "div" -Content { }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should select item" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Cache:Driver | Select-Object -First 1
            Invoke-SeClick -Element $Element
            
            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 0 -First 1
            Invoke-SeClick -Element $Element

            (Find-SeElement -Driver $Cache:Driver -Id 'output').Text | should be "1"
        }

       Stop-SeDriver $Cache:Driver
       Stop-UDDashboard -Server $Server 
    }
}