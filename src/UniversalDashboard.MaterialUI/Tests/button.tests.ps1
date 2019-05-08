Describe "button" {
    Context "label" {
        Set-TestDashboard {
            New-UDMuButton -Text 'Submit' -Id 'button' -variant flat
        }

        It 'has a label' {
            (Find-SeElement -Id 'button' -Driver $Driver).Text | should be "Submit"
        }
    }

    Context "icon" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon 'github'
            New-UDMuButton -Text "Submit" -Id "button" -variant flat -Icon $Icon -OnClick {Show-UDToast -Message 'test'}  
        }

        It 'has an icon' {
            Find-SeElement -ClassName 'fa-github' -Driver $Driver | should not be $null
        }
    }

    Context "should click" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon 'github'
            New-UDMuButton -Text "Submit" -Id "button" -variant flat -Icon $Icon -OnClick {
                Set-TestData -Data "OnClick"
            }
        }

        It "should click and have test data" {
            Find-SeElement -Id 'button' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnClick"
        }
    }
}