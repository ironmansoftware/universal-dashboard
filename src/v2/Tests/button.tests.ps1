Enter-SeUrl "$Address/Test/Button" -Target $Driver

Describe "New-UDButton" {
    It "has text" {
        (Find-SeElement -Driver $Driver -Id "button1").Text | should be "Click Me"
    }
 
    It "is floating" {
        Find-SeElement -Driver $Driver -ClassName "btn-floating" | should not be $null
    }

    It "is flat" {
        Find-SeElement -Driver $Driver -ClassName "btn-flat" | should not be $null
    }
 
    It "has ud-button" {
        Find-SeElement -Driver $Driver -ClassName "ud-button" | should not be $null
    }

    It "was clicked" {
        Find-SeElement -Id 'button5' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be $true
    }

    It "has an icon" {
        $Element = Find-SeElement -ClassName 'fa-user' -Driver $Driver
        $Element | should not be $null
    }

    It "has colors" {
        $Element = Find-SeElement -Id 'button7' -Driver $Driver
        $Style = Get-SeElementAttribute -Element $Element -Attribute "style"    
        $Style | Should be "color: rgb(0, 0, 0); background-color: rgb(255, 0, 0); "
    }
}