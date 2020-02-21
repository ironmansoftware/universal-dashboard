. "$PSScriptRoot\..\TestFramework.ps1"

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
        Import-Module "$PSScriptRoot\TestModule.psm1"

        $dashboard = New-UDDashboard -Title "Test" -Content {} 
        Start-UDDashboard -Force -Port 10001 -Dashboard $dashboard -Endpoint @(
            New-UDEndpoint -Url '/module1_a' -Endpoint {
                Get-Number 
            }
            New-UDEndpoint -Url "/variable_a" -Endpoint {
                $SomeVar123
            }
            New-UDEndpoint -Url "/function_a" -Endpoint {
                Get-Stuff
            }
            New-UDEndpoint -Url "/module2_a" -Endpoint {
                Get-TheMeaningOfLife
            }
        )

        It "should load module from temp dir" {
            Invoke-RestMethod "http://localhost:10001/api/module1_a" | Should be "10"
        }

        It "should have variable defined" {
            Invoke-RestMethod "http://localhost:10001/api/variable_a" | Should be "This is a value"
        }

        It "should have function defined" {
            Invoke-RestMethod "http://localhost:10001/api/function_a" | Should be "999"
        }

        It "should load module from relative path" {
            Invoke-RestMethod "http://localhost:10001/api/module2_a" | Should be "42"
        }

        Remove-Item $tempModule -Force        
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
        
        Start-UDDashboard -Force -Port 10001 -Dashboard $dashboard -Endpoint @(
            New-UDEndpoint -Url '/module1_b' -Endpoint {
                Get-Number 
            }
            New-UDEndpoint -Url "/variable_b" -Endpoint {
                $SomeVar123
            }
            New-UDEndpoint -Url "/function_b" -Endpoint {
                Get-Stuff
            }
            New-UDEndpoint -Url "/module2_b" -Endpoint {
                Get-TheMeaningOfLife
            }
            New-UDEndpoint -Url "/notfound_b" -Endpoint {
                Get-NoStuff
            }
        )

        It "should load module from temp dir" {
            Invoke-RestMethod "http://localhost:10001/api/module1_b" | Should be "10"
        }

        It "should have variable defined" {
            Invoke-RestMethod "http://localhost:10001/api/variable_b" | Should be "This is a value"
        }

        It "should have function defined" {
            Invoke-RestMethod "http://localhost:10001/api/function_b" | Should be "999"
        }

        It "should load module from relative path" {
            Invoke-RestMethod "http://localhost:10001/api/module2_b" | Should be "42"
        }

        It "should not load function" {
            Invoke-RestMethod "http://localhost:10001/api/notfound_b" | Should not be 101
        }

        Remove-Item $tempModule -Force
    }
}

Pop-Location