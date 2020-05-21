Enter-SeUrl -Target $Driver -Url "$Address/Test/Tabs"

Describe "New-UDTabContainer" {
    It "has tabs" {
        Find-SeElement -Driver $Driver -ClassName "mdc-tab-bar" | should not be $null
    }
}

