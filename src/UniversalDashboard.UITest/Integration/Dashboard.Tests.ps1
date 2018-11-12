param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Dashboard" {
    Context "Initialization Script" {

        function Get-ContentForCard{"Body"}
        $init = New-UDEndpointInitialization -Function "Get-ContentForCard"
        $dashboard = New-UDDashboard -Title "Test" -Content {
                New-UDRow -Columns {
                    New-UDColumn -Size 12 -Endpoint {
                        New-UDCard -Title Title -Text (Get-ContentForCard) -Id "Card" 
                    }
                    New-UDColumn -Size 12 -Endpoint {
                        New-UDCard -Title Title -Text (Get-ContentForCard) -Id "Card2" 
                    }
                    New-UDColumn -Size 12 -Endpoint {
                        New-UDCard -Title Title -Text (Get-ContentForCard) -Id "Card3" 
                    }
                } 
            } -EndpointInitialization $init -Scripts "https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"

        Start-UDDashboard -Dashboard $dashboard -Port 10005 -Name 'D5Init'
        $TempDriver = Start-SeFirefox
        Enter-SeUrl -Driver $TempDriver -Url "http://localhost:10005"

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $TempDriver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card2" -Driver $TempDriver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card3" -Driver $TempDriver
            $Element.Text.Split("`r`n")[0] | should be "Title"
        }

        It "should load javascript" {
            [bool]((Find-SeElement -TagName "script" -Driver $TempDriver ).GetAttribute("src") -match 'https://unpkg.com/leaflet@1.3.1/dist/leaflet.js') | Should Be $true        
        }

        Stop-SeDriver -Driver $TempDriver
        Stop-UDDashboard -Name 'D5Init'
    }

    Context "Update dashboard" {

        $dashboard = New-UDDashboard -Title "Test" -Content {} 
        $TempDriver = Start-SeFirefox
        Enter-SeUrl -Driver $TempDriver -Url "http://localhost:10005"

        $Server = Start-UDDashboard -Port 10005 -Name 'D5' -Dashboard $dashboard -UpdateToken "UpdateToken"

        Update-UDDashboard -UpdateToken "UpdateToken" -Url "http://localhost:10005" -Content {
            New-UDDashboard -Title "Test" -Content {
                New-UDElement -Tag 'div' -Id 'test'       
            }
        }

        It "updates the dashboard" {
            Find-SeElement -Driver $TempDriver -Id 'test' | Should not be $null
        }

        Stop-SeDriver -Driver $TempDriver
        Stop-UDDashboard -Name 'D5'
    }
}