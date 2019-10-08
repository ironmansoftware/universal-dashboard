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

            Find-SeElement -Driver $Driver -Id 'modal-content' | Should not be $null

            $Element = Find-SeElement -Driver $Driver -Id 'hide' 
            Invoke-SeClick -Element $Element 

            Start-Sleep 1

            Find-SeElement -Driver $Driver -Id 'modal-content' | Should be $null
        }
    }
}