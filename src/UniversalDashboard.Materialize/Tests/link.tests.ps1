Describe "New-UDLink" {
    Context "onClick" {
        Set-TestDashboard -Content {
            New-UDLink -Text "hi" -Id 'link' -OnClick {
                Set-TestData -Data "Clicked"
            }
        }

        It "should have fired onClick handler" {
            $Element = Find-SeElement -Driver $Driver -Id 'link' 
            Invoke-SeClick -Element $Element 
            Get-TestData | Should be 'Clicked'
        }
    }
}