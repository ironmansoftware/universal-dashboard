Enter-SeUrl -Target $Driver -Url "http://localhost:10000/table"

Describe "Table" {
    It 'has content' {
        $Element = Find-SeElement -Id 'defaultTable' -Driver $Driver 
        ($Element.FindElementByTagName('tbody').FindElementsByTagName('tr') | Measure-Object).Count | should be 5
    }

    It 'has custom columns' {
        $Element = Find-SeElement -Id 'customColumnsTable' -Driver $Driver 
        ($Element.FindElementByTagName('tbody').FindElementsByTagName('tr') | Measure-Object).Count | should be 5
        $Element.FindElementByTagName('thead').FindElementsByTagName('th')[0].Text | Should be "A Dessert"
    }

    It 'should render button in table' {
        Find-SeElement -Id 'btnEclair' -Driver $Driver | Should not be $null
    }

    It 'should sort custom columns' {
        $Element = Find-SeElement -Id 'customColumnsTableRender' -Driver $Driver 
        $Element.FindElementByTagName('thead').FindElementsByTagName('th')[0].FindElementByTagName('svg') | Invoke-SeClick

        $Element.FindElementByTagName('tbody').FindElementsByTagName('tr')[0].FindElementsById('btnCupcake') | should not be $null

        $Element.FindElementByTagName('thead').FindElementsByTagName('th')[0].FindElementByTagName('svg') | Invoke-SeClick
        $Element.FindElementByTagName('tbody').FindElementsByTagName('tr')[0].FindElementsById('btnIce cream sandwich') | should not be $null

        $Element.FindElementByTagName('thead').FindElementsByTagName('th')[0].FindElementByTagName('svg') | Invoke-SeClick
        $Element.FindElementByTagName('tbody').FindElementsByTagName('tr')[0].FindElementsById('btnFrozen yoghurt') | should not be $null
    }

    It 'auto reloads using dynamic' {
        $Element = Find-SeElement -Id 'dynamicTable' -Driver $Driver 
        $Before = $Element.FindElementByTagName('tbody').FindElementsByTagName('td')[0].Text
        Start-Sleep 2
        $After = $Element.FindElementByTagName('tbody').FindElementsByTagName('td')[0].Text
        $Before | Should not be $After
    }

    It 'loads data using sync' {
        $Element = Find-SeElement -Id 'syncTable' -Driver $Driver 
        $Before = $Element.FindElementByTagName('tbody').FindElementsByTagName('td')[0].Text
        Find-SeElement -Id 'btnSync' -Driver $Driver | Invoke-SeClick
        Start-Sleep 1
        $After = $Element.FindElementByTagName('tbody').FindElementsByTagName('td')[0].Text
        $Before | Should not be $After
    }

    
    It 'has data using loadData' {
        $Element = Find-SeElement -Id 'loadDataTable' -Driver $Driver 
        $Element.FindElementByTagName('tbody').FindElementsByTagName('td')[0].Text | should be 'Frozen yoghurt'
    }
}