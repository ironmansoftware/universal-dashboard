param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force
Describe "Forms" {
    Context "Forms" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDTextbox -Label "Click me" -Id "txtBox"
            New-UDSelect -Label "Select me" -Id "select" -Option {
                New-UDSelectOption -Name "test1" -Value 1
                New-UDSelectOption -Name "test2" -Value 2
                New-UDSelectOption -Name "test3" -Value 3
                New-UDSelectOption -Name "test4" -Value 4
            } -OnChange {
                $Cache:SelectData = $EventData
            }

            New-UDCounter -Title "Select" -Id "SelectValue" -Endpoint {
                $Cache:SelectData 
            } -AutoRefresh -RefreshInterval 1
        }))') -SessionVariable ss -ContentType "text/plain"

        $Cache:Driver.navigate().refresh()

        It "should have title text" {
            $Element = Find-SeElement -Id "txtBox" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys 'hey'
        }
    }
}