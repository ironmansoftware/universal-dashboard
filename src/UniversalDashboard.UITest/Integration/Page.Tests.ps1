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
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should cycle dynamic pages" {
            Find-SeElement -Id "Home" -Driver $Driver | Should not be $null
            Start-Sleep 2
            Find-SeElement -Id "Page" -Driver $Driver | Should not be $null
        }

        Stop-SeDriver $Driver
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
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/mypage"
        Start-Sleep 2

        It "should navigate to page with spaces" {
            $ElementText = (Find-SeElement -Id "page-with-spaces" -Driver $Driver).Text

            Start-Sleep 3

            (Find-SeElement -Id "page-with-spaces" -Driver $Driver).Text | Should not be $ElementText
        }

        Stop-SeDriver $Driver
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

        $Page6 = New-UDPage -Name "/parent" -Content {
            New-UDCard -Text "parent" -Id "parent"
        }

        $Page7 = New-UDPage -Name "/parent/child" -Content {
            New-UDCard -Text "child" -Id "child"
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2, $Page3, $Page5, $Page4, $Page6, $Page7)
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

        it "should redirect to home page when dashboard title was clicked" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/Test"
            $TestPageText = (Find-SeElement -Id 'Test-Page' -Driver $Driver).text
            Start-Sleep 3
            $TitleElement = Find-SeElement -XPath '//*[@id="app"]/div/header/nav/a[2]' -Driver $Driver 
            Invoke-SeClick -Element $TitleElement -Driver $Driver -JavaScriptClick
            Start-Sleep 3
            (Find-SeElement -Id 'home-page' -Driver $Driver).text | Should not be $TestPageText
        }

        it "should have level 1 but not level 2" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/level/1"
            Find-SeElement -Id 'Level1' -Driver $Driver | Should not be $null
            Find-SeElement -Id 'Level2' -Driver $Driver | Should be $null
        }

        it "should have level 2 but not level 1" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/level/level2/1"
            Find-SeElement -Id 'Level1' -Driver $Driver | Should be $null
            Find-SeElement -Id 'Level2' -Driver $Driver | Should not be $null
        }

        it "should have parent but not child" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/parent"
            Find-SeElement -Id 'child' -Driver $Driver | Should be $null
            Find-SeElement -Id 'parent' -Driver $Driver | Should not be $null
        }

        it "should have child but not parent" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/parent/child"
            Find-SeElement -Id 'parent' -Driver $Driver | Should be $null
            Find-SeElement -Id 'child' -Driver $Driver | Should not be $null
        }

        Stop-SeDriver $Driver
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
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        it "First page should be the one with DefualtHomePage parameter set to true" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 3
            (Find-SeElement -Id 'Test-Page' -Driver $Driver).text | Should be 'TestPage'
        }

        it "should redirect to home page when dashboard title was clicked" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 1
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/Home"
            $HomePageText = (Find-SeElement -Id 'home-page' -Driver $Driver).text
            Start-Sleep 3
            $TitleElement = Find-SeElement -XPath '//*[@id="app"]/div/header//nav/a[2]' -Driver $Driver 
            Invoke-SeClick -Element $TitleElement -Driver $Driver -JavaScriptClick
            Start-Sleep 3
            (Find-SeElement -Id 'Test-Page' -Driver $Driver).text | Should not be $HomePageText
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
