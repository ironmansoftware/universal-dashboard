param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Describe "Fab" {
    Context "Fab with buttons" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {

            New-UDElement -Id "Output" -Tag "div"

            New-UdFab -Id "main" -Icon "plus" -Size "large" -ButtonColor "red" -onClick {

                Add-UDElement -ParentId "Output" -Content {
                    New-UDElement -Tag "div" -Id "MainOutput" -Content { "Main "}
                }
            } -Content {
                New-UDFabButton -ButtonColor "green" -Icon "edit" -size "small"
                New-UDFabButton -Id "btn" -ButtonColor "yellow" -Icon "trash" -size "large" -onClick {

                    Add-UDElement -ParentId "Output" -Content {
                        New-UDElement -Tag "div" -Id "ChildOutput" -Content { "Child "}
                    }
                }
            }
        }))') -SessionVariable ss -ContentType "text/plain"

        $Cache:Driver.navigate().refresh()

        It "should handle clicks" {
            $Element = Find-SeElement -Driver $Cache:Driver -Id 'main'
            $Element | Invoke-SeClick

            $Element = Find-SeElement -Driver $Cache:Driver -Id 'MainOutput'
            $Element.Text | should be "main"

            $Element = Find-SeElement -Driver $Cache:Driver -Id 'btn'
            $Element | Invoke-SeClick

            $Element = Find-SeElement -Driver $Cache:Driver -Id 'ChildOutput'
            $Element.Text | should be "Child"
        }
    }
}