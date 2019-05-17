Describe "Collapsible" {
    Context "Simple Collapsible" {
        Set-TestDashboard {
            New-UDCollapsible -Id "Collapsible" -Items {
                New-UDCollapsibleItem -Id "First" -Title "FirstHeader" -Icon user -Content {
                    New-UDCard -Title "FirstBody"
                } -Active
                New-UDCollapsibleItem -Id "Second" -Title "Second" -Icon user -Content {
                    New-UDCard -Title "Second"
                }
                New-UDCollapsibleItem -Id "Third" -Title "Third" -Icon user -Content {
                    New-UDCard -Title "Third"
                }
            }

            New-UDCollapsible -Id "Collapsible2" -BackgroundColor "#4945FF" -FontColor "#A938FF" -Items {
                New-UDCollapsibleItem -Id "First-Endpoint" -Title "First" -Icon user -Endpoint {
                    New-UDCard -Title "Endpoint"
                } -Active

                New-UDCollapsibleItem -Id "Collapsible2-Second" -Title "Second" -BackgroundColor "#4CFF6E" -FontColor "#98FF3F" -Icon user -Content  {
                    New-UDCard -Title "Third"
                } 
            }

            New-UDCollapsible -Id "Collapsible with changing icon" -BackgroundColor "#4945FF" -FontColor "#A938FF" -Items {
                New-UDCollapsibleItem -Id "ChangeMyIcon" -Title "First" -Icon user -Content {
                    New-UDCard -Title "Endpoint"

                    New-UDButton -Text "Change Icon" -Id "changeIcon" -OnClick {
                        Set-UDElement -Id "ChangeMyIcon-icon" -Attributes @{
                            className = 'fa fa-user'
                        }
                    }

                } -Active
            }
        }

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
    }
}