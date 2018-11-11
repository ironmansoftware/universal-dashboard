param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Design" {
    Context "Design Terminal" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag "div" -Id "parent"
        }))') -SessionVariable ss -ContentType 'text/plain'

        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.Dashboard.design = $true') -SessionVariable ss -ContentType 'text/plain'

        $Cache:Driver.navigate().refresh()

        It "should execute command in design console" {
            $Element = Find-SeElement -Driver $Cache:Driver -Id 'btnDesignTerminal'
            $Element | Invoke-SeClick

            $Text = Find-SeElement -Driver $Cache:Driver -ClassName 'sc-iwsKbI'
            Send-SeKeys -Element $Text -Keys 'Add-UDElement -ParentId parent -Content { New-UDElement -Id "test" -Tag "div" -Content {} }'
            Send-SeKeys -Element $Text -Keys ([OpenQA.Selenium.Keys]::Return)

            Find-SeElement -Driver $Cache:Driver -Id 'test' | Should not be $null
        }
    }
}