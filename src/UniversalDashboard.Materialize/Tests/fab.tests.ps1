Describe "Fab" {
    Context "Fab with buttons" {
        Set-TestDashboard {

            New-UDElement -Id "Output" -Tag "div"

            New-UdFab -Id "main" -Icon "plus" -Size "large" -ButtonColor "red" -onClick {
                State
            } -Content {
                New-UDFabButton -ButtonColor "green" -Icon "edit" -size "small"
                New-UDFabButton -Id "btn" -ButtonColor "yellow" -Icon "trash" -size "large" -onClick {

                    Add-UDElement -ParentId 'Output' -Content {
                        New-UDElement -Tag 'div' -Id 'ChildOutput' -Content { 'Child '}
                    }
                }
            }
        }

        It "should handle clicks" {
            $Element = Find-SeElement -Driver $Driver -Id 'main'
            $Element | Invoke-SeClick

            $Element = Find-SeElement -Driver $Driver -Id 'MainOutput'
            $Element.Text | should be "main"

            $Element = Find-SeElement -Driver $Driver -Id 'btn'
            $Element | Invoke-SeClick

            $Element = Find-SeElement -Driver $Driver -Id 'ChildOutput'
            $Element.Text | should be "Child"
        }
    }

}