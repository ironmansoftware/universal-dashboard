Enter-SeUrl -Target $Driver -Url "http://localhost:10000/link"

Describe "link" {
    It 'has content' {
        $element = Find-SeElement -Id 'card-link' -Driver $Driver
        $element.Text | should not be $null
    }
    It 'has text' {
        $element = Find-SeElement -Id 'demo-link' -Driver $Driver
        $element.Text | should be 'demo'
    }
}
