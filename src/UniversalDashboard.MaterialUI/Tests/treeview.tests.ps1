Enter-SeUrl -Target $Driver -Url "http://localhost:10000/treeview"

Describe "Textbox" {
    It 'has nodes' {
        Find-SeElement -Id 'Root' -Driver $Driver | Invoke-SeClick 
        Find-SeElement -Id 'Level1' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'Level2' -Driver $Driver | should not be $null
    }
}