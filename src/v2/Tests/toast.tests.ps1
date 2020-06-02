Enter-SeUrl "$Address/Test/Toast" -Target $Driver

Describe 'toast' {
    It "should show toast icon" {
        Find-SeElement -Id 'button' -Target $Driver | Invoke-SeClick 
        Find-SeElement -Id 'Toast' -Target $Driver
    }
}