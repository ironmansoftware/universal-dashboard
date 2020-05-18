Describe "Modal" {
    Context "Show-UDModal" {
        Set-TestDashboard -Content {
            New-UDButton -Text "Show" -Id 'button' -OnClick {
                Show-UDModal -Content {
                    New-UDElement -Tag 'div' -Id 'modal-content'
                }
            }
        }

        It "should open modal with new content" {
            $Element = Find-SeElement -Driver $Driver -Id 'button' 
            Invoke-SeClick -Element $Element 

            Start-Sleep 3

            Find-SeElement -Driver $Driver -Id 'modal-content' | Should not be $null
        }
    }

    Context "Hide-UDModal" {
        Set-TestDashboard -Content {
            New-UDButton -Text "Show" -Id 'button' -OnClick {
                Show-UDModal -Content {
                    New-UDElement -Tag 'div' -Id 'modal-content'
                    New-UDButton -OnClick { Hide-UDModal } -Text "Hide" -Id 'hide'
                }
            }
        }

        It "should dispose of content when hidden" {
            $Element = Find-SeElement -Driver $Driver -Id 'button' 
            Invoke-SeClick -Element $Element 

            Start-Sleep 3

            Find-SeElement -Driver $Driver -Id 'modal-content' | Should not be $null

            $Element = Find-SeElement -Driver $Driver -Id 'hide' 
            Invoke-SeClick -Element $Element 

            Start-Sleep 1

            Find-SeElement -Driver $Driver -Id 'modal-content' | Should be $null
        }
    }

    Context "Should have link in card" {
        Set-TestDashboard -Content {
            New-UDButton -Text "Click" -Id "Click" -OnClick {
                Show-UDModal -Header {
                    New-UDHeading -Size 4 -Text "Heading" -Id "Heading"
                } -Content {
                    New-UDButton -Text "Press me" -Id "Close" -OnClick {
                        Hide-UDModal
                    }
                } -BackgroundColor black -FontColor red
            }

            New-UDButton -Text "Click" -Id "Click2" -OnClick {
                Show-UDModal -Header {
                    New-UDHeading -Size 4 -Text "Heading two" 
                } -Content {
                    New-UDButton -Text "Press me" -Id "Close2" -OnClick {
                        Hide-UDModal
                    }
                } 
            }
        }

        It "should open and close modal" {
            Find-SeElement -Driver $Driver -Id "Click" | Invoke-SeClick

            Start-Sleep 3

            (Find-SeElement -Driver $driver -Id "Heading").Text | Should be "Heading"
            Find-SeElement -Driver $Driver -Id "Close" | Invoke-SeClick
        }

    }
}