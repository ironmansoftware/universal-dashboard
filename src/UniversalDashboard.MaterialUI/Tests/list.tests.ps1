Describe "list" {
    Context "content" {
        Set-TestDashboard {
            New-UDList -Id 'demo-list' -Content {
                New-UDListItem -Id 'demo-list-item' -Icon (
                    New-UDIcon -Icon github -Size sm
                    ) -Label 'Item01' -SubTitle 'Item-01-Subtitle' -Content {
                    New-UDListItem -Id 'list-item-02'   -Label 'Test 02'  -SubTitle 'Test 02 subtile' -Icon (new-udicon -Icon codepen -Size sm) -OnClick (Show-UDToast -Message 'TEST 5555') -IsButton
                }
                New-UDListItem -Id 'demo-list-item1' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item011' -SubTitle 'Item-01-Subtitle' -Content {
                    New-UDListItem -Id 'list-item-03'   -Label 'Test 022'  -SubTitle 'Test 02 subtile' -Icon (new-udicon -Icon codepen -Size sm) -IsButton -OnClick (
                        Show-UDToast -Message 'demo'
                    )
                }
                New-UDListItem -Id 'demo-list-item15' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item0121' -SubTitle 'Item-01-Subt2itle' -IsButton -OnClick {
                    Show-UDToast -Message 'demo'
                }

            }
        }

        It 'has content' {
            Find-SeElement -Id 'demo-list' -Driver $Driver | should not be $null
        }
    }
}