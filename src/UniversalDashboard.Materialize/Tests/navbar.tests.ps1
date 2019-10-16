Describe "Navbar" {
    Context "colors" {
        Set-TestDashboard -Dashboard (
            New-UDDashboard -Title 'test' -NavBarColor 'black' -NavBarFontColor 'white' -Content {

            }
        )

        It "should have the correct colors" {
            Find-SeElement -Driver $Driver -ClassName 'ud-navbar'  | Get-SeElementCssValue -Name 'background-color' | Should be 'rgb(0, 0, 0)'
            Find-SeElement -Driver $Driver -ClassName 'ud-navbar'  | Get-SeElementCssValue -Name 'color' | Should be 'rgb(255, 255, 255)'
        }
    }

    Context "default colors" {
        Set-TestDashboard -Dashboard (
            New-UDDashboard -Title 'test' -Content {

            }
        )

        It "should have the correct colors" {
            Find-SeElement -Driver $Driver -ClassName 'ud-navbar'  | Get-SeElementCssValue -Name 'background-color' | Should be 'rgb(63, 81, 181)'
            Find-SeElement -Driver $Driver -ClassName 'ud-navbar'  | Get-SeElementCssValue -Name 'color' | Should be 'rgb(255, 255, 255)'
        }
    }
    
    Context "logo" {
        $Logo = New-UDImage -Path "$PSScriptRoot/assets/logo.png" -Height 50 -Width 50 -Id 'image'
        Set-TestDashboard -Dashboard (
            New-UDDashboard -Title 'test' -Content {

            } -NavBarLogo $Logo
        )

        It "should have a logo" {
            Find-SeElement -Driver $Driver -Id 'image' | should not be $null
        }
    }
}