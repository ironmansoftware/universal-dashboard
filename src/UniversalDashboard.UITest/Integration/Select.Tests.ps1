param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Select" {
    Context "onSelect" {
        $dashboard = New-UDDashboard -Title "Test" -Content {

            New-UDButton -Text "Button" -Id 'btn' -OnClick {
                $Value = (Get-UDElement -Id 'test').Attributes['value'] 
                Add-UDElement -ParentId 'output' -Content {
                    New-UDElement -Tag 'div' -Id 'innerOutput2' -Content { $value }
                }
            }

            New-UDSelect -Label "Test" -Id 'test' -Option {
                New-UDSelectOption -Nam "Test 1" -Value "1"
                New-UDSelectOption -Nam "Test 2" -Value "2"
                New-UDSelectOption -Nam "Test 3" -Value "3"
            } -OnChange {
                Add-UDElement -ParentId 'output' -Content {
                    New-UDElement -Tag 'div' -Id 'innerOutput' -Content { $EventData }
                }
            }

            New-UDElement -Id "output" -Tag "div" -Content { }


        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -Design 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should select item" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select-Object -First 1
            Invoke-SeClick -Element $Element
            
            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 0 -First 1
            Invoke-SeClick -Element $Element

            (Find-SeElement -Driver $Driver -Id 'innerOutput').Text | should be "1"
        }

        It "should select item and get it with Get-UDElement" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select-Object -First 1
            Invoke-SeClick -Element $Element
            
            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 0 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Driver $Driver -Id 'btn'
            Invoke-SeClick -Element $Button

            (Find-SeElement -Driver $Driver -Id 'innerOutput2').Text | should be "1"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}