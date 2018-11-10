param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Design" {
    Context "Design Terminal" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag 'div' -Id 'parent'
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -Design
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should execute command in design console" {
            $Element = Find-SeElement -Driver $Driver -Id 'btnDesignTerminal'
            $Element | Invoke-SeClick

            $Input = Find-SeElement -Driver $Driver -ClassName 'sc-iwsKbI'
            Send-SeKeys -Element $Input -Keys 'Add-UDElement -ParentId parent -Content { New-UDElement -Id "test" -Tag "div" -Content {} }'
            Send-SeKeys -Element $Input -Keys ([OpenQA.Selenium.Keys]::Return)

            Find-SeElement -Driver $Driver -Id 'test' | Should not be $null
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

}