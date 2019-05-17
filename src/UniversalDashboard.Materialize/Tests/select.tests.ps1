Describe "Select" {
    Context "onSelect" {
        Set-TestDashboard -Content {

            New-UDButton -Text "Button" -Id 'btn' -OnClick {
                $Value = (Get-UDElement -Id 'test').Attributes['value'] 

                Set-TestData -Data $Value
            }

            New-UDSelect -Label "Test" -Id 'test' -Option {
                New-UDSelectOption -Nam "Test 1" -Value "1"
                New-UDSelectOption -Nam "Test 2" -Value "2"
                New-UDSelectOption -Nam "Test 3" -Value "3"
            } -OnChange {
                Set-TestData -Data $EventData
            }
        }

        It "should select item" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select-Object -First 1
            Invoke-SeClick -Element $Element

            Start-Sleep 1
            
            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            Get-TestData | Should be "2"
        }

        It "should select item and get it with Get-UDElement" {
            $Element = Find-SeElement -ClassName "select-wrapper" -Driver $Driver | Select-Object -First 1
            Invoke-SeClick -Element $Element

            Start-Sleep 1
            
            $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
            Invoke-SeClick -Element $Element

            $Button = Find-SeElement -Driver $Driver -Id 'btn'
            Invoke-SeClick -Element $Button

            Get-TestData | Should be "2"
        }
    }
}