param([Switch]$Release)

$Env:Debug = -not $Release

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
$Server = Start-UDDashboard -Port 10001 -Dashboard (New-UDDashboard -Title "Test" -Content {}) 
$Driver = Start-SeFirefox

Describe "Input" {

    Context "grid in content" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                New-UDInputAction -Content {
                    New-UDGrid -Id 'test' -Title "Grid" -Endpoint {

                    }
                }
            }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 4

        It "should include new line charts" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick $Button

            Start-Sleep 1

            Find-SeElement -Driver $Driver -Id 'test' | Should not be $null
        }
    }


    Context "textarea" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Content {
                New-UDInputField -Type 'textarea' -Name 'test'
            } -Endpoint {
                param($Test)

                $Cache:Data = $Test
            }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 4

        It "should include new line charts" {
            $Element = Find-SeElement -Id "test" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "16`r`n17`r`n18"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick $Button

            Start-Sleep 1

            $Cache:Data | should be "16`n17`n18"
        }
    }

    Context "should return the error is there is an error" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param($Test)

                throw "Noooooooooooo!"
            }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "should have shown error" {
            $Element = Find-SeElement -Name "Test" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "16"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick $Button

            Start-Sleep 1

            (Find-SeElement -ClassName 'iziToast-message' -Driver $Driver).Text | should be "Noooooooooooo!"   
        }
    }

    Context "Validation" {
        
        $Dashboard = New-UDDashboard -Title "Validation" -Content {
            New-UDRow -Columns {
                New-UDColumn -Endpoint {
                    New-UDInput -Title 'Test' -Endpoint {
                        param(
                            [Parameter(Mandatory)]
                            [UniversalDashboard.ValidationErrorMessage("The email address you entered is invalid.")]
                            [ValidatePattern('.*Rules.*')]
                            $EmailAddress,
                            [Parameter(Mandatory)]
                            $SomeOtherField
                        )
        
                    } -Validate
                }
            
            }

            New-UDInput -Id 'content' -Title 'Test2' -Endpoint {
                param(
                    [Parameter(Mandatory)]
                    [UniversalDashboard.ValidationErrorMessage("The email address you entered is invalid.")]
                    [ValidatePattern('.*Rules.*')]
                    $EmailAddress2,
                    [Parameter(Mandatory)]
                    $SomeOtherItem2,
                    [Parameter]
                    $NotRequired
                )

            } -Validate
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
    
        It "should validate with custom error message (Endpoint)" {
            $Element = Find-SeElement -Id 'EmailAddress' -Driver $Driver
            Send-SeKeys -Element $Element -Keys 'a'
            $Element = Find-SeElement -Id 'SomeOtherField' -Driver $Driver
            Invoke-SeClick -Element $Element 

            (Find-SeElement -ClassName 'fa-times-circle' -Driver $Driver) |  Get-SeElementAttribute -Attribute 'data-tooltip' | should be 'The email address you entered is invalid.'
        }

        It "should give error about required field (Endpoint)" {

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            $Element = Find-SeElement -Id 'SomeOtherField' -Driver $Driver
            Invoke-SeClick -Element $Element 
            $Element = Find-SeElement -Id 'EmailAddress' -Driver $Driver
            Invoke-SeClick -Element $Element 

            (Find-SeElement -ClassName 'fa-times-circle' -Driver $Driver) |  Get-SeElementAttribute -Attribute 'data-tooltip' | should be 'SomeOtherField is required.'
        }

        It "should validate with custom error message (Content)" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            
            $Element = Find-SeElement -Id 'EmailAddress2' -Driver $Driver
            Send-SeKeys -Element $Element -Keys 'a'
            $Element = Find-SeElement -Id 'SomeOtherItem2' -Driver $Driver
            Invoke-SeClick -Element $Element 

            (Find-SeElement -ClassName 'fa-times-circle' -Driver $Driver) |  Get-SeElementAttribute -Attribute 'data-tooltip' | should be 'The email address you entered is invalid.'
        }

        It "should give error about required field (Content)" {

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            $Element = Find-SeElement -Id 'SomeOtherItem2' -Driver $Driver
            Invoke-SeClick -Element $Element 
            $Element = Find-SeElement -Id 'EmailAddress2' -Driver $Driver
            Invoke-SeClick -Element $Element 

            (Find-SeElement -ClassName 'fa-times-circle' -Driver $Driver) |  Get-SeElementAttribute -Attribute 'data-tooltip' | should be 'SomeOtherItem2 is required.'
        }

        It "should enable submit if success" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

            $Element = Find-SeElement -Id 'EmailAddress2' -Driver $Driver
            Send-SeKeys -Element $Element -Keys 'Rules'
            $Element = Find-SeElement -Id 'SomeOtherItem2' -Driver $Driver
            Send-SeKeys -Element $Element -Keys 'Rules'

            Start-Sleep 3

            Find-SeElement -Driver $Driver -Id "btncontent" |  Get-SeElementAttribute -Attribute 'class' | Should be 'btn'
        }
    }

    Context "Custom input" {
        
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Content {
                New-UDInputField -Type 'textbox' -Name 'test' -Placeholder 'Test testbox' -DefaultValue "Test"
                New-UDInputField -Type 'checkbox' -Name 'test2' -Placeholder 'checkbox'
                New-UDInputField -Type 'select' -Name 'test3' -Placeholder 'select' -Values @("Test", "Test2", "Test3") -DefaultValue "Test"
                New-UDInputField -Type 'radioButtons' -Name 'test4' -Values @("MyTestValue", "MyTestValue2", "MyTestValue3")

                New-UDInputField -Type 'password' -Name 'test5' -Placeholder 'Password'
                New-UDInputField -Type 'textarea' -Name 'test6' -Placeholder 'Big Box o Text'
                New-UDInputField -Type 'switch' -Name 'test7' -Placeholder @("Yes", "No")
                New-UDInputField -Type 'select' -Name 'test8' -Placeholder 'select2'
                New-UDInputField -Type 'date' -Name 'test9' -Placeholder 'My Time' 
                New-UDInputField -Type 'time' -Name 'test10' -Placeholder 'My Date' 
                New-UDInputField -Type 'radioButtons' -Name 'test11' -Values @("1", "2", "3")
            } -Endpoint {
                param($Test, $Test2, $Test3, $Test4, $Test5, $Test6, $Test7, $Test8, $Test9, $Test10, $test11)

                $Cache:Output = [PSCustomObject]@{
                    test = $test
                    test2 = $test2 
                    test3 = $test3
                    test4 = $test4
                    test5 = $test5
                    test6 = $test6
                    test7 = $test7
                    test8 = $test8
                    test9 = $test9
                    test10 = $test10
                    test11 = $test11
                } 
            } 
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
    
        It "should select date" {

            $Element = Find-SeElement -Id "test9" -Driver $Driver
            $Element | Invoke-SeClick

            Start-Sleep 1

            $Element = Find-SeElement -TagName "button" -Driver $Driver | Where-Object { $_.Text -eq "20" }
            $Element | Invoke-SeClick

            $Element = Find-SeElement -ClassName "datepicker-done" -Driver $Driver
            $Element | Invoke-SeClick

            Start-Sleep 1

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test9 | Should be ((Get-Date).ToString("20-MM-yyyy"))
        }

        It "should submit textarea" {
            $Element = Find-SeElement -Name "test6" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello!!!!!!!!!!!!!!!!!!!!!!!!!"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test6 | Should be "Hello!!!!!!!!!!!!!!!!!!!!!!!!!"
        }

        It "should submit password" {
            $Element = Find-SeElement -Name "test5" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test5 | Should be "Hello"
        }

        It "should submit text" {
            $Element = Find-SeElement -Name "test" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test | Should be "TestHello"
        }

        It "should output bool" {
            $Element = Find-SeElement -Id "test2" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test2 | Should be "true"
        }

        It "should selected default value" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test3 | Should be "Test"
        }


        It "should selected value" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test3 | Should be "Test2"
        }

        
        It "should select radio button" {
            $Element = Find-SeElement -TagName "label" -Driver $Driver | Where-Object { (Get-SeElementAttribute $_ -Attribute "for") -eq 'Formtest40' }
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test4 | Should be "MyTestValue"
        }

                
        It "should select second radio button" {
            $Element = Find-SeElement -TagName "label" -Driver $Driver | Where-Object { (Get-SeElementAttribute $_ -Attribute "for") -eq 'Formtest110' }
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test11 | Should be "1"
        }

        It "should switch the switch" {
            $Element = Find-SeElement -Id "test7" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test7 | Should be "true"
        }
    }

    Context "Simple Form" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param(
                    [Parameter(HelpMessage = "My Textbox")][string]$Textbox, 
                    [Parameter(HelpMessage = "My Checkbox")][bool]$Checkbox, 
                    [Switch]$Checkbox2, 
                    [Parameter(HelpMessage = "Day of the week")]
                    [System.DayOfWeek]$DayOfWeek,
                    [Parameter(HelpMessage = "Favorite Fruit")]
                    [ValidateSet("Banana", "Apple", "Grape")]$Fruit,
                    [Parameter()]
                    [System.Security.SecureString]$SecureString,
                    [Parameter()]
                    [String[]]$ArrayOfStrings)

                $Cache:Output = [PSCustomObject]@{
                    Textbox = $Textbox
                    Checkbox = $Checkbox 
                    Checkbox2= [bool]$Checkbox2
                    DayOfWeek = $DayOfWeek
                    Vals = $Vals
                    SecureString = $SecureString
                    Strings = $ArrayOfStrings
                } 
            }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
    
        It "should output text" {
            $Element = Find-SeElement -Name "Textbox" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 2

            $Cache:Output.Textbox | Should be "Hello"
        }

        It "should have friendly label for textbox" {
            Find-SeElement -Id "Textbox" -Driver $Driver | Get-SeElementAttribute -Attribute "placeholder" | Should be "My Textbox"
        }

        It "should have friendly label for checkbox" {
            $Element = Find-SeElement -TagName 'label' -Driver $Driver | Where-Object { (Get-SeElementAttribute $_ -Attribute "for") -eq "Checkbox" }
            $Element.Text | Should be "My Checkbox"
        }
        
        It "should output bool" {
            $Element = Find-SeElement -id "Checkbox" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.Checkbox | Should be "true"
        }

        It "should output switch" {
            $Element = Find-SeElement -id "Checkbox2" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.Checkbox2 | Should be "true"
        }

        It "should output day of week" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.DayOfWeek | Should be "Monday"
        }

        It "should output vals" {
            return
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 2 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.Vals | Should be "Apple"
        }

        
        It "should output secure string" {
            $Element = Find-SeElement -Id "SecureString" -Driver $Driver 
            Send-SeKeys -Element $Element -Keys "password"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.SecureString -is [System.Security.SecureString] | Should be $true
        }

        It "should output string array" {
            $Element = Find-SeElement -Id "ArrayOfStrings" -Driver $Driver 
            Send-SeKeys -Element $Element -Keys "1`r`n2`r`n3"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.Strings[0] | Should be "1"
            $Cache:Output.Strings[1] | Should be "2"
            $Cache:Output.Strings[2] | Should be "3"
        }
    }

    Context "Different submit text" {
        
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -SubmitText "Insert" -Endpoint {
                param($Test)
            }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have different submit text" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Driver

            $Button | Should not be $null
        }
    }

    Context "clear input on toast" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Content {
                New-UDInputField -Type 'textbox' -Name 'test' -Placeholder 'Test testbox' -DefaultValue "Test"
                New-UDInputField -Type 'checkbox' -Name 'test2' -Placeholder 'checkbox'
                New-UDInputField -Type 'select' -Name 'test3' -Placeholder 'select' -Values @("Test", "Test2", "Test3") -DefaultValue "Test"
                New-UDInputField -Type 'radioButtons' -Name 'test4' -Placeholder @("My Test Value", "My Test Value 2", "My Test Value 3") -Values @("MyTestValue", "MyTestValue2", "MyTestValue3")

                New-UDInputField -Type 'password' -Name 'test5' -Placeholder 'Password'
                New-UDInputField -Type 'textarea' -Name 'test6' -Placeholder 'Big Box o Text'
                New-UDInputField -Type 'switch' -Name 'test7' -Placeholder @("Yes", "No")
            } -Endpoint {
                param($Test, $Test2, $Test3, $Test4, $Test5, $Test6, $Test7)

                New-UDInputAction -Toast "Test" -ClearInput
            } 
        }
    
        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "have cleared input on toast" {
            $Element = Find-SeElement -Id "test" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Id "test2" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Element = Find-SeElement -Id "test" -Driver $Driver
            [string]::IsNullOrEmpty($Element.Text) | Should be $true
            $Element = Find-SeElement -Id "test2" -Driver $Driver
            $Element.Selected | Should be $False
        }
    }
    
    Context "redirect to google" {
        
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -SubmitText "Insert" -Endpoint {
                param($Test)

                New-UDInputAction -RedirectUrl "https://www.google.com"
            }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "should have different submit text" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 2

            $Driver.Url.ToLower().COntains("https://www.google.com") | Should be $true 
        }
        
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
    }

    Context "Redirect after input" {
        $Dashboard = New-UDDashboard -Title "Test" -Pages @(
            New-UDPage -Name Home -Content {
                New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                    param($PageNumber)

                    New-UDInputAction -RedirectUrl "/myPage/$PageNumber"
                }
            }
            New-UDPage -Url "/myPage/:number" -Endpoint {
                param($number)

                New-UDLayout -Columns 3 -Content {
                    New-UDCard -Title "Page $number" -Id "PageCard"
                }
            }
        )

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
    

        It "should redirect to correct page" {
            $Element = Find-SeElement -Name "PageNumber" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "6"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick -Element $Button 

            $Element = Find-SeElement -Id "PageCard" -Driver $Driver
            $Element.Text | Should be "Page 6"
        }

        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
    }

    Context "Different content" {
        
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param($txtTest)

                New-UDInputAction -Content @(
                    New-UDCounter -Title Sixteen -Id "Sixteen" -Endpoint {
                        $txtTest
                    } 
                )
            }
        }
    
        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "should have different content after click" {
            $Element = Find-SeElement -Id "txtTest" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "16"

            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
            Invoke-SeClick $Button
            
            Start-Sleep 2

            $Target = Find-SeElement -Id "Sixteen" -Driver $Driver
            $Target.Text | Should be "Sixteen`r`n16"
        }
    }
}

Stop-SeDriver $Driver
Stop-UDDashboard -Server $Server 