Describe "icon button" {
    Context "content" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Color primary)  -Id 'test-icon-button' 
            }
        }
        It 'has content' {
            Find-SeElement -Id 'test-icon-button' -Driver $Driver | should not be $null
        }
    }

    Context "icon" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Color primary)  -Id 'test-icon-button' 
            }
        }
        It 'has an icon' {
            Find-SeElement -ClassName 'fa-user' -Driver $Driver | should not be $null
        }
    }

    Context "size" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size xs -Color Primary)  -Id 'test-icon-button' 
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Color Secondary)  -Id 'test-icon-button' 
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size lg -Color Primary)  -Id 'test-icon-button' 
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size 2x -Color Primary)  -Id 'test-icon-button' 
                New-UDIconButton -Icon (New-UDIcon -Icon user -Size 5x -Color Primary)  -Id 'test-icon-button' 
            }
        }
        It 'has an icon size of xs' {
            Find-SeElement -ClassName 'fa-xs' -Driver $Driver | should not be $null
        }
        It 'has an icon size of sm' {
            Find-SeElement -ClassName 'fa-sm' -Driver $Driver | should not be $null
        }
        It 'has an icon size of lg' {
            Find-SeElement -ClassName 'fa-lg' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 2x' {
            Find-SeElement -ClassName 'fa-2x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 5x' {
            Find-SeElement -ClassName 'fa-5x' -Driver $Driver | should not be $null
        }
    }
}