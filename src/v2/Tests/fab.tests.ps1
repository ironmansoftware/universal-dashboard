Enter-SeUrl -Url "$Address/test/fab" -Target $Driver

Describe "Fab" {
    Context "Fab with buttons" {
        It "should handle clicks" {
            $Element = Find-SeElement -Driver $Driver -Id 'main'
            $Element | Invoke-SeClick 

            Get-TestData | should be "parent"

            Start-Sleep 1

            $Element = Find-SeElement -Driver $Driver -Id 'btn'
            $Element | Invoke-SeClick -JavascriptClick -Driver $Driver

            Get-TestData | should be "child"
        }
    }
}