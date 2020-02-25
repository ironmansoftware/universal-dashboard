return 

. "$PSScriptRoot\..\TestFramework.ps1"

Describe "New-UDPage" {

    Context "dynamic page with title" {
        $Page1 = New-UDPage -Name "Page" -Title 'Xyz' -Endpoint {
            
        }

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should have a custom title" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/Page"
            (Find-SeElement -Tag "title" -Driver $Driver).Text | Should not be "Xyz"
        }
    }

    Context "page with spaces and endpoint" {
        $Page1 = New-UDPage -Name "Page" -Content {
            New-UDElement -Tag "div" -Id "Home"
        }

        $Page2 = New-UDPage -Name "Page with Spaces" -Endpoint {
            New-UDElement -Tag "div" -Id "Home2"
        }

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should navigate to page with spaces" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/Page with Spaces"
            Find-SeElement -Id "Home2" -Driver $Driver | Should not be $null
        }
    }

    Context "cycling" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDElement -Tag "div" -Id "Home"
        }

        $Page2 = New-UDPage -Url "/some/page" -Endpoint {
            New-UDElement -Tag "div" -Id "Page"
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2) -CyclePages -CyclePagesInterval 2
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should cycle dynamic pages" {
            Find-SeElement -Id "Home" -Driver $Driver | Should not be $null
            Start-Sleep 2
            Find-SeElement -Id "Page" -Driver $Driver | Should not be $null
        }
    }

    Context "AutoReload" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDElement -Tag "div" -Id 'Home'
        }

        $Page2 = New-UDPage -Url "/mypage" -Endpoint {
            New-UDElement -Tag "div" -Id 'page-with-spaces' -Content { (Get-Date).ToString() }
        } -AutoRefresh -RefreshInterval 1 

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should autoreload" {

            Enter-SeUrl -Driver $Driver -Url http://localhost:$BrowserPort/mypage

            $ElementText = (Find-SeElement -Id "page-with-spaces" -Driver $Driver).Text

            Start-Sleep 3

            (Find-SeElement -Id "page-with-spaces" -Driver $Driver).Text | Should not be $ElementText
        }
    }

    Context "Titles" {

        $Page1 = New-UDPage -Name "Home" -Content {
            
        } -Title "My First Page"

        $Page2 = New-UDPage -Url "/mypage" -Endpoint {
            
        }  

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/Home"
        Start-Sleep 2

        It "should have home page title" {
            (Find-SeElement -Id "udtitle" -Driver $Driver).Text | should be "My First Page"

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/mypage"
            Start-Sleep 2

            (Find-SeElement -Id "udtitle" -Driver $Driver).Text | should be "Test"
        }
    }

    Context "multi-page" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDElement -Tag "div" -Id 'home-page'
        }

        $Page2 = New-UDPage -Name "Page with spaces" -Content {
            New-UDElement -Tag "div" -Id 'page-with-spaces'
        }

        $Page3 = New-UDPage -Name "Test" -Content {
            New-UDElement -Tag "div" -Id 'Test-Page'
        }

        $Page4 = New-UDPage -Url "/level/:test" -Endpoint {
            New-UDElement -Tag "div" -Id 'Level1'
        }

        $Page5 = New-UDPage -Url "/level/level2/:test" -Endpoint {
            New-UDElement -Tag "div" -Id 'Level2'
        }

        $Page6 = New-UDPage -Name "/parent" -Content {
            New-UDElement -Tag "div" -Id 'parent'
        }

        $Page7 = New-UDPage -Name "/parent/child" -Content {
            New-UDElement -Tag "div" -Id 'child'
        }

        $Page8 = New-UDPage -Url "/parameter/:test" -Endpoint {
            param($test)

            New-UDElement -Tag "div" -Id 'parameter' -Content { $test }
        }

        $Page9 = New-UDPage -Url "level1/level2" -Endpoint {
            New-UDElement -Tag "div" -Id 'nofrontslash'
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2, $Page3, $Page5, $Page4, $Page7, $Page6, $Page8, $Page9)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should navigate to page with spaces" {
            $Element = Find-SeElement -Id "sidenavtrigger" -Driver $Driver
            Invoke-SeClick $Element -JavaScriptClick -Driver $Driver

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "Page with spaces" -Driver $Driver
            Invoke-SeClick $Element -JavaScriptClick -Driver $Driver

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

        it "should pass in parameter" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/parameter/myParameter"
            (Find-SeElement -Id 'parameter' -Driver $Driver).Text | Should be "myParameter"
        }

        it "should work if no prefix slash" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/level1/level2"
            (Find-SeElement -Id 'nofrontslash' -Driver $Driver).Text | Should be "level1/level2"
        }

        it "should show not found" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort/somerandompage"
            Find-SeElement -Id 'notfound' -Driver $Driver | Should not be $null
        }
    }

    Context "Page with DefaultHomePage parameter" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDElement -Tag "div" -Id 'home-page'
        }

        $Page2 = New-UDPage -Name "Test" -DefaultHomePage -Content {
            New-UDElement -Tag "div" -Id 'Test-Page' 
        }
        
        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        it "First page should be the one with DefualtHomePage parameter set to true" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 3
            Find-SeElement -Id 'Test-Page' -Driver $Driver | Should not be $null
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
    }


    Context "single page with hyphen" {

        $Page1 = New-UDPage -Name "Home" -Content {
            New-UDElement -Tag "div" -Id 'Test-Page' 
        }

        $Page2 = New-UDPage -Name "Page-with-hyphens" -Content {
            New-UDElement -Tag "div" -Id 'page-with-hyphens' 
        }

        $dashboard = New-UDDashboard -Title "Test" -Pages @($Page1, $Page2)
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should navigate to page with hyphens" {
            $Element = Find-SeElement -Id "sidenavtrigger" -Driver $Driver
            Invoke-SeClick $Element -Driver $Driver -JavaScriptClick

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "Page-with-hyphens" -Driver $Driver
            Invoke-SeClick $Element -Driver $Driver -JavaScriptClick

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
    }
}