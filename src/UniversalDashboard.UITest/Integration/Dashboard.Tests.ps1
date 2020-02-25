return

. "$PSScriptRoot\..\TestFramework.ps1"

$Cache:StateCollection = New-Object -TypeName 'System.Collections.Concurrent.BlockingCollection[object]'

Describe "Dashboard" {

    Context "Navigation" {
        $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
        $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

        $Navigation = New-UDSideNav -Content {
            New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon user
            New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
            New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
            New-UDSideNavItem -Text "OnClick" -OnClick { $Cache:StateCollection.Add('NavClicked') } -Icon Users
        }
        
        $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
        Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force

        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        
        It 'should fire onClick' {
            $Element = Find-SeElement -Id "sidenavtrigger" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "OnClick" -Driver $Driver
            Invoke-SeClick $Element

            Get-TestData | Should be "NavClicked"
        }

        It 'should navigate custom navigation' {
            $Element = Find-SeElement -Id "sidenavtrigger" -Driver $Driver
            Invoke-SeClick $Element -JavaScriptClick -Driver $Driver

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "My First Page" -Driver $Driver
            Invoke-SeClick $Element -JavaScriptClick -Driver $Driver

            Start-Sleep 1

            Find-SeElement -Id "page-1" -Driver $Driver | Should not be $null
        }

        It 'should use a fixed menu' {
            
            $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
            $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
    
            $Navigation = New-UDSideNav -Content {
                New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon user
                New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User -Id 'page-2-link'
                New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
            } -Fixed
            
            $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Start-Sleep 1

            Find-SeElement -Id "page-1" -Driver $Driver | Should not be $null
            
            $Element = Find-SeElement -Id "page-2-link" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-2" -Driver $Driver | Should not be $null
        }

        It 'should hide the menu' {
            
            $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
            $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
    
            $Navigation = New-UDSideNav -None
            
            $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Find-SeElement -Id 'sidenavtrigger' -Driver $Driver | Should be $null
        }

        It 'should create nested items' {
            $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
            $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
    
            $Navigation = New-UDSideNav -Content {
                New-UDSideNavItem -Text "Section" -Id 'section' -Children {
                    New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User -Id 'page-name-2'
                    New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
                }
            } -Fixed
            
            $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            $Element = Find-SeElement -Id "section" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            $Element = Find-SeElement -Id "page-name-2" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -id 'page-2' -Driver $Driver | Should not be $null
        }

        It 'should have subheader and divider' {
            $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
            $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
    
            $Navigation = New-UDSideNav -Content {
                New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon user
                New-UDSideNavItem -Subheader -Text "Subheader"
                New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
                New-UDSideNavItem -Divider
                New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
            } -Fixed
            
            $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Find-SeElement -ClassName "subheader" -Driver $Driver | Should not be $null
            Find-SeElement -ClassName "divider" -Driver $Driver | Should not be $null
        }

        It 'should load items from endpoint' {
            $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
            $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
    
            $Navigation = New-UDSideNav -Endpoint {
                New-UDSideNavItem -Text "My First Page" -OnClick { Show-UDModal -Content { New-UDCard -Id "ModalCard" } } -Icon user -Id 'my-first-page'
            } -Fixed
            
            $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Start-Sleep 1

            $Element = Find-SeElement -Id "my-first-page" -Driver $Driver 
            Invoke-SeClick $Element

            Find-SeElement -Id "ModalCard" -Driver $Driver | Should not be $null
        }
    }

    Context "Initialization Script" {

        $TitleVariable = "Title"
        function Get-ContentForCard {
            "Body"
        }

        $Init = New-UDEndpointInitialization -Variable "TitleVariable" -Function "Get-ContentForCard"

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 12 -Endpoint {
                    New-UDCard -Title $TitleVariable -Text (Get-ContentForCard) -Id "Card" 
                }
                New-UDColumn -Size 12 -Endpoint {
                    New-UDCard -Title $TitleVariable -Text (Get-ContentForCard) -Id "Card2" 
                }
                New-UDColumn -Size 12 -Endpoint {
                    New-UDCard -Title $TitleVariable -Text (Get-ContentForCard) -Id "Card3" 
                }
            } 
        } -EndpointInitialization $Init -Scripts "https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"

        Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card2" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"

            $Element = Find-SeElement -Id "Card3" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Title"
        }

        It "should load javascript" {
            $Item = (Find-SeElement -TagName "script" -Driver $Driver ).GetAttribute("src") | Where { $_ -eq 'https://unpkg.com/leaflet@1.3.1/dist/leaflet.js' } 
            $Item | Should not be $null
        }
    }

    Context "Update dashboard" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
        } 

        Start-UDDashboard -Port 10001 -Dashboard $dashboard -UpdateToken "UpdateToken" -Force

        Start-Sleep 1

        Update-UDDashboard -UpdateToken "UpdateToken" -Url "http://localhost:10001" -Content {
            New-UDDashboard -Title "Test" -Content {
                New-UDElement -Tag 'div' -Id 'test'       
            }
        }


        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "updates the dashboard" {
            Find-SeElement -Driver $Driver -Id 'test' | Should not be $null
        }
    }
}