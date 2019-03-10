Describe "list" {
    Context "content" {
        Set-TestDashboard {

            $PaperStyle = @{ backgroundColor = 'darkslateblue'}
            $ItemStyle = @{ backgroundColor = '#fff'; marginTop = '8px' } 
            $NestedItemStyle = @{ backgroundColor = '#f8f8f8'}

            New-UDPaper -Elevation 0 -Content {

                New-UDList -Id 'demo-list' -Content {
    
                    New-UDListItem -Id 'list-item' -AvatarSource 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {
    
                        New-UDListItem -Id 'list-item-security' -Label 'username and passwords' -Style $NestedItemStyle
                        New-UDListItem -Id 'list-item-api' -Label 'api keys' -Style $NestedItemStyle
    
                    } -Style $ItemStyle
    
                    New-UDListItem -Id 'list-item' -Label 'Alon Gvili' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -Content {
    
                        New-UDListItem -Id 'list-item-inbox-new' -Label 'New Messages' -SubTitle 'You have 5 new messages.' -Style $NestedItemStyle
                        New-UDListItem -Id 'list-item-inbox-unread' -Label 'Unread Messages' -SubTitle 'You have alot of unread messages.' -Style $NestedItemStyle
    
                    } -Style $ItemStyle

                    New-UDListItem -Id 'list-item' -Label 'Alon Gvili' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -IsButton -OnClick {
                        Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                    } -Style $ItemStyle

                    New-UDListItem -Id 'list-item' -Label 'Go to my github page' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -SecondaryAction { 
                        
                        New-UDIconButton -Icon (New-UDIcon -Icon user -Size xs -Color '#8bc34a') -OnClick {
                        
                            Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                        
                        } -Style @{marginRight = 0}

                    } -Style $ItemStyle 

                    New-UDListItem -Id 'list-item' -Label 'List item with metadata on the right' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -SecondaryAction { 
                        
                        New-UDEndpoint -Endpoint {
                            New-UDParagraph -Text (Get-Date).ToShortTimeString() -Color '#000'
                        } -Schedule (New-UDEndpointSchedule -Every 1 -Second)

                    } -Style $ItemStyle 

                    New-UDListItem -Id 'list-item' -Label 'Universal Dashboard' -AvatarSource 'https://avatars1.githubusercontent.com/u/34902941?s=200&v=4' -SubTitle 'PowerShell Module For Creating Dashboards & WebSites' -Content {
    
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

        It 'has content' {
            Find-SeElement -Id 'demo-list' -Driver $Driver | should not be $null
        }

        It 'has 5 list items' {
            (Find-SeElement -Id 'list-item' -Driver $Driver).count | should be 5
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

                    New-UDListItem -Id 'list-item' -Label 'List item with metadata on the right' -AvatarSource 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -SecondaryAction { 
                        new-udelement -tag 'p' -Endpoint {(get-date -Format "HH:mm:ss")} -AutoRefresh -RefreshInterval 1 -Attributes @{
                            style = @{fontSize = 12; fontWeight = 600; color = '#c5c5c5'; marginRight = 12}
                        }
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

        $element = Find-SeElement -Id 'demo-list' -Driver $Driver
        $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
        $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()

        It 'has background color of (rgb(236, 236, 236))' {
            $element.GetCssValue('background-color') | should be 'rgb(236, 236, 236)'
        }

        It 'has box-shadow ( drop shadow )' {
            $element.GetCssValue('box-shadow') | should be 'rgba(0, 0, 0, 0.2) 0px 1px 5px 0px, rgba(0, 0, 0, 0.14) 0px 2px 2px 0px, rgba(0, 0, 0, 0.12) 0px 3px 1px -2px'
        }

        It 'has padding right of 8px' {
            $element.GetCssValue('padding-right') | should be '8px'
        }

        It 'has padding left of 8px' {
            $element.GetCssValue('padding-left') | should be '8px'
        }
    }
}