param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
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

        $Initialization = New-UDEndpointInitialization -Module $tempModule -Variable "SomeVar" -Function 'Get-Stuff'

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                Get-Number 
            }

            New-UDElement -tag "div" -Id "variable" -Content {
                $SomeVar
            }

            New-UDElement -tag "div" -Id "function" -Content {
                Get-Stuff
            }
        } -EndpointInitialization $Initialization
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 3

        It "should load module from temp dir" {
            $Target = Find-SeElement -Driver $Driver -Id "Counter"
            $Target.Text | Should be "Counter`r`n10" 
        }

        It "should have variable defined" {
            $Target = Find-SeElement -Driver $Driver -Id "variable"
            $Target.Text | Should be "This is a value" 
        }

        It "should have function defined" {
            $Target = Find-SeElement -Driver $Driver -Id "function"
            $Target.Text | Should be "999" 
        }

        Remove-Item $tempModule -Force
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}