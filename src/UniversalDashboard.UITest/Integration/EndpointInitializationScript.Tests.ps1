param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "EndpointInitializationScript" {
    Context "Variables" {

        $tempModule = [IO.Path]::GetTempFileName() + ".psm1"

        {
            function Get-Number {
                10
            }
        }.ToString() | Out-File -FilePath $tempModule

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                Get-Number 
            }
        } -EndpointInitializationScript {
            Import-Module $tempModule
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 3

        It "should load module from temp dir" {
            $Target = Find-SeElement -Driver $Driver -Id "Counter"
            $Target.Text | Should be "Counter`r`n10" 
        }

        Remove-Item $tempModule -Force
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}