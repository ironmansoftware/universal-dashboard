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

            $PaperStyle = @{ backgroundColor = 'darkslateblue'}
            $ItemStyle = @{ backgroundColor = '#fff'; marginTop = '8px' } 
            $NestedItemStyle = @{ backgroundColor = '#f8f8f8'}

            New-UDPaper -Elevation 0 -Content {

                New-UDList -Id 'demo-list' -Content {
    
                    New-UDListItem -Id 'list-item-user' -AvatarSource 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {
    
                        New-UDListItem -Id 'list-item-security' -Label 'username and passwords' -Style $NestedItemStyle
                        New-UDListItem -Id 'list-item-api' -Label 'api keys' -Style $NestedItemStyle
    
                    } -Style $ItemStyle
    
                    New-UDListItem -Id 'list-item-user' -Label 'Alon Gvili' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -Content {
    
                        New-UDListItem -Id 'list-item-inbox-new' -Label 'New Messages' -SubTitle 'You have 5 new messages.' -Style $NestedItemStyle
                        New-UDListItem -Id 'list-item-inbox-unread' -Label 'Unread Messages' -SubTitle 'You have alot of unread messages.' -Style $NestedItemStyle
    
                    } -Style $ItemStyle

                    New-UDListItem -Id 'list-item-asbutton' -Label 'Alon Gvili' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -IsButton -OnClick {
                        Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                    } -Style $ItemStyle

                    New-UDListItem -Id 'list-item-with-iconbutton' -Label 'Go to my github page' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -SecondaryAction { 
                        
                        New-UDIconButton -Icon (New-UDIcon -Icon user -Size xs -Color '#8bc34a') -OnClick {
                        
                            Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                        
                        } -Style @{marginRight = 0}

                    } -Style $ItemStyle 

                    New-UDListItem -Id 'list-item-ud' -Label 'Universal Dashboard' -AvatarSource 'https://avatars1.githubusercontent.com/u/34902941?s=200&v=4' -SubTitle 'PowerShell Module For Creating Dashboards & WebSites' -Content {
    
                        New-UDPaper -Content {

                            New-UDHtml -Markup '<iframe width="560" height="315" src="https://www.youtube.com/embed/3ilV86JemjA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'

                        } -Style @{backgroundColor = '#f8f8f8'; margin = 0} -Elevation 0
    
                    } -Style $ItemStyle

                } -SubHeader 'USERS' -Style @{
                    backgroundColor = '#ececec'
                    paddingLeft = '8px'
                    paddingRight = '8px'
                    boxShadow = "0px 1px 5px 0px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 3px 1px -2px rgba(0,0,0,0.12)"
                }

            } 

        }

        It 'has background color of #90caf9 (rgb(144, 202, 249))' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $style.Split(':')[1].trim().replace(';','') | should be 'rgb(144, 202, 249)'
        }
    }
}