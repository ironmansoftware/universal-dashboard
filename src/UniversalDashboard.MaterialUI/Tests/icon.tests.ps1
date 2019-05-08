Describe "icon" {
    Context "content" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDIcon -Icon user -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' 
            }
        }
        It 'has content' {
            Find-SeElement -Id 'test-icon-button' -Driver $Driver | should not be $null
        }
    }

    Context "icon solid" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' 
            }
        }
        It 'has an solid icon' {
            Find-SeElement -ClassName 'fa-angry' -Driver $Driver | should not be $null
        }
    }

    Context "icon regular ( semi light )" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
               New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' -Regular
            }
        }
        It 'has an regular type icon' {
            $element = Find-SeElement -ClassName 'fa-angry' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'data-prefix' | should be 'far'
        }
    }

    Context "solid icon as regular icon fallback" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
               New-UDIcon -Icon box -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' -Regular
            }
        }
        It 'has an regular type icon' {
            $element = Find-SeElement -ClassName 'fa-box' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'data-prefix' | should be 'fas'
        }
    }

    Context "style" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDIcon -Icon user -Size 3x -Style @{color='rgb(33, 150, 243)'}
            }
        }
        It 'has backgroundColor and icon color' {
            $element = Find-SeElement -ClassName 'fa-user' -Driver $Driver 
            $element.GetCssValue('color') | should be 'rgb(33, 150, 243)'
        }
    }

    Context "size" {
        Set-TestDashboard {
            New-UDMuPaper -Content {
                New-UDIcon -Icon angry -Size xs -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size sm -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size lg -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 2x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 4x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 5x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 6x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 7x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 8x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 9x -Style @{color = '#000'}  
                New-UDIcon -Icon angry -Size 10x -Style @{color = '#000'}
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
}