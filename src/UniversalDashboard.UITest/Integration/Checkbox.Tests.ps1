param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Checkbox" {
    Context "OnChange" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCheckbox -Id "Test" -Label "Check me" -OnChange {

                $val = "NotChecked"
                if ($EventData) {
                    $Val = "Checked"
                }

                Set-UDElement -Id "output" -Content { $val }
            }

            New-UDElement -Id "output" -Tag "div" -Content { }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should check item" {
            $Element = Find-SeElement -Id 'Test' -Driver $Driver 
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver
            Start-Sleep 1
 
            (Find-SeElement -Driver $Driver -Id 'output').Text | should be "Checked"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}