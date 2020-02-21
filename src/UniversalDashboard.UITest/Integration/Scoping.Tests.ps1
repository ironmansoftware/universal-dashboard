
. "$PSScriptRoot\..\TestFramework.ps1"

$Global:MyVariable = "Test"

Describe "Variable Scoping" {

    Context "Variable set for session variable" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Endpoint {
                $Session:SessionId = $SessionID

                New-UDElement -Tag 'div' -Id "output" -Endpoint {
                    $Session:SessionId
                }          
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-sleep 2

        It "should read session id from session variable" {
            (Find-SeElement -Id 'output' -Driver $Driver).Text | should not be ""
        }
    }

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

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should start processes with click" {
            Find-SeElement -Id "button" -Driver $Driver | Invoke-SeClick 
            (Find-SeElement -Id 'child' -Driver $Driver).Text | should be "child"
        }
    }

    Context "Variable set global" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Id "element" -Endpoint {
                $MyVariable
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should return global variable" {
            (Invoke-RestMethod http://localhost:10001/api/internal/component/element/element) | should be "Test"
        }
    }

    Context "Variable set local variable" {

        $variable = "localVariable"

        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Id "element" -Endpoint {
                $variable
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should return local variable" {
            (Invoke-RestMethod http://localhost:10001/api/internal/component/element/element) | should be "localVariable"
        }
    }
    
    Context "Variable set loop variable" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {

            1..5 | ForEach-Object {
                New-UDElement -Tag "div" -Id "element$_" -Endpoint {
                    $_
                }
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should return loop variable" {
            1..5 | ForEach-Object {
                (Invoke-RestMethod "http://localhost:10001/api/internal/component/element/element$_") | should be $_
            }
            
        }
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

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

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
    }
}