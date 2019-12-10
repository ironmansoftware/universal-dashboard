Describe "Textbox" {

    Context "textbox no value" {
        Set-TestDashboard -Content {
            New-UDTextbox -Id 'EndTimestamp' -Label 'EndTimestamp'   
        }
        It "should not be active" {
            Find-SeElement -ClassName 'active' -Driver $Driver | should be $null
        }
    }

    Context "textbox value" {
        Set-TestDashboard -Content {
            New-UDTextbox -Id 'EndTimestamp' -Label 'EndTimestamp' -Value (Get-Date).ToString('yyyy.MM.dd HH:mm:ss.fff')  
        }
        It "should be active" {
            Find-SeElement -ClassName 'active' -Driver $Driver | should be $true
        }
    }

    Context "textbox placeholder" {
        Set-TestDashboard -Content {
            New-UDTextbox -Id 'EndTimestamp' -Label 'EndTimestamp' -Placeholder (Get-Date).ToString('yyyy.MM.dd HH:mm:ss.fff')  
        }
        It "should be active" {
            Find-SeElement -ClassName 'active' -Driver $Driver | should be $true
        }
    }
}