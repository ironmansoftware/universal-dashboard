param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Push-Location $PSScriptRoot

Get-UDDashboard | Stop-UDDashboard
Describe "EndpointInitialization" {

    Context "Autoload" {


        function Get-Stuff {
            999
        }

        $SomeVar123 = "This is a value"

        $tempModule = [IO.Path]::GetTempFileName() + ".psm1"

        {
            function Get-Number {
                10
            }
        }.ToString() | Out-File -FilePath $tempModule

        Import-Module $tempModule
        Import-Module ".\TestModule.psm1"

        $dashboard = New-UDDashboard -Title "Test" -Content {} 
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -Endpoint @(
            New-UDEndpoint -Url '/module1' -Endpoint {
                Get-Number 
            }
            New-UDEndpoint -Url "/variable" -Endpoint {
                $SomeVar123
            }
            New-UDEndpoint -Url "/function" -Endpoint {
                Get-Stuff
            }
            New-UDEndpoint -Url "/module2" -Endpoint {
                Get-TheMeaningOfLife
            }
        )

        It "should load module from temp dir" {
            Invoke-RestMethod "http://localhost:10001/api/module1" | Should be "10"
        }

        It "should have variable defined" {
            Invoke-RestMethod "http://localhost:10001/api/variable" | Should be "This is a value"
        }

        It "should have function defined" {
            Invoke-RestMethod "http://localhost:10001/api/function" | Should be "999"
        }

        It "should load module from relative path" {
            Invoke-RestMethod "http://localhost:10001/api/module2" | Should be "42"
        }

        Remove-Item $tempModule -Force
        Stop-UDDashboard -Server $Server 

        
    }

    Context "Variables" {

        function Get-Stuff {
            999
        }

        function Get-NoStuff {
            101
        }

        $SomeVar123 = "This is a value"

        $tempModule = [IO.Path]::GetTempFileName() + ".psm1"

        {
            function Get-Number {
                10
            }
        }.ToString() | Out-File -FilePath $tempModule

        $Initialization = New-UDEndpointInitialization -Module @($tempModule, ".\TestModule.psm1") -Variable "SomeVar123" -Function 'Get-Stuff'

        $dashboard = New-UDDashboard -Title "Test" -Content {} -EndpointInitialization $Initialization
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -Endpoint @(
            New-UDEndpoint -Url '/module1' -Endpoint {
                Get-Number 
            }
            New-UDEndpoint -Url "/variable" -Endpoint {
                $SomeVar123
            }
            New-UDEndpoint -Url "/function" -Endpoint {
                Get-Stuff
            }
            New-UDEndpoint -Url "/module2" -Endpoint {
                Get-TheMeaningOfLife
            }
            New-UDEndpoint -Url "/notfound" -Endpoint {
                Get-NoStuff
            }
        )

        It "should load module from temp dir" {
            Invoke-RestMethod "http://localhost:10001/api/module1" | Should be "10"
        }

        It "should have variable defined" {
            Invoke-RestMethod "http://localhost:10001/api/variable" | Should be "This is a value"
        }

        It "should have function defined" {
            Invoke-RestMethod "http://localhost:10001/api/function" | Should be "999"
        }

        It "should load module from relative path" {
            Invoke-RestMethod "http://localhost:10001/api/module2" | Should be "42"
        }

        It "should not load function" {
            Invoke-RestMethod "http://localhost:10001/api/notfound" | Should not be 101
        }

        Remove-Item $tempModule -Force
        Stop-UDDashboard -Server $Server 
    }
}

Pop-Location