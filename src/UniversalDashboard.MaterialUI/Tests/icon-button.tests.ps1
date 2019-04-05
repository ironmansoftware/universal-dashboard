Describe "icon button" {
    Context "content" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'test-icon-button' 
            }
        }
        It 'has content' {
            Find-SeElement -Id 'test-icon-button' -Driver $Driver | should not be $null
        }
    }

    Context "icon" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'test-icon-button' 
            }
        }
        It 'has an icon' {
            Find-SeElement -ClassName 'fa-user' -Driver $Driver | should not be $null
        }
    }

    Context "style" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size sm )  -Id 'test-icon-button' -Style @{backgroundColor = '#000'; color='rgb(33, 150, 243)'}
            }
        }
        It 'has backgroundColor and icon color' {
            $element = Find-SeElement -Id 'test-icon-button' -Driver $Driver 
            $element.GetCssValue('color') | should be 'rgb(33, 150, 243)'
        }
    }

    Context "size" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size xs -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size lg -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 2x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 3x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 4x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 5x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 6x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 7x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 8x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 9x -Style @{color = '#000'})  -Id 'test-icon-button' 
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size 10x -Style @{color = '#000'})  -Id 'test-icon-button' 
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
        It 'has an icon size of 3x' {
            Find-SeElement -ClassName 'fa-3x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 4x' {
            Find-SeElement -ClassName 'fa-4x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 5x' {
            Find-SeElement -ClassName 'fa-5x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 6x' {
            Find-SeElement -ClassName 'fa-6x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 7x' {
            Find-SeElement -ClassName 'fa-7x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 8x' {
            Find-SeElement -ClassName 'fa-8x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 9x' {
            Find-SeElement -ClassName 'fa-9x' -Driver $Driver | should not be $null
        }
        It 'has an icon size of 10x' {
            Find-SeElement -ClassName 'fa-10x' -Driver $Driver | should not be $null
        }
    }

    Context "event" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDMuIconButton -Icon (New-UDMuIcon -Icon user -Size lg)  -Id 'test-icon-button' -Style @{backgroundColor = '#c9c9c9'; color='rgb(33, 150, 243)'} -OnClick {
                    Set-TestData -Data "OnClick"
                }
            }
        }
        It 'should click and have test data' {
            Find-SeElement -Id 'test-icon-button' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnClick"
        }
    }
}