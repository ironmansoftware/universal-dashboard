Enter-SeUrl -Target $Driver -Url "http://localhost:10000/select"

Describe "select" {
    it 'has options' {
        $Element = Find-SeElement -Id 'select' -Driver $Driver
        $Element.FindElementByXPath('../..') | Invoke-SeClick 

        (Find-SeElement -TagName 'li' -Driver $Driver | Measure-Object).Count | should be 3
    }

    it 'has options with categories' {
        Find-SeElement -TagName body -Driver $Driver | Invoke-SeClick
        Start-Sleep 1
        $Element = Find-SeElement -Id 'selectGrouped' -Driver $Driver
        $Element.FindElementByXPath('../..') | Invoke-SeClick 

        (Find-SeElement -TagName 'li' -Driver $Driver | Measure-Object).Count | should be 8
    }

    it 'has onClick' {
        Find-SeElement -TagName body -Driver $Driver | Invoke-SeClick
        Start-Sleep 1
        $Element = Find-SeElement -Id 'select' -Driver $Driver
        $Element.FindElementByXPath('../..') | Invoke-SeClick 

        Find-SeElement -TagName 'li' -Driver $Driver | Select-Object -First 1 | Invoke-SeClick 

        Get-TestData | should be "1"
    }
}