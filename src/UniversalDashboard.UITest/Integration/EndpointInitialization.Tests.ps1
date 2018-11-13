param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "EndpointInitialization" {
    Context "Variables" {

        function Get-Stuff {
            999
        }

        $SomeVar = "This is a value"

        $tempModule = [IO.Path]::GetTempFileName() + ".psm1"

        {
            function Get-Number {
                10
            }
        }.ToString() | Out-File -FilePath $tempModule

        $Initialization = New-UDEndpointInitialization -Module @($tempModule, ".\TestModule.psm1") -Variable "SomeVar" -Function 'Get-Stuff'

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                Get-Number 
            }

            New-UDElement -tag "div" -Endpoint {
                New-UDElement -tag "div" -Id "variable" -Content { $SomeVar }
            }

            New-UDElement -tag "div" -Id "function" -Endpoint {
                Get-Stuff
            }

            New-UDElement -tag "div" -Id "othermodule" -Endpoint {
                Get-TheMeaningOfLife
            }

        } -EndpointInitialization $Initialization
        Stop-UDDashboard -Port 10005
        $Server = Start-UDDashboard -Port 10005 -Dashboard $dashboard 
        $TempDriver = Start-SeFirefox
        Enter-SeUrl -Driver $TempDriver -Url "http://localhost:10005"

        It "should load module from temp dir" {
            $Target = Find-SeElement -Driver $TempDriver -Id "Counter"
            $Target.Text | Should be "Counter`r`n10" 
        }

        It "should have variable defined" {
            $Target = Find-SeElement -Driver $TempDriver -Id "variable"
            $Target.Text | Should be "This is a value" 
        }

        It "should have function defined" {
            $Target = Find-SeElement -Driver $TempDriver -Id "function"
            $Target.Text | Should be "999" 
        }

        It "should load module from relative path" {
            $Target = Find-SeElement -Driver $TempDriver -Id "othermodule"
            $Target.Text | Should be "42" 
        }

        Remove-Item $tempModule -Force
        Stop-SeDriver $TempDriver
        Stop-UDDashboard -Server $Server 
    }
}