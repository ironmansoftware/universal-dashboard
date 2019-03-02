Describe "list" {
    Context "content" {
        Set-TestDashboard {
            New-UDList -Id 'demo-list' -Content {
                New-UDListItem -Id 'item1' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item01' -SubTitle 'Item-01-Subtitle' -IsButton -OnClick {
                    Show-UDToast -Message 'demo'
                } -Divider
                New-UDListItem -Id 'item2' -Icon (New-UDIcon -Icon gitlab -Size sm) -Label 'Item02' -SubTitle 'Item-02-Subtitle' -Divider -Content {
                    New-UDListItem -Id 'subitem2' -Icon (New-UDIcon -Icon git -Size sm) -Label 'Item03' -SubTitle 'Item-03-Subtitle' -Divider
                }
                New-UDListItem -Id 'item4' -Icon (New-UDIcon -Icon gitlab -Size sm) -Label 'Item04' -SubTitle 'Item-04-Subtitle' -Divider -Content {
                    New-UDListItem -Id 'subitem4' -Icon (New-UDIcon -Icon git -Size sm) -Label 'Item05' -SubTitle 'Item-05-Subtitle' -Divider -Content {
                        New-UDListItem -Id 'subitem6' -Icon (New-UDIcon -Icon codepen -Size sm) -Label 'Item06' -SubTitle 'Item-06-Subtitle' -Divider
                    }
                }
            } -SubHeader 'Git Services'
        }

        It 'has content' {
            Find-SeElement -Id 'demo-list' -Driver $Driver | should not be $null
        }
    }
}