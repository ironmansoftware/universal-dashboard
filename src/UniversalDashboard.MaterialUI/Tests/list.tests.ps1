Enter-SeUrl -Target $Driver -Url "http://localhost:10000/list"

Describe "list" {
    It 'has content' {
        Find-SeElement -Id 'listContent' -Driver $Driver | should not be $null
    }

    It 'has 5 list items' {
        (Find-SeElement -Id 'listContentItem' -Driver $Driver).count | should be 5
    }

    It 'has background color of (rgb(236, 236, 236))' {
        $element = Find-SeElement -Id 'demo-list' -Driver $Driver
        $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
        $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()

        $element.GetCssValue('background-color') | should be 'rgb(236, 236, 236)'
    }

    It 'has box-shadow ( drop shadow )' {
        $element = Find-SeElement -Id 'demo-list' -Driver $Driver
        $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
        $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()

        $element.GetCssValue('box-shadow') | should be 'rgba(0, 0, 0, 0.2) 0px 1px 5px 0px, rgba(0, 0, 0, 0.14) 0px 2px 2px 0px, rgba(0, 0, 0, 0.12) 0px 3px 1px -2px'
    }

    It 'has padding right of 8px' {
        $element = Find-SeElement -Id 'demo-list' -Driver $Driver
        $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
        $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()

        $element.GetCssValue('padding-right') | should be '8px'
    }

    It 'has padding left of 8px' {
        $element = Find-SeElement -Id 'demo-list' -Driver $Driver
        $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
        $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()

        $element.GetCssValue('padding-left') | should be '8px'
    }
}