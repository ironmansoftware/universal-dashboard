Describe "New-UDLayout" {
    Context "3 columns" {
        Set-TestDashboard -Content {
            New-UDLayout -Columns 3 -Content {
                New-UDCard -Title "Test" -Content {}
                New-UDCard -Title "Test" -Content {}
                New-UDCard -Title "Test" -Content {}
                New-UDCard -Title "Test" -Content {}
            }
        }

        It "should have 2 rows and 4 columns" {
            (Find-SeElement -ClassName 'row' -Driver $Driver).Count | Should be 2
            (Find-SeElement -ClassName 'col' -Driver $Driver).Count | Should be 4
        }
    }
}