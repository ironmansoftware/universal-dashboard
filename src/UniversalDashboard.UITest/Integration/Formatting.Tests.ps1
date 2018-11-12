param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Describe "Formatting" {
    Context "Layout" {
        It "returns correct number of rows and columns" {
            $Layout = New-UDLayout -Columns 2 -Content {
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
            }

            $Layout.Length | Should be 2
            $Layout[0].Content.Length | Should be 2
            $Layout[1].Content.Length | Should be 2
        }

        It "returns correct number of rows and columns 2" {
            $Layout = New-UDLayout -Columns 2 -Content {
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
            }

            $Layout.Length | Should be 2
            $Layout[0].Content.Length | Should be 2
            $Layout[1].Content.Length | Should be 1
        }

        It "returns correct number of rows and columns 3" {
            $Layout = New-UDLayout -Columns 5 -Content {
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
            }

            $Layout.Length | Should be 1
            $Layout[0].Content.Length | Should be 5
        }

        It "returns correct number of rows and columns 4" {
            $Layout = New-UDLayout -Columns 5 -Content {
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
                New-UDElement -Tag "span"
            }

            $Layout.Length | Should be 2
            $Layout[0].Content.Length | Should be 5
            $Layout[1].Content.Length | Should be 1
        }
    }

    Context "Static Columns"{
        #Create a dashboard to test
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 6 -Content {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString())
                }
            }
        }))') -SessionVariable ss -ContentType "text/plain"
        
        $Cache:Driver.navigate().refresh()

        It "Should not change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText = $Card.Text

            Start-Sleep 2

            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText2 = $Card.Text

            $CardText | Should be $CardText2
        }
    }

    Context "Dynamic Columns" {
        #Create a dashboard to test
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -AutoRefresh -RefreshInterval 1 -Size 6 -Endpoint {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString()) 
                }
            }
        }))') -SessionVariable ss -ContentType "text/plain"
        
        $Cache:Driver.navigate().refresh()

        It "Should change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText = $Card.Text

            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText2 = $Card.Text

            $CardText | Should not be $CardText2
        }
    }

    Context "Static Row"{
        #Create a dashboard to test
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 6 -Content {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString())
                }
            }
        }))') -SessionVariable ss -ContentType "text/plain"
        
        $Cache:Driver.navigate().refresh()
        
        It "Should not change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText = $Card.Text

            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText2 = $Card.Text

            $CardText | Should be $CardText2
        }
    }

    Context "Dynamic Row" {
        #Create a dashboard to test
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDRow -AutoRefresh -RefreshInterval 1 -Endpoint {
                New-UDColumn -Size 6 -Content {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString())
                }
            }
        }))') -SessionVariable ss -ContentType "text/plain"
        
        $Cache:Driver.navigate().refresh()
        
        It "Should change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText = $Card.Text

            Start-Sleep 3

            $Card = Find-SeElement -Id "Card" -Driver $Cache:Driver
            $CardText2 = $Card.Text

            $CardText | Should not be $CardText2
        }
    }   
}