Enter-SeUrl "$Address/Test/Link" -Target $Driver

Describe "New-UDLink" {
    It "should have fired onClick handler" {
        $Element = Find-SeElement -Driver $Driver -Id 'link' 
        Invoke-SeClick -Element $Element 
        Get-TestData | Should be 'Clicked'
    }
}