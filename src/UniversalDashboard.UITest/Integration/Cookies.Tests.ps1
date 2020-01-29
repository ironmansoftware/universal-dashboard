param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Cookies" {
    Context "Set cookies" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Id "Input" -Title "Input Cookie" -Endpoint {
                param([string]$Name, [string]$Value)

                Set-UDCookie -Name $Name -Value $Value
            }
            
            New-UDInput -Id "Counter" -SubmitText "SetCookie" -Endpoint {
                param() 

                $Cookie = Get-UDCookie -Name "Test"

                New-UDInputAction -Content @(
                    New-UDHTML -Markup "<span class='myCookieValue'>$($Cookie.Value)</span>"
                )
            }
            New-UDInput -Id "RemoveCookie" -SubmitText "Remove Cookie" -Endpoint {
                param() 

                Remove-UDCookie -Name "Hello"

                New-UDInputAction -Toast "Cookie removed"
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Remove-SeCookie -DeleteAllCookies -Target $Driver
        
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        Set-SeCookie -Target $Driver -Name "Test" -Value "CookieValue"

        It "should have set cookie" {
            $Element = Find-SeElement -Name "Name" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Name "Value" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Adam"

            $Button = Find-SeElement -LinkText "SUBMIT" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            Get-SeCookie $Driver | Where-Object Name -eq "Hello" | Select-Object -Expand Value | Should be "Adam"
        }

        It "should get cookie" {
            $Button = Find-SeElement -LinkText "SETCOOKIE" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $element = Find-SeElement -Driver $Driver -ClassName "myCookieValue"
            $element.Text | Should be "CookieValue"
        }

        It "should remove cookie"  {
            $Element = Find-SeElement -Name "Name" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Name "Value" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Adam"

            $Button = Find-SeElement -LinkText "SUBMIT" -Driver $Driver
            Invoke-SeClick -Element $Button 

            $Button = Find-SeElement -LinkText "REMOVE COOKIE" -Driver $Driver
            Invoke-SeClick -Element $Button 
            
            Start-Sleep 1

            Get-SeCookie $Driver | Where-Object Name -eq "Hello" | Should be $null
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}

