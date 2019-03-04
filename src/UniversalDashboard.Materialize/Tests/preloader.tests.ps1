Describe "New-UDPreloader" {
    Context "indeterminate" {
        Set-TestDashboard -Content {
            New-UDPreloader
        }

        It 'should be indeterminate' {
            Find-SeElement -ClassName 'progress'-Driver $Driver | Should not be $null
        }
    }
}