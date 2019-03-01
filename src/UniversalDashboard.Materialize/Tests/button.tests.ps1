Describe "New-UDButton" {
    Context "Text" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button"
        } 
        
        It "has text" {
            (Find-SeElement -Driver $Driver -Id "button").Text | should be "Click Me"
        }
    }

    Context "Floating" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -Floating
        } 
        
        It "is floating" {
            Find-SeElement -Driver $Driver -ClassName "btn-floating" | should not be $null
        }
    }

    Context "Flat" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -Flat
        } 
        
        It "is flat" {
            Find-SeElement -Driver $Driver -ClassName "btn-flat" | should not be $null
        }
    }

    Context "OnClick" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -OnClick {
                $StateDictionary["Clicked"] = $true
            }
        } 

        Invoke-SeClick -Element (Find-SeElement -Id 'button' -Driver $Driver)
        
        It "was clicked" {
            $Global:StateDictionary["Clicked"] | should be $true
        }
    }
}

