param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force


Get-UDDashboard | Stop-UDDashboard

Describe "New-UDPage" {

    
    Context "cycling" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home" -Id "Home"
        }

        $Page2 = New-UDPage -Url "/some/page" -Endpoint {
            New-UDCard -Text "Some Page" -Id "Page"
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2) -CyclePages -CyclePagesInterval 2
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should cycle dynamic pages" {
            Find-SeElement -Id "Home" -Driver $Cache:Driver | Should not be $null
            Start-Sleep 2
            Find-SeElement -Id "Page" -Driver $Cache:Driver | Should not be $null
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "AutoReload" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home"
        }

        $Page2 = New-UDPage -Url "/mypage" -Endpoint {
            New-UDCard -Text (Get-Date) -Id "page-with-spaces"
        } -AutoRefresh -RefreshInterval 1 

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/mypage"
        Start-Sleep 2

        It "should navigate to page with spaces" {
            $ElementText = (Find-SeElement -Id "page-with-spaces" -Driver $Cache:Driver).Text

            Start-Sleep 3

            (Find-SeElement -Id "page-with-spaces" -Driver $Cache:Driver).Text | Should not be $ElementText
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "multi-page" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home" -id 'home-page'
        }

        $Page2 = New-UDPage -Name "Page with spaces" -Content {
            New-UDCard -Text "Page with spaces" -Id "page-with-spaces"
        }

        $Page3 = New-UDPage -Name "Test" -Content {
            New-UDCard -Text "TestPage" -Id "Test-Page"
        }

        $Page4 = New-UDPage -Url "/level/:test" -Endpoint {
            New-UDCard -Text "Level 1" -Id "Level1"
        }

        $Page5 = New-UDPage -Url "/level/level2/:test" -Endpoint {
            New-UDCard -Text "Level 2" -Id "Level2"
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2, $Page3, $Page5, $Page4)
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should navigate to page with spaces" {
            $Element = Find-SeElement -ClassName "menu-button" -Driver $Cache:Driver
            Invoke-SeClick $Element

            $Element = Find-SeElement -LinkText "Page with spaces" -Driver $Cache:Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-with-spaces" -Driver $Cache:Driver | Should not be $null
        }

        It "should navigate to page with spaces via url" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/page-with-spaces"
            Start-Sleep 3
            Find-SeElement -Id "page-with-spaces" -Driver $Cache:Driver | Should not be $null
        }

        it "should redirect to home page when dashboard title was clicked" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/Test"
            $TestPageText = (Find-SeElement -Id 'Test-Page' -Driver $Cache:Driver).text
            Start-Sleep 3
            $TitleElement = Find-SeElement -XPath '//*[@id="app"]/div/nav/a[2]' -Driver $Cache:Driver 
            Invoke-SeClick -Element $TitleElement -Driver $Cache:Driver -JavaScriptClick
            Start-Sleep 3
            (Find-SeElement -Id 'home-page' -Driver $Cache:Driver).text | Should not be $TestPageText
        }

        it "should have level 1 but not level 2" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/level/1"
            Find-SeElement -Id 'Level1' -Driver $Cache:Driver | Should not be $null
            Find-SeElement -Id 'Level2' -Driver $Cache:Driver | Should be $null
        }

        it "should have level 2 but not level 1" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/level/level2/1"
            Find-SeElement -Id 'Level1' -Driver $Cache:Driver | Should be $null
            Find-SeElement -Id 'Level2' -Driver $Cache:Driver | Should not be $null
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Page with DefaultHomePage parameter" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDCard -Text "Home" -id 'home-page'
        }

        $Page2 = New-UDPage -Name "Test" -DefaultHomePage -Content {
            New-UDCard -Text "TestPage" -Id "Test-Page"
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        it "First page should be the one with DefualtHomePage parameter set to true" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 3
            (Find-SeElement -Id 'Test-Page' -Driver $Cache:Driver).text | Should be 'TestPage'
        }

        it "should redirect to home page when dashboard title was clicked" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/Home"
            $HomePageText = (Find-SeElement -Id 'home-page' -Driver $Cache:Driver).text
            Start-Sleep 3
            $TitleElement = Find-SeElement -XPath '//*[@id="app"]/div/nav/a[2]' -Driver $Cache:Driver 
            Invoke-SeClick -Element $TitleElement -Driver $Cache:Driver -JavaScriptClick
            Start-Sleep 3
            (Find-SeElement -Id 'Test-Page' -Driver $Cache:Driver).text | Should not be $HomePageText
        }

        Stop-SeDriver $Cache:Driver
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
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should navigate to page with hyphens" {
            $Element = Find-SeElement -ClassName "menu-button" -Driver $Cache:Driver
            Invoke-SeClick $Element

            $Element = Find-SeElement -LinkText "Page-with-hyphens" -Driver $Cache:Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-with-hyphens" -Driver $Cache:Driver | Should not be $null
        }

        It "should navigate to page with hyphens via url" {
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/page-with-hyphens"
            Start-Sleep 3
            Find-SeElement -Id "page-with-hyphens" -Driver $Cache:Driver | Should not be $null
        }

       Stop-SeDriver $Cache:Driver
       Stop-UDDashboard -Server $Server 
    }
}
