Enter-SeUrl -Target $Driver -Url "$Address/Test/treeview"

Describe "Textbox" {
    It 'has nodes' {
        Find-SeElement -Id 'Root' -Driver $Driver | Invoke-SeClick 
        Find-SeElement -Id 'Level1' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'Level2' -Driver $Driver | should not be $null
    }
}