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

    Context "Should set mobile friendly column sizes" {
        $Layout = New-UDLayout -Columns 3 -Content {
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
        }

        it "should contain all sizes" {
            $Layout[0].Content[0].Attributes["className"].Contains("s12") | should be $true
            $Layout[0].Content[0].Attributes["className"].Contains("m8") | should be $true
            $Layout[0].Content[0].Attributes["className"].Contains("l4") | should be $true
        }

    }

    Context "should not show error when column set to 1" {
        $Layout = New-UDLayout -Columns 1 -Content {
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
        }

        it "should contain all sizes" {
            $Layout[0].Content[0].Attributes["className"].Contains("s12") | should be $true
            $Layout[0].Content[0].Attributes["className"].Contains("m12") | should be $true
            $Layout[0].Content[0].Attributes["className"].Contains("l12") | should be $true
        }
    }
}