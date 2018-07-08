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

$Global:MyVariable = "Test"

Describe "Variable Scoping" {
    Context "Invoke-Command test" {

        Get-Process calc* | Stop-Process
        
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            $Name = "localhost"
            New-UDButton -Text 'Patch' -Id 'button' -OnClick { Invoke-command -ComputerName $name -ScriptBlock { Start-Process calc }}
            write-Host $Name
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $Dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should stop processes with click" {
            Find-SeElement -Id "button" -Driver $Driver | Invoke-SeClick 

            Start-Sleep 5

            (Get-Process Calc* | Measure-Object).Count | Should be 1
        }

        Get-Process calc* | Stop-Process

        Stop-SeDriver $Driver
        Stop-UDDashboard $Server
    }

    Context "Variable set global" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Id "element" -Endpoint {
                $Global:MyVariable
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $Dashboard

        It "should return global variable" {
            (Invoke-RestMethod http://localhost:10001/component/element/element) | should be "Test"
        }

        Stop-UDDashboard $Server
    }

    Context "Variable set local variable" {

        $variable = "localVariable"

        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Id "element" -Endpoint {
                $variable
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $Dashboard

        It "should return local variable" {
            (Invoke-RestMethod http://localhost:10001/component/element/element) | should be "localVariable"
        }

        Stop-UDDashboard $Server
    }
    
    Context "Variable set loop variable" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {

            1..5 | ForEach-Object {
                New-UDElement -Tag "div" -Id "element$_" -Endpoint {
                    $_
                }
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $Dashboard

        It "should return loop variable" {
            1..5 | ForEach-Object {
                (Invoke-RestMethod "http://localhost:10001/component/element/element$_") | should be $_
            }
            
        }

        Stop-UDDashboard $Server
    }

    Context "Variable set for process" {

        1..5 | % { Start-Process Notepad }

        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDTable -Title "Processes" -Headers @("Stop") -Endpoint {
                Get-Process Notepad* | ForEach-Object {
                    [PSCustomObject]@{
                        Stop = New-UDButton -Id "btn$($_.Id)" -Text "Stop" -OnClick { 
                            Stop-Process $_ 
                        }
                    }
                } | Out-UDTableData -Property @("Stop")
            } 
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $Dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should stop processes with click" {
            Get-Process Notepad* | % {
                Find-SeElement -Id "btn$($_.Id)" -Driver $Driver | Invoke-SeClick 
            }

            (Get-Process Notepad* | Measure-Object).Count | Should be 0

            1..5 | % { Start-Process Notepad }

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 2

            Get-Process Notepad* | % {
                Find-SeElement -Id "btn$($_.Id)" -Driver $Driver | Invoke-SeClick 
            }

            (Get-Process Notepad* | Measure-Object).Count | Should be 0
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard $Server
    }

    Context "Variable set for session variable" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Endpoint {
                $Session:Variables = @("1", "2,", "3")
            }
            New-UDElement -Tag 'div' -Id "output"

            foreach($Variable in $Session:Variables) {
                New-UDButton -Text "ClickMe" -Id "btnClick$Variable" -OnClick {
                    Set-UDElement -Id "output" -Content { $Varible }
                }
            }            
        }
    }

}