param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1"

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}
Get-UDDashboard | Stop-UDDashboard
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
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 6 -Content {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString())
                }
            }
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        #Open firefox
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "Should not change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText = $Card.Text

            Start-Sleep 2

            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText2 = $Card.Text

            $CardText | Should be $CardText2
        }
        
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Dynamic Columns" {
        #Create a dashboard to test
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -AutoRefresh -RefreshInterval 1 -Size 6 -Endpoint {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString()) 
                }
            }
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        #Open firefox
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "Should change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText = $Card.Text

            Start-Sleep 3

            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText2 = $Card.Text

            $CardText | Should not be $CardText2
        }
        
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Static Row"{
        #Create a dashboard to test
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 6 -Content {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString())
                }
            }
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        #Open firefox
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "Should not change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText = $Card.Text

            Start-Sleep 2

            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText2 = $Card.Text

            $CardText | Should be $CardText2
        }
        
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Dynamic Row" {
        #Create a dashboard to test
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -AutoRefresh -RefreshInterval 1 -Endpoint {
                New-UDColumn -Size 6 -Content {
                    New-UDCard -Id "Card" -Title ((Get-Date).ToString())
                }
            }
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        #Open firefox
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "Should change value" {
            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText = $Card.Text

            Start-Sleep 3

            $Card = Find-SeElement -Id "Card" -Driver $Driver
            $CardText2 = $Card.Text

            $CardText | Should not be $CardText2
        }
        
       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

    
}