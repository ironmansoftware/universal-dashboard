Enter-SeUrl -Url "$Address/Test/Preloader" -Target $Driver

Describe "New-UDPreloader" {
    It 'should be indeterminate' {
        Find-SeElement -ClassName 'progress'-Driver $Driver | Should not be $null
    }
}