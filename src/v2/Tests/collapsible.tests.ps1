Enter-SeUrl -Url "$Address/test/collapsible" -Target $Driver

Describe "Collapsible" {
    Context "Simple Collapsible" {
        It "should have title text" {
            (Find-SeElement -Id "First" -Driver $Driver).Text.Contains("FirstHeader") | Should be $true
        }

        It "should have body text" {
            (Find-SeElement -Id "First" -Driver $Driver).Text.Contains("FirstBody") | Should be $true
        }
        
        It "should have title text for endpoint" {
            Start-Sleep 1

            (Find-SeElement -Id "First-Endpoint" -Driver $Driver).Text.Contains("Endpoint") | should be $true
        }

        It "should have correct colors" {
            Find-SeElement -Id "Collapsible2-Second" -Driver $Driver | Get-SeElementCssValue -Name "color" | Should be 'rgb(152, 255, 63)'
            Find-SeElement -Id "Collapsible2-Second" -Driver $Driver | Get-SeElementCssValue -Name "background-color" | Should be 'rgb(76, 255, 110)'
        }
    }
}