Describe "New-UDRow" {
    Context "static content" {
        Set-TestDashboard -Content {
            New-UDRow -Columns {
                New-UDColumn -Content {
                    New-UDElement -Id "hi" -Tag "div"
                }
            }
        }

        It "should have content" {
            Find-SeElement -Id "hi" -Driver $Driver | Should not be $null
        }
    }

    Context "dynamic content" {
        Set-TestDashboard -Content {
            New-UDRow -Endpoint {
                New-UDColumn -Content {
                    New-UDElement -Id "hi" -Tag "div"
                }
            }
        }

        It "should have content" {
            Find-SeElement -Id "hi" -Driver $Driver | Should not be $null
        }
    }
}