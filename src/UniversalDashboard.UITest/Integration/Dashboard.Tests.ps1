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

Describe "Dashboard" {
    Context "Initialization Script" {
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
        } -EndpointInitializationScript {
            $TitleVariable = "Title"
            function Get-ContentForCard {
                "Body"
            }
        } -Scripts "https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"

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