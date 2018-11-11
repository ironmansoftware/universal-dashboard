param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Dashboard" {
    Context "Initialization Script" {

        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            $TitleVariable = "Title"
            function Get-ContentForCard {
                "Body"
            }    
            $Init = New-UDEndpointInitialization -Variable "TitleVariable" -Function "Get-ContentForCard"
    
            New-UDDashboard -Title "Test" -Content {
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
        ))') -SessionVariable ss -ContentType 'text/plain'

        $Cache:Driver.navigate().refresh()

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card2" -Driver $Cache:Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card3" -Driver $Cache:Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"
        }

        It "should load javascript" {
            $Item = (Find-SeElement -TagName "script" -Driver $Cache:Driver ).GetAttribute("src") | Where { $_ -eq 'https://unpkg.com/leaflet@1.3.1/dist/leaflet.js' } 
            $Item | Should not be $null
        }
    }

    Context "Update dashboard" {

        $dashboard = New-UDDashboard -Title "Test" -Content {
        } 

        $Server = Start-UDDashboard -Port 10005 -Name 'D5' -Dashboard $dashboard -UpdateToken "UpdateToken"

        Update-UDDashboard -UpdateToken "UpdateToken" -Url "http://localhost:10005" -Content {
            New-UDDashboard -Title "Test" -Content {
                New-UDElement -Tag 'div' -Id 'test'       
            }
        }

        It "updates the dashboard" {
            Find-SeElement -Driver $Cache:Driver -Id 'test' | Should not be $null
        }

        Stop-UDDashboard -Name 'D5'
    }
}