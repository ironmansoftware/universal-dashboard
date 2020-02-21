Enter-SeUrl -Target $Driver -Url "http://localhost:10000/table"

Describe "Table" {
    It 'has content' {
        $Element = Find-SeElement -Id 'defaultTable' -Driver $Driver 
        ($Element.FindElementByTagName('tbody').FindElementsByTagName('tr') | Measure-Object).Count | should be 5
    }

    It 'has small size' {
        $Element = Find-SeElement -Id 'smallTable' -Driver $Driver 
        $Element.FindElementByTagName('thead').FindElementsByTagName('th')[0].GetAttribute('class').Contains('MuiTableCell-sizeSmall') | should be $true
    }
}