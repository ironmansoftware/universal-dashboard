Enter-SeUrl -Target $Driver -Url "http://localhost:10000/card"

Describe "card" {
    It 'has toolbar with content' {
        $element = Find-SeElement -Id 'toolbar' -Driver $Driver
        $element.Text | should not be $null
    }
    It 'has header with content' {
        $element = Find-SeElement -Id 'header' -Driver $Driver
        $element.Text | should not be $null
    }
    It 'has body with content' {
        $element = Find-SeElement -Id 'body' -Driver $Driver
        $element.Text | should not be $null
    }
    It 'has expand with content' {
        $button = Find-SeElement -id 'ud-card-expand-button' -Driver $Driver
        Invoke-SeClick -Element $button -Driver $Driver
        $element = Find-SeElement -Id 'expand' -Driver $Driver
        $element.Text | should not be $null
    }
    It 'has footer with content' {
        $element = Find-SeElement -Id 'footer' -Driver $Driver
        $element.FindElementsByTagName('button').count | should be 4
    }
}
