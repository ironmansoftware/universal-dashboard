param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force


Get-UDDashboard | Stop-UDDashboard

Describe "New-UDPage" {

    Context "AutoReload" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home"
        }

        $Page2 = New-UDPage -Url "/mypage" -Endpoint {
            New-UDCard -Text (Get-Date) -Id "page-with-spaces"
        } -AutoRefresh -RefreshInterval 1 

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/mypage"
        Start-Sleep 2

        It "should navigate to page with spaces" {
            $ElementText = (Find-SeElement -Id "page-with-spaces" -Driver $Driver).Text

            Start-Sleep 2

            (Find-SeElement -Id "page-with-spaces" -Driver $Driver).Text | Should not be $ElementText
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "multi-page" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home"
        }

        $Page2 = New-UDPage -Name "Page with spaces" -Content {
            New-UDCard -Text "Page with spaces" -Id "page-with-spaces"
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should navigate to page with spaces" {
            $Element = Find-SeElement -ClassName "menu-button" -Driver $Driver
            Invoke-SeClick $Element

            $Element = Find-SeElement -LinkText "Page with spaces" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-with-spaces" -Driver $Driver | Should not be $null
        }

        It "should navigate to page with spaces via url" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/page-with-spaces"
            Start-Sleep 3
            Find-SeElement -Id "page-with-spaces" -Driver $Driver | Should not be $null
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "single page with hyphen" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home"
        }

        $Page2 = New-UDPage -Name "Page-with-hyphens" -Content {
            New-UDCard -Text "Page-with-hyphens" -Id "page-with-hyphens"
        }

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should navigate to page with hyphens" {
            $Element = Find-SeElement -ClassName "menu-button" -Driver $Driver
            Invoke-SeClick $Element

            $Element = Find-SeElement -LinkText "Page-with-hyphens" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-with-hyphens" -Driver $Driver | Should not be $null
        }

        It "should navigate to page with hyphens via url" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/page-with-hyphens"
            Start-Sleep 3
            Find-SeElement -Id "page-with-hyphens" -Driver $Driver | Should not be $null
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}
