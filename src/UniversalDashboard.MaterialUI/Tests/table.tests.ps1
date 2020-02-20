Enter-SeUrl -Target $Driver -Url "http://localhost:10000/table"

Describe "Table" {
    It 'has content' {
        $Element = Find-SeElement -Id 'Tab1' -Driver $Driver | Invoke-SeClick 
    }
}