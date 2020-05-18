Enter-SeUrl -Target $Driver -Url "$Address/Test/radio"

Describe "radio" {
    It 'should have all options' {
        Find-SeElement -Target $Driver -Id 'adam' | should not be $Null
        Find-SeElement -Target $Driver -Id 'alon' | should not be $Null
        Find-SeElement -Target $Driver -Id 'lee' | should not be $Null
    }

    It 'should fire onChange event' {
        Find-SeElement -Target $Driver -Id 'alonOnChange' | Invoke-SeClick
        Get-TestData | should be 'alon'
    }
}