Describe "Fab" {
    Context "Fab with buttons" {
        Set-TestDashboard {
            New-UdFab -Id "main" -Icon "plus" -Size "large" -ButtonColor "red" -onClick {
                Set-TestData -Data "parent"
                Show-UDToast -Message "Parent"
            } -Content {
                New-UDFabButton -ButtonColor "green" -Icon "edit" -size "small"
                New-UDFabButton -Id "btn" -ButtonColor "yellow" -Icon "trash" -size "large" -onClick {
                    Set-TestData -Data "child"
                    Show-UDToast -Message "Child"
                }
            }
        }

        It "should handle clicks" {
            $Element = Find-SeElement -Driver $Driver -Id 'main'
            $Element | Invoke-SeClick 

            Get-TestData | should be "parent"

            Start-Sleep 1

            $Element = Find-SeElement -Driver $Driver -Id 'btn'
            $Element | Invoke-SeClick -JavascriptClick -Driver $Driver

            Get-TestData | should be "child"
        }
    }
}