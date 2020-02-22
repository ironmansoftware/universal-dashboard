Enter-SeUrl -Target $Driver -Url "http://localhost:10000/table"

Describe "Table" {
    It 'has content' -Skip {
        $Element = Find-SeElement -Id 'defaultTable' -Driver $Driver 
        ($Element.FindElementByTagName('tbody').FindElementsByTagName('tr') | Measure-Object).Count | should be 5
    }
}