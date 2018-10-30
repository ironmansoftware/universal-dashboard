param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

$Global:MyVariable = "Test"

Describe "Variable Scoping" {
    Context "Invoke-Command test" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDButton -Text 'Patch' -Id 'button' -OnClick (
                New-UDEndpoint -Endpoint { 
                    Add-UDElement -ParentId 'output' -Content {
                        New-UDElement -Id 'child' -Tag 'div' -Content { 'child'}
                    }
                 } -ArgumentList $Name
            )

            New-UDElement -Tag 'div' -Id "output" -Content {
                
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $Dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should start processes with click" {
            Find-SeElement -Id "button" -Driver $Driver | Invoke-SeClick 
            (Find-SeElement -Id 'child' -Driver $Driver).Text | should be "child"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard $Server
    }

    Context "Variable set global" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Id "element" -Endpoint {
                $MyVariable
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
                        Stop = New-UDButton -Id "btn$($_.Id)" -Text "Stop" -OnClick (
                            New-UDEndpoint -Endpoint {
                                Stop-Process $ArgumentList[0]
                            } -ArgumentList $_
                        ) 
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