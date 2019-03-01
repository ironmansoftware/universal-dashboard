Describe "New-UDTabContainer" {
    Context "Tabs" {
        Set-TestDashboard {
            New-UDTabContainer -Tabs {
                New-UDTab -Text "Tab1" -Content { New-UDCard -Title "Hi" -Content {} }
                New-UDTab -Text "Tab2" -Content { New-UDCard -Title "Hi2" -Content {} }
            }
        } 
        
        It "has tabs" {
            Find-SeElement -Driver $Driver -ClassName "tabs" | should not be $null
        }
    }
}