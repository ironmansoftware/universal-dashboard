Enter-SeUrl -Target $Driver -Url "http://localhost:10000/Avatar"

Describe 'avatar' {
    It 'has content' {
        $element = Find-SeElement -Id 'avatarContent' -Driver $Driver
        $element.Text | should not be $null
    }

    It 'has width of 80' {
        $element = Find-SeElement -Id 'avatarStyle' -Driver $Driver
        $element.GetCssValue('width') | should be '80px'
    }
    It 'has height of 80' {
        $element = Find-SeElement -Id 'avatarStyle' -Driver $Driver
        $element.GetCssValue('height') | should be '80px'
    }

    
    It 'has border radius of 4px ( avatar is square not round )' {
        $element = (Find-SeElement -Id 'avatarSquare' -Driver $Driver).GetAttribute('style') -match "border-radius: (\d\w+)"
        $Matches[1] | should be '4px'
    }
}