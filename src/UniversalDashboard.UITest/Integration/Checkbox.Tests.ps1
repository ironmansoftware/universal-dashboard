param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Checkbox" {
    Context "OnChange" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDCheckbox -Id "Test" -Label "Check me" -OnChange {

                $val = "NotChecked"
                if ($EventData) {
                    $Val = "Checked"
                }

                Add-UDElement -ParentId "output" -Content {
                    New-UDElement -Id "child" -Tag "div" -Content { $val }
                }
            }

            New-UDElement -Id "output" -Tag "div" -Content { }
        }))') -SessionVariable ss -ContentType 'text/plain'

        $Cache:Driver.navigate().refresh()

        It "should check item" {
            $Element = Find-SeElement -Id 'Test' -Driver $Cache:Driver 
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Cache:Driver
            Start-Sleep 1
 
            (Find-SeElement -Driver $Cache:Driver -Id 'child').Text | should be "Checked"
        }
    }
}