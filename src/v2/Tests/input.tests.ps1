Describe "New-UDInput" {
    It "should set the correct types" {
        Enter-SeUrl -Url "$Address/Test/Input1" -Target $Driver 

        $Element = Find-SeElement -Id "textbox" -Target $Driver
        Send-SeKeys -Element $Element -Keys "hello"

        $Element = Find-SeElement -Id "checkbox" -Target $Driver
        Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

        $Button = Find-SeElement -Id "btnForm1" -Target $Driver

        Invoke-SeClick $Button

        Start-Sleep 2

        $Data = Get-TestData

        $Data.checkbox | Should be "Boolean"
        $Data.textbox | should be "String"
    }

    It "should not spin forever if an item is dropped to the pipeline that isn't UDInputAction" {
        Enter-SeUrl -Url "$Address/Test/Input2" -Target $Driver 
        $Button = Find-SeElement -Id "btnForm2" -Target $Driver
        Invoke-SeClick $Button
        Find-SeElement -Id 'hello' -Target $Driver | should not be $null
    }

    Context "Test3" {
        Enter-SeUrl -Url "$Address/Test/Input3" -Target $Driver 

        It "should select date" {
            $Element = Find-SeElement -Id "test9" -Target $Driver
            $Element | Invoke-SeClick

            Start-Sleep 1

            $Element = Find-SeElement -TagName "button" -Target $Driver | Where-Object { $_.Text -eq "20" }
            $Element | Invoke-SeClick

            $Element = Find-SeElement -ClassName "datepicker-done" -Target $Driver
            $Element | Invoke-SeClick

            Start-Sleep 1

            $Button = Find-SeElement -Id "btnForm3" -Target $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test9 | Should be ((Get-Date).ToString("20-MM-yyyy"))
        }

        It "should submit textarea" {
            $Element = Find-SeElement -Name "test6" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello!!!!!!!!!!!!!!!!!!!!!!!!!"

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test6 | Should be "Hello!!!!!!!!!!!!!!!!!!!!!!!!!"
        }

        It "should submit password" {
            $Element = Find-SeElement -Name "test5" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test5 | Should be "Hello"
        }

        It "should submit text" {
            $Element = Find-SeElement -Name "test" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test | Should be "TestHello"
        }

        It "should output bool" {
            $Element = Find-SeElement -Id "test2" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test2 | Should be "true"
        }

        It "should selected default value" {
            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test3 | Should be "Test"
        }


        It "should selected value" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test3 | Should be "Test"
        }

        
        It "should select radio button" {
            $Element = Find-SeElement -TagName "label" -Driver $Driver | Where-Object { (Get-SeElementAttribute $_ -Attribute "for") -eq 'Form3test40' }
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test4 | Should be "MyTestValue"
        }

        It "should select second radio button" {
            $Element = Find-SeElement -TagName "label" -Driver $Driver | Where-Object { (Get-SeElementAttribute $_ -Attribute "for") -eq 'Form3test110' }
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test11 | Should be "1"
        }

        It "should switch the switch" {
            $Element = Find-SeElement -Id "test7" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm3" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).test7 | Should be "true"
        }
    }

    Context "Test4" {
        Enter-SeUrl -Url "$Address/Test/Input4" -Target $Driver

        It "should output text" {
            $Element = Find-SeElement -Name "Textbox" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Hello"

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver

            Invoke-SeClick -Element $Button 

            Start-Sleep 2

            Wait-Debugger

            (Get-TestData).Textbox | Should be "Hello"
        }

        It "should have friendly label for textbox" {
            $Element = Find-SeElement -TagName "label" -Driver $Driver | Where-Object { $_.Text -eq 'My Textbox' }
            $Element | Should not be $null
        }

        It "should have friendly label for checkbox" {
            $Element = Find-SeElement -TagName 'label' -Driver $Driver | Where-Object { (Get-SeElementAttribute $_ -Attribute "for") -eq "Checkbox" }
            $Element.Text | Should be "My Checkbox"
        }
        
        It "should output bool" {
            $Element = Find-SeElement -id "Checkbox" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).Checkbox | Should be "true"
        }

        It "should output switch" {
            $Element = Find-SeElement -id "Checkbox2" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).Checkbox2 | Should be "true"
        }

        It "should output day of week" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).DayOfWeek | Should be "Monday"
        }

        It "should output vals" {
            return
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 2 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).Vals | Should be "Apple"
        }

        
        It "should output secure string" {
            $Element = Find-SeElement -Id "SecureString" -Driver $Driver 
            Send-SeKeys -Element $Element -Keys "password"

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).SecureString -is [System.Security.SecureString] | Should be $true
        }

        It "should output string array" {
            $Element = Find-SeElement -Id "ArrayOfStrings" -Driver $Driver 
            Send-SeKeys -Element $Element -Keys "1`r`n2`r`n3"

            $Button = Find-SeElement -Id "btnForm4" -Driver $Driver
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Get-TestData).Strings[0] | Should be "1"
            (Get-TestData).Strings[1] | Should be "2"
            (Get-TestData).Strings[2] | Should be "3"
        }
    }
}