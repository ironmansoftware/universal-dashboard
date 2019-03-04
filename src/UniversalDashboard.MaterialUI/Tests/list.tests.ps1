Describe "list" {
    Context "content" {
        Set-TestDashboard {
            New-UDList -Id 'demo-list' -Content {
                New-UDListItem -Id 'item1' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item01' -SubTitle 'Item-01-Subtitle' -IsButton -OnClick {
                    Show-UDToast -Message 'demo'
                } 
                New-UDListItem -Id 'item2' -Icon (New-UDIcon -Icon gitlab -Size sm) -Label 'Item02' -SubTitle 'Item-02-Subtitle'  -Content {
                    New-UDListItem -Id 'subitem2' -Icon (New-UDIcon -Icon git -Size sm) -Label 'Item03' -SubTitle 'Item-03-Subtitle' 
                }
                New-UDListItem -Id 'item4' -Icon (New-UDIcon -Icon gitlab -Size sm) -Label 'Item04' -SubTitle 'Item-04-Subtitle'  -Content {
                    New-UDListItem -Id 'subitem4' -Icon (New-UDIcon -Icon git -Size sm) -Label 'Item05' -SubTitle 'Item-05-Subtitle'  -Content {
                        New-UDListItem -Id 'subitem6' -Icon (New-UDIcon -Icon codepen -Size sm) -Label 'Item06' -SubTitle 'Item-06-Subtitle' 
                    }
                }
            } -SubHeader 'Git Services'
        }

        It 'has content' {
            Find-SeElement -Id 'demo-list' -Driver $Driver | should not be $null
        }
    }
    Context "style" {
        Set-TestDashboard {
            New-UDList -Id 'demo-list' -Content {
                New-UDListItem -Id 'item1' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item01' -SubTitle 'Item-01-Subtitle' -Style @{
                    backgroundColor = '#fff'
                }
                New-UDListItem -Id 'item2' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item02' -SubTitle 'Item-02-Subtitle'  -Style @{
                    backgroundColor = '#fff'
                } 
                New-UDListItem -Id 'subitem3' -Icon (New-UDIcon -Icon git -Size sm) -Label 'Item03' -SubTitle 'Item-03-Subtitle'  -Content {
                    
                        New-UDListItem -Id 'subitem4' -Icon (New-UDIcon -Icon codepen -Size sm) -Label 'Item04' -SubTitle 'Item-04-Subtitle' -Style @{
                            backgroundColor = '#ececec'
                        } -Content {
                            New-UDListItem -Id 'subitem5'  -Label 'Item05' -SubTitle 'Item-05-Subtitle' -Style @{
                                backgroundColor = '#ececec'
                            } -SecondaryAction {
                                New-UDIconButton -Icon (New-UDIcon -Icon code -Size xs -FixedWidth -Color "primary") -OnClick {
                                    Show-UDToast -Message 'Test'
                                }
                            }
                            New-UDListItem -Id 'subitem6' -Label 'Item06' -SubTitle 'Item-05-Subtitle' -Style @{
                                backgroundColor = '#ececec'
                            } 
                            New-UDListItem -Id 'subitem7' -Label 'Item07' -SubTitle 'Item-05-Subtitle' -Style @{
                                backgroundColor = '#ececec'
                            } -Content {
                                New-UDListItem -Id 'subitem8'  -Label 'Item08' -SubTitle 'Item-05-Subtitle' -Style @{
                                    backgroundColor = '#ececec'
                                }
                                New-UDListItem -Id 'subitem9' -Label 'Item09' -SubTitle 'Item-05-Subtitle' -Style @{
                                    backgroundColor = '#ececec'
                                } 
                            }
                        }
                        New-UDListItem -Id 'subitem10' -Icon (New-UDIcon -Icon codepen -Size sm) -Label 'Item010' -SubTitle 'Item-10-Subtitle' -Style @{
                            backgroundColor = '#ececec'
                        }
                } -Style @{
                    backgroundColor = '#fff'
                }
            } -SubHeader 'Git Services' -Style @{
                backgroundColor = '#90caf9'
            }
        }

        It 'has background color of #90caf9 (rgb(144, 202, 249))' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $style.Split(':')[1].trim().replace(';','') | should be 'rgb(144, 202, 249)'
        }
    }
}