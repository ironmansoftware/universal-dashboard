param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1" -Force 

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

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
        Remove-SeCookie -Driver $Driver
        
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        Set-SeCookie -Drive $Driver -Name "Test" -Value "CookieValue"

        It "should have set cookie" {
            $Element = Find-SeElement -Name "Name" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Name "Value" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Adam"

            $Button = Find-SeElement -LinkText "Submit" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            Get-SeCookie $Driver | Where Name -eq "Hello" | Select -Expand Value | Should be "Adam"
        }

        It "should get cookie" {
            $Button = Find-SeElement -LinkText "SetCookie" -Driver $Driver
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

            $Button = Find-SeElement -LinkText "Submit" -Driver $Driver
            Invoke-SeClick -Element $Button 

            $Button = Find-SeElement -LinkText "Remove Cookie" -Driver $Driver
            Invoke-SeClick -Element $Button 
            
            Start-Sleep 1

            Get-SeCookie $Driver | Where Name -eq "Hello" | Should be $null
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}