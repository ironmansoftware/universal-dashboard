param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Element" {

    Context "ArgumentList" {
        $dashboard = New-UDDashboard -Title "PowerShell Universal Dashboard" -Content {
            $Patch = 'comp1'
            New-UDButton -Id 'button' -Text $Patch -OnClick (New-UDEndpoint -Endpoint { 
                Add-UDElement -ParentId 'parent' -Content {
                    New-UDElement -Id "output" -Tag 'div' -Content { $ArgumentList[0] }
                }
            } -ArgumentList $Patch )
            New-UDElement -Id 'parent' -Tag 'div' -Content { }
        }

         $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
         $Cache:Driver = Start-SeFirefox
         Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

         It "should use an endpoint" {
            Find-SeElement -Driver $Cache:Driver -Id 'button' | Invoke-SeClick
            (Find-SeElement -Drive $Cache:Driver -Id 'output').Text | should be "comp1"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Should work with attributes that start with on" {
        $dashboard = New-UDDashboard -Title "PowerShell Universal Dashboard" -Content {
            New-UDElement -Tag A -Id "element" -Attributes @{onclick = 'kaboom'} -Content {'IAMME'}
        }

         $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
         $Cache:Driver = Start-SeFirefox
         Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

         It "should not show error" {
            (Find-SeElement -Driver $Cache:Driver -Id 'element').Text | Should be "IAMME"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Session Endpoint Cache" {

        $homePage = New-UDPage -Name "Home" -Content {
            New-UDRow -Columns {
               New-UDColumn -Endpoint {
                  New-UDButton -Text "Click me" -OnClick {
                      Set-UDElement -Id "changer" -Content { Get-Date }
                  } 
               } -AutoRefresh -RefreshInterval 2
            }

            New-UDRow -Columns {
                New-UDColumn -Content {
                    New-UDElement -Tag div -Id "changer" -Content {}
                }
            }

            New-UDElement -Tag "div" -Id "sessionInfo" -Endpoint {
                $SessionState = $null
                $DashboardService.EndpointService.EndpointCache.TryGetValue("SessionState" + $SessionId, [ref]$SessionState)
                $SessionState.Endpoints.Count
            } -AutoRefresh -RefreshInterval 1
         } 

        $dashboard = New-UDDashboard -Title "PowerShell Universal Dashboard" -Pages $homePage

         $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
         $Cache:Driver = Start-SeFirefox
         Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

         It "has only 1 cached endpoint" {
             Find-SeElement -Driver $Cache:Driver -ClassName 'btn' | Invoke-SeClick

             Start-Sleep 1

             $ChangerText = (Find-SeElement -Driver $Cache:Driver -Id "changer").Text
             $ChangerText | Should not be $null
             Find-SeElement -Driver $Cache:Driver -ClassName 'btn' | Invoke-SeClick

             Start-Sleep 3

             (Find-SeElement -Driver $Cache:Driver -Id "changer").Text | should not be $ChangerText
             (Find-SeElement -Driver $Cache:Driver -Id "sessionInfo").Text | should be "1"
         }
 
         Stop-SeDriver $Cache:Driver
         Stop-UDDashboard -Server $Server 
    }

    Context "Heading" {

        $homePage = New-UDPage -Name "Home" -Content {
            New-UDRow -Columns {
               New-UDColumn -Endpoint {
                  New-UDHeading -Text "Hello" -Size 4  -Id "Test" 
               }
            }
         } 

        $dashboard = New-UDDashboard -Title "PowerShell Universal Dashboard" -Pages $homePage

         $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
         $Cache:Driver = Start-SeFirefox
         Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

         It "has heading" {
             (Find-SeElement -Driver $Cache:Driver -Id "Test").Text | Should be "Hello"
         }
 
         Stop-SeDriver $Cache:Driver
         Stop-UDDashboard -Server $Server 
    }

    Context "Endpoint" {
        $Element = New-UDElement -Tag "div" -Id "testElement" -Endpoint {
            New-UDElement -Tag "span" -Content { "Hey!" }
        }

        $dashboard = New-UDDashboard -Title "PowerShell Universal Dashboard" -Content { $Element }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 3

        It "has content generated by endpoint" {
            (Find-SeElement -Driver $Cache:Driver -Id "testElement").Text | Should be "Hey!"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Events" {
        $dashboard = New-UDDashboard -Title "PowerShell Universal Dashboard" -Content {
            New-UDRow -Columns { 
                New-UDColumn -Size 12 -Content {
                    New-UDElement -Tag "ul" -Id "chatroom" -Attributes @{ className = "collection" }
                }
            }

            New-UDRow -Columns { 
                New-UDColumn -Size 8 -Content {
                    New-UDTextbox -Id "message" -Placeholder 'Type a chat message'
                }
                New-UDColumn -Size 2 -Content {
                    New-UDButton -Text "Send" -Id "btnSend" -onClick {
                        $message = New-UDElement -Id 'chatMessage' -Tag "li" -Attributes @{ className = "collection-item" } -Content {
                            $txtMessage = Get-UDElement -Id "message" 
                            "$(Get-Date) $User : $($txtMessage.Attributes['value'])"
                        }
                        
                        Set-UDElement -Id "message" -Attributes @{ 
                            type = "text"
                            value = ''
                            placeholder = "Type a chat message" 
                        }

                        Add-UDElement -ParentId "chatroom" -Content { $message } -Broadcast
                    }
                }

                New-UDColumn -Size 2 -Content {
                    New-UDButton -Text "Clear Message"-Id 'btnClear' -OnClick {
                        Clear-UDElement -Id "chatroom"
                    }
                }
            }
        } 
   
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should enter a chat message" {
            $MessageBox = Find-SeElement -Driver $Cache:Driver -Id 'message'
            Send-SeKeys -Element $MessageBox -Keys "Hey"

            Start-Sleep 1

            $btnSend = Find-SeElement -Driver $Cache:Driver -Id 'btnSend'
            Invoke-SeClick -Element $btnSend

            Start-Sleep 1

            (Find-SeElement -Driver $Cache:Driver -Id 'chatMessage').Text | Should BeLike "*Hey"
        }
        
        It "should clear chat messages" {
            $MessageBox = Find-SeElement -Driver $Cache:Driver -Id 'message'
            Send-SeKeys -Element $MessageBox -Keys "Hey"

            Start-Sleep 1

            $btnSend = Find-SeElement -Driver $Cache:Driver -Id 'btnSend'
            Invoke-SeClick -Element $btnSend

            Start-Sleep 1

            $btnSend = Find-SeElement -Driver $Cache:Driver -Id 'btnClear'
            Invoke-SeClick -Element $btnSend

            Start-Sleep 1

            (Find-SeElement -Driver $Cache:Driver -Id 'chatMessage').Text | Should Not BeLike "*Hey"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Element in dynamic page" {
        $HomePage= New-UDPage -url '/home' -Endpoint {
            New-UDCard -Title 'Debug' -Content {
                New-UDButton -Id "Button" -Text 'Restart' -OnClick { Set-UDElement -Id "Output1" -Content {"Clicked"}}
                New-UDHeading -Id "Output1" -Text ""
            }
        } 
        $HomePage.Name = 'Home' # So it appears in the menu
        
        $HomePage2= New-UDPage -name 'home2' -Content {
            New-UDCard -Title 'Debug' -Content {
                New-UDButton -Text 'Restart' -OnClick { Set-UDElement -Id "Output" -Content {"Clicked"}}
                New-UDHeading -Id "Output" -Text ""
            }
        } 
        
        $Dashboard = New-UDDashboard -Title 'home' -Pages $HomePage,$HomePage2

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort/home"

        Start-Sleep 2

        It "Should work in dynamic page" {
            Find-SeElement -Id "Button" -Driver $Cache:Driver | Invoke-SeClick

            Start-Sleep 1

            (Find-SeElement -Id "Output1" -Driver $Cache:Driver).Text | Should be "Clicked"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }



}
