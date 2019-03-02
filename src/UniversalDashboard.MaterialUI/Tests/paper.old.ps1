Describe "paper" {
    Context "content" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDHeading -Text "hi" -Id 'hi'
            }
        }

        It 'has content' {
            Find-SeElement -Id 'hi' -Driver $Driver | should not be $null
        }
    }
}