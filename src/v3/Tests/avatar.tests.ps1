Enter-SeUrl -Target $Driver -Url "$Address/Test/Avatar"

Describe 'avatar' {
    It 'has content' {
        $element = Find-SeElement -Id 'avatarContent' -Driver $Driver
        $element.Text | should not be $null
    }

    It 'has width of 80' {
        $element = Find-SeElement -Id 'avatarStyle' -Driver $Driver
        $element.GetCssValue('width') | should be '40px'
    }
    It 'has height of 80' {
        $element = Find-SeElement -Id 'avatarStyle' -Driver $Driver
        $element.GetCssValue('height') | should be '40px'
    }

    It 'has large variant' {
        $element = Find-SeElement -Id 'avatarSquare' -Driver $Driver
        $element.GetCssValue('height') | should be '40px'
    }
}