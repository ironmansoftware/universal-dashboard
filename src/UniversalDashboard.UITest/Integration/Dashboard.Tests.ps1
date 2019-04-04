param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Dashboard" {

    Context "Navigation" {
        $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
        $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

        $Navigation = New-UDSideNav -Content {
            New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon user
            New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
            New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
        }
        
        $Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -UpdateToken "TEST"
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It 'should navigate custom navigation' {
            $Element = Find-SeElement -ClassName "menu-button" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "My First Page" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-1" -Driver $Driver | Should not be $null
        }

        It 'should use a fixed menu' {
            Update-UDDashboard -UpdateToken "TEST" -Url "http://localhost:10001" -Content {
                $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
                $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
        
                $Navigation = New-UDSideNav -Content {
                    New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon user
                    New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
                    New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
                } -Fixed
                
                New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            }

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Find-SeElement -Id "page-1" -Driver $Driver | Should not be $null
            
            $Element = Find-SeElement -LinkText "My Second Page" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -Id "page-2" -Driver $Driver | Should not be $null
        }

        It 'should hide the menu' {
            Update-UDDashboard -UpdateToken "TEST" -Url "http://localhost:10001" -Content {
                $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
                $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
        
                $Navigation = New-UDSideNav -None
                
                New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            }

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Find-SeElement -ClassName "menu-button" -Driver $Driver | Should be $null
        }

        It 'should create nested items' {
            Update-UDDashboard -UpdateToken "TEST" -Url "http://localhost:10001" -Content {
                $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
                $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
        
                $Navigation = New-UDSideNav -Content {
                    New-UDSideNavItem -Text "Section" -Children {
                        New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
                        New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
                    }
                } -Fixed
                
                New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            }

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            $Element = Find-SeElement -LinkText "Section" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "My Second Page" -Driver $Driver
            Invoke-SeClick $Element

            Start-Sleep 1

            Find-SeElement -id 'page-2' -Driver $Driver | Should not be $null
        }

        It 'should have subheader and divider' {
            Update-UDDashboard -UpdateToken "TEST" -Url "http://localhost:10001" -Content {
                $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
                $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
        
                $Navigation = New-UDSideNav -Content {
                    New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon user
                    New-UDSideNavItem -Subheader -Text "Subheader"
                    New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
                    New-UDSideNavItem -Divider
                    New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
                } -Fixed
                
                New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            }

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            Find-SeElement -ClassName "subheader" -Driver $Driver | Should not be $null
            Find-SeElement -ClassName "divider" -Driver $Driver | Should not be $null
        }

        It 'should load items from endpoint' {
            Update-UDDashboard -UpdateToken "TEST" -Url "http://localhost:10001" -Content {
                $Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
                $Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}
        
                $Navigation = New-UDSideNav -Endpoint {
                    New-UDSideNavItem -Text "My First Page" -OnClick { Show-UDModal -Content { New-UDCard -Id "ModalCard" } } -Icon user
                } -Fixed
                
                New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
            }

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            $Element = Find-SeElement -LinkText "My First Page" -Driver $Driver 
            Invoke-SeClick $Element

            Find-SeElement -Id "ModalCard" -Driver $Driver | Should not be $null
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
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

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
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

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Update dashboard" {

        $dashboard = New-UDDashboard -Title "Test" -Content {
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -UpdateToken "UpdateToken"

        Start-Sleep 1

        Update-UDDashboard -UpdateToken "UpdateToken" -Url "http://localhost:10001" -Content {
            New-UDDashboard -Title "Test" -Content {
                New-UDElement -Tag 'div' -Id 'test'       
            }
        }


        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "updates the dashboard" {
            Find-SeElement -Driver $Driver -Id 'test' | Should not be $null
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}