Describe "Fab" {
    Context "Fab with buttons" {
        Set-TestDashboard {

            New-UDElement -Id "Output" -Tag "div"

            New-UdFab -Id "main" -Icon "plus" -Size "large" -ButtonColor "red" -onClick {
                Set-TestData -Data "parent"
            } -Content {
                New-UDFabButton -ButtonColor "green" -Icon "edit" -size "small"
                New-UDFabButton -Id "btn" -ButtonColor "yellow" -Icon "trash" -size "large" -onClick {
                    Set-TestData -Data "child"
                }
            }
        }

        It "should handle clicks" {
            $Element = Find-SeElement -Driver $Driver -Id 'main'
            $Element | Invoke-SeClick -JavascriptClick -Driver $Driver

            Get-TestData | should be "parent"

            $Element = Find-SeElement -Driver $Driver -Id 'btn'
            $Element | Invoke-SeClick -JavascriptClick -Driver $Driver

            Get-TestData | should be "child"
        }
    }

}