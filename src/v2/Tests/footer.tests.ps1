Enter-SeUrl "$Address/Test" -Target $Driver

Describe "New-UDFooter" {
    It "should have footer" {
        Get-SeElement -Target $Driver -Id 'ud-footer' | should not be $null
    }
}