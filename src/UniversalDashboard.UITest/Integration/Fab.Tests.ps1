param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Fab" {
    Context "Fab with buttons" {
        $dashboard = New-UDDashboard -Title "Test" -Content {

            New-UDElement -Id "Output" -Tag "div"

            New-UdFab -Id "main" -Icon "plus" -Size "large" -ButtonColor "red" -onClick {
                Set-UDElement -Id "Output" -Content { "Main" }
            } -Content {
                New-UDFabButton -ButtonColor "green" -Icon "edit" -size "small"
                New-UDFabButton -Id "btn" -ButtonColor "yellow" -Icon "trash" -size "large" -onClick {
                    Set-UDElement -Id "Output" -Content { "Child" }
                }
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should handle clicks" {
            $Element = Find-SeElement -Driver $Driver -Id 'main'
            $Element | Invoke-SeClick

            Start-Sleep 2

            $Element = Find-SeElement -Driver $Driver -Id 'Output'
            $Element.Text | should be "main"

            $Element = Find-SeElement -Driver $Driver -Id 'btn'
            $Element | Invoke-SeClick

            Start-Sleep 2

            $Element = Find-SeElement -Driver $Driver -Id 'Output'
            $Element.Text | should be "Child"
        }

      # Stop-SeDriver $Driver
      # Stop-UDDashboard -Server $Server 
    }

}