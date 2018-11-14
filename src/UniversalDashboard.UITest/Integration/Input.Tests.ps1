param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Input" {

    Context "should return the error is there is an error" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param($Test)

                throw "Noooooooooooo!"
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
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

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Validation" {
        $dashboard = New-UDDashboard -Title "Validation" -Content {
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

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox

        It "should validate with custom error message (Endpoint)" {
            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

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

            Start-Sleep 1

            Find-SeElement -Driver $Driver -Id "btncontent" |  Get-SeElementAttribute -Attribute 'class' | Should be 'btn'
        }

        
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Custom input" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Content {
                New-UDInputField -Type 'textbox' -Name 'test' -Placeholder 'Test testbox' -DefaultValue "Test"
                New-UDInputField -Type 'checkbox' -Name 'test2' -Placeholder 'checkbox'
                New-UDInputField -Type 'select' -Name 'test3' -Placeholder 'select' -Values @("Test", "Test2", "Test3") -DefaultValue "Test"
                New-UDInputField -Type 'radioButtons' -Name 'test4' -Placeholder @("My Test Value", "My Test Value 2", "My Test Value 3") -Values @("MyTestValue", "MyTestValue2", "MyTestValue3")

                New-UDInputField -Type 'password' -Name 'test5' -Placeholder 'Password'
                New-UDInputField -Type 'textarea' -Name 'test6' -Placeholder 'Big Box o Text'
                New-UDInputField -Type 'switch' -Name 'test7' -Placeholder @("Yes", "No")
                New-UDInputField -Type 'select' -Name 'test8' -Placeholder 'select'
                New-UDInputField -Type 'date' -Name 'test9' -Placeholder 'My Time' 
                #New-UDInputField -Type 'time' -Name 'test10' -Placeholder 'My Date' 
            } -Endpoint {
                param($Test, $Test2, $Test3, $Test4, $Test5, $Test6, $Test7, $Test8, $Test9, $Test10)

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
                   # test10 = $test10
                } 
            } 
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should select date" {

            $Element = Find-SeElement -Id "test9" -Driver $Cache:Driver
            $Element | Invoke-SeClick

            Start-Sleep 1

            $Element = Find-SeElement -TagName "div" -Driver $Cache:Driver | Where { $_.Text -eq "20" }
            $Element | Invoke-SeClick

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test9 | Should be ((Get-Date).ToString("20-MM-yyyy"))
        }

        It "should submit textarea" {
            $Element = Find-SeElement -Name "test6" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello!!!!!!!!!!!!!!!!!!!!!!!!!"

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test6 | Should be "Hello!!!!!!!!!!!!!!!!!!!!!!!!!"
        }

        It "should submit password" {
            $Element = Find-SeElement -Name "test5" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test5 | Should be "Hello"
        }

        It "should submit text" {
            $Element = Find-SeElement -Name "test" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test | Should be "TestHello"
        }

        It "should output bool" {
            $Element = Find-SeElement -Name "test2" -Driver $Cache:Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Cache:Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test2 | Should be "true"
        }

        It "should selected default value" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test3 | Should be "Test"
        }


        It "should selected value" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Cache:Driver | Select -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test3 | Should be "Test2"
        }

        
        It "should select radio button" {
            $Element = Find-SeElement -TagName "label" -Driver $Cache:Driver | Where { (Get-SeElementAttribute $_ -Attribute "for") -eq 'MyTestValue2' }
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test4 | Should be "MyTestValue2"
        }

        It "should switch the switch" {
            $Element = Find-SeElement -Name "test7" -Driver $Cache:Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Cache:Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Cache:Output.test7 | Should be "true"
        }


        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "input and monitor" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param()

                New-UDInputAction -Toast "Test"
            }
            New-UDMonitor -Title "test" -RefreshInterval 1 -Endpoint {
                Get-Random -Maximum 10 -Minimum 1 | Out-UDMonitorData
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should not clear monitor after input" {

            Sleep 5

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick $Button

            Sleep 2
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Simple Form" {
        $tempDir = [System.IO.Path]::GetTempPath()
        $tempFile = Join-Path $tempDir "output.txt"

        if ((Test-path $tempFile)) {
            Remove-Item $tempFile -Force
        }

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param(
                    [Parameter(HelpMessage = "My Textbox")][string]$Textbox, 
                    [Parameter(HelpMessage = "My Checkbox")][bool]$Checkbox, 
                    [Switch]$Checkbox2, 
                    [Parameter(HelpMessage = "Day of the week")]
                    [System.DayOfWeek]$DayOfWeek,
                    [Parameter(HelpMessage = "Favorite Fruit")]
                    [ValidateSet("Banana", "Apple", "Grape")]$Fruit)

                $tempDir = [System.IO.Path]::GetTempPath()
                $tempFile = Join-Path $tempDir "output.txt"

                if ((Test-path $tempFile)) {
                    Remove-Item $tempFile -Force
                }

                [PSCustomObject]@{
                    Textbox = $Textbox
                    Checkbox = $Checkbox 
                    Checkbox2 = [bool]$Checkbox2
                    DayOfWeek = $DayOfWeek
                    Vals = $Vals
                } | ConvertTo-Json | Out-File -FilePath $tempFile
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should output text" {
            $Element = Find-SeElement -Name "Textbox" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 2

            $Output = Get-Content -Path $tempFile | ConvertFrom-Json 

            $Output.Textbox | Should be "Hello"
        }

        It "should have friendly label for textbox" {
            $Element = Find-SeElement -Id "Textboxlabel" -Driver $Cache:Driver
            $Element.Text | Should be "My Textbox"
        }

        It "should have friendly label for checkbox" {
            $Element = Find-SeElement -Id "Checkboxlabel" -Driver $Cache:Driver
            $Element.Text | Should be "My Checkbox"
        }
        
        It "should output bool" {
            $Element = Find-SeElement -Name "Checkbox" -Driver $Cache:Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Cache:Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Output = Get-Content -Path $tempFile | ConvertFrom-Json 

            $Output.Checkbox | Should be "true"
        }

        It "should output switch" {
            $Element = Find-SeElement -Name "Checkbox2" -Driver $Cache:Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Cache:Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Output = Get-Content -Path $tempFile | ConvertFrom-Json 

            $Output.Checkbox2 | Should be "true"
        }

        It "should output day of week" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Cache:Driver | Select -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Output = Get-Content -Path $tempFile | ConvertFrom-Json 

            $Output.DayOfWeek | Should be "1"
        }

        It "should output vals" {
            return
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Cache:Driver | Select -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 2 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Output = Get-Content -Path $tempFile | ConvertFrom-Json 

            $Output.Vals | Should be "Apple"
        }

       Stop-SeDriver $Cache:Driver
       Stop-UDDashboard -Server $Server 
    }

    Context "Different submit text" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -SubmitText "Insert" -Endpoint {
                param($Test)
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should have different submit text" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver

            $Button | Should not be $null
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "clear input on toast" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
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

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "have cleared input on toast" {
            $Element = Find-SeElement -Name "test" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Element = Find-SeElement -Name "test2" -Driver $Cache:Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Cache:Driver

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            $Element = Find-SeElement -Name "test" -Driver $Cache:Driver
            [string]::IsNullOrEmpty($Element.Text) | Should be $true
            $Element = Find-SeElement -Name "test2" -Driver $Cache:Driver
            $Element.Selected | Should be $False
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }
    
    Context "redirect to google" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -SubmitText "Insert" -Endpoint {
                param($Test)

                New-UDInputAction -RedirectUrl "https://www.google.com"
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should have different submit text" {
            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 2

            $Cache:Driver.Url.ToLower().COntains("https://www.google.com") | Should be $true 
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Redirect after input" {
        $dashboard = New-UDDashboard -Title "Test" -Pages @(
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

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should redirect to correct page" {
            $Element = Find-SeElement -Name "PageNumber" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "6"

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
            Invoke-SeClick -Element $Button 

            $Element = Find-SeElement -Id "PageCard" -Driver $Cache:Driver
            $Element.Text | Should be "Page 6"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Different content" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDInput -Title "Simple Form" -Id "Form" -Endpoint {
                param($Test)

                New-UDInputAction -Content @(
                    New-UDCounter -Title Sixteen -Id "Sixteen" -Endpoint {
                        $Test
                    }
                )
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "should have different content after click" {
            $Element = Find-SeElement -Name "Test" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "16"

<<<<<<< HEAD
            Start-Sleep 1

            $Button = Find-SeElement -Id "btnForm" -Driver $Cache:Driver
=======
            $Button = Find-SeElement -Id "btnForm" -Driver $Driver
>>>>>>> 9c36d039b213638e88602bad9f85f48302740b47
            Invoke-SeClick $Button
            
            Start-Sleep 2

            $Target = Find-SeElement -Id "Sixteen" -Driver $Cache:Driver
            $Target.Text | Should be "Sixteen`r`n16"
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server 
    }


}