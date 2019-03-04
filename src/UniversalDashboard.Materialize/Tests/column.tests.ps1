Describe "New-UDColumn" {
    Context "Small Size" {
        Set-TestDashboard {
            New-UDColumn -SmallSize 12
        }

        It "has a small size" {
            Find-SeElement -ClassName "s12" -Driver $Driver | should not be $null
        }
    }

    Context "Medium Size" {
        Set-TestDashboard {
            New-UDColumn -MediumSize 12
        }

        It "has a medium size" {
            Find-SeElement -ClassName "m12" -Driver $Driver | should not be $null
        }
    }

    Context "Large Size" {
        Set-TestDashboard {
            New-UDColumn -LargeSize 12
        }

        It "has a large size" {
            Find-SeElement -ClassName "l12" -Driver $Driver | should not be $null
        }
    }

    Context "Small Offset" {
        Set-TestDashboard {
            New-UDColumn -SmallOffset 6
        }

        It "has a small size" {
            Find-SeElement -ClassName "offset-s6" -Driver $Driver | should not be $null
        }
    }

    Context "Medium Offset" {
        Set-TestDashboard {
            New-UDColumn -MediumOffset 6
        }

        It "has a medium offset" {
            Find-SeElement -ClassName "offset-m6" -Driver $Driver | should not be $null
        }
    }

    Context "Large Offset" {
        Set-TestDashboard {
            New-UDColumn -LargeOffset 6
        }

        It "has a large offset" {
            Find-SeElement -ClassName "offset-l6" -Driver $Driver | should not be $null
        }
    }

    Context "Small Size Alias" {
        Set-TestDashboard {
            New-UDColumn -Size 12
        }

        It "has a small size" {
            Find-SeElement -ClassName "s12" -Driver $Driver | should not be $null
        }
    }

    Context "sets id" {
        Set-TestDashboard {
            New-UDColumn -Id "myCol"
        }

        It "has id" {
            Find-SeElement -Id "myCol" -Driver $Driver | should not be $null
        }
    }

    Context "content" {
        Set-TestDashboard {
            New-UDColumn -Content {
                New-UDCard -Id "card"
            }
        }

        It "has content" {
            Find-SeElement -Id "card" -Driver $Driver | should not be $null
        }
    }

    Context "endpoint" {
        Set-TestDashboard {
            New-UDColumn -Endpoint {
                New-UDCard -Id "card"
            }
        }

        It "has content from endpoint" {
            Find-SeElement -Id "card" -Driver $Driver | should not be $null
        }
    }
}