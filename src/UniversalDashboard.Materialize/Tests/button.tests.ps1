Describe "New-UDButton" {
    Context "Text" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button"
        } 
        
        It "has text" {
            (Find-SeElement -Driver $Driver -Id "button").Text | should be "Click Me"
        }
    }

    Wait-Debugger

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

    Context "UdButton" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -Flat
        } 
        
        It "has ud-button" {
            Find-SeElement -Driver $Driver -ClassName "ud-button" | should not be $null
        }
    }

    Context "OnClick" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -OnClick {
                Set-TestData -Data $true
            }
        } 

        Invoke-SeClick -Element (Find-SeElement -Id 'button' -Driver $Driver)
        
        It "was clicked" {
            Get-TestData | Should be $true
        }
    }

    Context "Icon" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id button -Icon user
        } 

        $Element = Find-SeElement -ClassName 'fa-user' -Driver $Driver
        
        It "has an icon" {
            $Element | should not be $null
        }
    }

    Context "Colors" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id button -BackgroundColor red -FontColor black
        } 

        $Element = Find-SeElement -Id 'button' -Driver $Driver
        $Style = Get-SeElementAttribute -Element $Element -Attribute "style"
        
        It "has colors" {
            $Style | Should be "background-color: rgb(255, 0, 0); color: rgb(0, 0, 0);"
        }
    }
}

