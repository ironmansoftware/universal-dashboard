Describe 'avatar' {
    Context 'content' {

        Set-TestDashboard {
            New-UDMuAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'test-avatar'
        }

        It 'has content' {
            $element = Find-SeElement -Id 'test-avatar' -Driver $Driver
            $element.Text | should not be $null
        }
    }

    Context 'style' {

        Set-TestDashboard {
            New-UDMuAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'test-avatar' -Style @{width = 80; height = 80}
        }

        It 'has width of 80' {
            $element = Find-SeElement -Id 'test-avatar' -Driver $Driver
            $element.GetCssValue('width') | should be '80px'
        }
        It 'has height of 80' {
            $element = Find-SeElement -Id 'test-avatar' -Driver $Driver
            $element.GetCssValue('height') | should be '80px'
        }
    }
    Context 'squer' {

        Set-TestDashboard {
            New-UDMuAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'test-avatar' -Style @{width = 150; height = 150;borderRadius = '4px'}
        }

        It 'has border radius of 4px ( avatar is squer not round )' {
            $element = (Find-SeElement -Id 'test-avatar' -Driver $Driver).GetAttribute('style') -match "border-radius: (\d\w+)"
            $Matches[1] | should be '4px'
        }
    }
}