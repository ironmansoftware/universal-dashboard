param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Dashboard" {
    Context "Initialization Script" {

        $TitleVariable = "Title"
        function Get-ContentForCard {
            "Body"
        }

        $Init = New-UDEndpointInitialization -Variable "TitleVariable" -Function "Get-ContentForCard"

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 12 -Endpoint {
                    New-UDCard -Title $TitleVariable -Text (Get-ContentForCard) -Id "Card" 
                }
                New-UDColumn -Size 12 -Endpoint {
                    New-UDCard -Title $TitleVariable -Text (Get-ContentForCard) -Id "Card2" 
                }
                New-UDColumn -Size 12 -Endpoint {
                    New-UDCard -Title $TitleVariable -Text (Get-ContentForCard) -Id "Card3" 
                }
            } 
        } -EndpointInitialization $Init -Scripts "https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card2" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card3" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"
        }

        It "should load javascript" {
            (Find-SeElement -TagName "script" -Driver $Driver ).GetAttribute("src") | should be "https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}