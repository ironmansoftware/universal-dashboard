Describe "list" {
    Context "content" {

        Set-TestDashboard {

            $PaperStyle = @{ backgroundColor = 'darkslateblue'}
            $ItemStyle = @{ backgroundColor = '#fff'; marginTop = '8px' } 
            $NestedItemStyle = @{ backgroundColor = '#f8f8f8'}

            New-UDMuPaper -Elevation 0 -Content {

                New-UDMuList -Id 'demo-list' -Content {
    
                    New-UDMuListItem -Id 'list-item' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {
    
                        New-UDMuListItem -Id 'list-item-security' -Label 'username and passwords' -Style $NestedItemStyle
                        New-UDMuListItem -Id 'list-item-api' -Label 'api keys' -Style $NestedItemStyle
    
                    } -Style $ItemStyle
    
                    New-UDMuListItem -Id 'list-item' -Label 'Alon Gvili' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -Content {
    
                        New-UDMuListItem -Id 'list-item-inbox-new' -Label 'New Messages' -SubTitle 'You have 5 new messages.' -Style $NestedItemStyle
                        New-UDMuListItem -Id 'list-item-inbox-unread' -Label 'Unread Messages' -SubTitle 'You have alot of unread messages.' -Style $NestedItemStyle
    
                    } -Style $ItemStyle

                    New-UDMuListItem -Id 'list-item' -Label "Alon Gvili" -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -IsButton -OnClick {
                        Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                    } -Style $ItemStyle
                    New-UDMuListItem -Id 'list-item' -Label "Alon Gvili" -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -IsButton -OnClick {
                        Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                    } -Style $ItemStyle
                    New-UDMuListItem -Id 'list-item' -Label "Alon Gvili" -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -IsButton -OnClick {
                        Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                    } -Style $ItemStyle


                } -SubHeader "USERS  $(0..50 | get-random)" -Style @{
                    backgroundColor = '#ececec'
                    paddingLeft = '8px'
                    paddingRight = '8px'
                    boxShadow = "0px 1px 5px 0px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 3px 1px -2px rgba(0,0,0,0.12)"
                }

               
            } -IsEndPoint -AutoRefresh

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


                New-UDMuList -Id 'demo-list' -Content {
    
                    New-UDMuListItem -Id 'list-item-user' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {
    
                        New-UDMuListItem -Id 'list-item-security' -Label 'username and passwords' -Style $NestedItemStyle
                        New-UDMuListItem -Id 'list-item-api' -Label 'api keys' -Style $NestedItemStyle
    
                    } -Style $ItemStyle
    
                } -SubHeader 'USERS' -Style @{
                    backgroundColor = '#ececec'
                    paddingLeft = '8px'
                    paddingRight = '8px'
                    boxShadow = "0px 1px 5px 0px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 3px 1px -2px rgba(0,0,0,0.12)"
                }
        }


        It 'has background color of (rgb(236, 236, 236))' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()
    
            $element.GetCssValue('background-color') | should be 'rgb(236, 236, 236)'
        }

        It 'has box-shadow ( drop shadow )' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()
    
            $element.GetCssValue('box-shadow') | should be 'rgba(0, 0, 0, 0.2) 0px 1px 5px 0px, rgba(0, 0, 0, 0.14) 0px 2px 2px 0px, rgba(0, 0, 0, 0.12) 0px 3px 1px -2px'
        }

        It 'has padding right of 8px' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()
    
            $element.GetCssValue('padding-right') | should be '8px'
        }

        It 'has padding left of 8px' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $StyleValues = ($style -replace '(\w+[-]\w+): ' -split ';').trim()
    
            $element.GetCssValue('padding-left') | should be '8px'
        }
    }
}