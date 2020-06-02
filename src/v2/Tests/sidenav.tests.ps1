Enter-SeUrl -Url "$Address/Test/Switch" -Target $Driver

Describe "New-UDSideNav" {
    It "should have a side nav" {
        Find-SeElement -Id 'sideNav1' -Target $Driver | should not be $null
        Find-SeElement -Id 'sideNav2' -Target $Driver | should not be $null
        Find-SeElement -Id 'sideNav3' -Target $Driver | should not be $null
        Find-SeElement -Id 'sideNav4' -Target $Driver | should not be $null
    }
}