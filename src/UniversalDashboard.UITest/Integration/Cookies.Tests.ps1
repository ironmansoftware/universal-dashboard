param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Cookies" {
    Context "Set cookies" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDInput -Id "Input" -Title "Input Cookie" -Endpoint {
                param([string]$Name, [string]$Value)

                Set-UDCookie -Name $Name -Value $Value
            }
            
            New-UDInput -Id "Counter" -SubmitText "SetCookie" -Endpoint {
                param() 

                $Cookie = Get-UDCookie -Name "Test"

                New-UDInputAction -Content @(
                    New-UDHTML -Markup "<span class=myCookieValue>$($Cookie.Value)</span>"
                )
            }
            New-UDInput -Id "RemoveCookie" -SubmitText "Remove Cookie" -Endpoint {
                param() 

                Remove-UDCookie -Name "Hello"

                New-UDInputAction -Toast "Cookie removed"
            }
        }))') -SessionVariable ss -ContentType 'text/plain'

        $Cache:Driver.navigate().refresh()

        Remove-SeCookie -Driver $Cache:Driver
        
        Set-SeCookie -Drive $Cache:Driver -Name "Test" -Value "CookieValue"

        It "should have set cookie" {
            $Element = Find-SeElement -Name "Name" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Name "Value" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Adam"

            $Button = Find-SeElement -LinkText "SUBMIT" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            Get-SeCookie $Cache:Driver | Where Name -eq "Hello" | Select -Expand Value | Should be "Adam"
        }

        It "should get cookie" {
            $Button = Find-SeElement -LinkText "SETCOOKIE" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $element = Find-SeElement -Driver $Cache:Driver -ClassName "myCookieValue"
            $element.Text | Should be "CookieValue"
        }

        It "should remove cookie"  {
            $Element = Find-SeElement -Name "Name" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Name "Value" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Adam"

            $Button = Find-SeElement -LinkText "SUBMIT" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            $Button = Find-SeElement -LinkText "REMOVE COOKIE" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 
            
            Start-Sleep 1

            Get-SeCookie $Cache:Driver | Where Name -eq "Hello" | Should be $null
        }
    }
}