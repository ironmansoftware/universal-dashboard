Enter-SeUrl -Url "$Address/Test/Layout" -Target $Driver
Describe "New-UDLayout" {
    It "should have 2 rows and 4 columns" {
        $Element = Find-SeElement -Id 'layout1' -Driver $Driver
        (Find-SeElement -ClassName 'row' -Target $Element).Count | Should be 2
        (Find-SeElement -ClassName 'col' -Target $Element).Count | Should be 4
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