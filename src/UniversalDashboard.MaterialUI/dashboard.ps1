New-UDDashboard -Title "Dashboard" -Theme (get-udtheme basic) -Pages @(

    New-UDPage -Name 'AppBar' -Content {

        $Drawer = New-UDDrawer -Id 'drawer' -Children {
            New-UDList -Content {
                New-UDListItem -Id 'lstHome' -Label 'Home' -OnClick { 
                    Set-TestData 'Home'
                 } -Content {
                     New-UDListItem -Id 'lstNested' -Label 'Nested' -OnClick {
                        Set-TestData 'Nested'
                     }
                 } 
            }
        }

        New-UDElement -Tag 'main' -Content {
            New-UDAppBar -Children { New-UDTypography -Text 'Hello' -Paragraph } -Position relative -Drawer $Drawer
        }
    }

    New-UDPage -Name 'Autocomplete' -Content {
        New-UDAutocomplete -Id 'autoComplete' -Options @('Test', 'Test2', 'Test3', 'Test4') -OnChange {
            Set-TestData $Body 
        }

        New-UDAutocomplete -Id 'autoCompleteDynamic' -OnLoadOptions { 
            @('Test', 'Test2', 'Test3', 'Test4') | Where-Object { $_ -match $Body } | ConvertTo-Json
        } -OnChange {
            Set-TestData $Body 
        }
    }

    New-UDPage -Name "Avatar" -Content {
        New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarContent' -Variant small

        New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarStyle' -Variant medium

        $AvatarProps = @{
            Image = 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
            Alt = 'alon gvili avatar'
            Id = 'avatarSquare'
            variant = 'large'
        }
        New-UDAvatar @AvatarProps 
    }

    New-UDPage -Name 'Blank' -Blank -Content {
        New-UDCard -Id 'SimpleCard' -Title "Hey" -Content { 
            "Content" 
        } -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
    }

    New-UDPage -Name "Button" -Content {

        New-UDButton -Text 'Submit' -Id 'btnDefault' 

        New-UDButton -Text 'Submit' -Id 'btnFullWidth' -FullWidth

        New-UDButton -Text 'Submit' -Id 'btnText' -variant text

        New-UDButton -Text 'Submit' -Id 'btnLabel'

        New-UDButton -Text 'Submit' -Id 'btnOutlined' -variant outlined

        New-UDButton -Text 'Submit' -Id 'btnSmall' -size small

        New-UDButton -Text 'Submit' -Id 'btnMedium' -size medium

        New-UDButton -Text 'Submit' -Id 'btnLarge' -size large

        $Icon = New-UDIcon -Icon 'github'
        New-UDButton -Text "Submit" -Id "btnIcon" -Icon $Icon -OnClick {Show-UDToast -Message 'test'}  

        $Icon = New-UDIcon -Icon 'github'
        New-UDButton -Text "Submit" -Id "btnClick" -Icon $Icon -OnClick {
            Set-TestData -Data "OnClick"
        }
    }

    New-UDPage -Name 'Card' -Content {

        New-UDCard -Id 'SimpleCard' -Title "Hey" -Content { 
            "Content" 
        } -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'

        # $ToolBarProps = @{
        #     # icon        = New-UDIcon -Icon server -Size lg -FixedWidth -Style @{color = '#000'} 
        #     Style       = @{backgroundColor = '#fff'; color = '#000';flexGrow = 1}
        #     Content     = {New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Style @{ color = '#000'}) -OnClick {Show-UDToast -Message 'test'}}
        #     Title       = New-UDTypography -Variant h5 -Text 'Universal Dashboard'
        #     ShowButtons = $false
        #     Id = 'toolbar'
        # }
        # $ToolBar = New-UDCardToolbar @ToolBarProps

        # $HeaderProps = @{
        #     Style = @{backgroundColor = '#bbdefb'; display = 'flex'; flexDirection = 'row'}
        #     Content = {
        #         New-UDCardMedia -Component video -Source "http://media.w3.org/2010/05/bunny/movie.mp4" 
        #     }
        #     IsEndPoint = $false 
        #     AutoRefresh = $false
        #     RefreshInterval = 6
        #     Id = 'header'
        # }
        # $Header = New-UDCardHeader  @HeaderProps

        # $BodyProps = @{
        #     Style = @{backgroundColor = '#fff'; justifyContent = "center"}
        #     Content = {
        #         New-UDTypography -Variant h3 -Text "$(get-date -Format 'HH:mm:ss')" -Style @{ color = '#000' } -Align center
        #     }
        #     IsEndPoint = $true 
        #     AutoRefresh = $true
        #     RefreshInterval = 1
        #     Id = 'body'
        # }
        # $Body = New-UDCardBody @BodyProps
            
        # $Expand = New-UDCardExpand -Style @{backgroundColor = '#f8f8f8'; color = '#000'; justifyContent = "center"} -Content {
        #     New-UDTypography -Variant h2 -Text "YOU EXPAND ME!" -Style @{ color = '#000'; margin = '40px' } -Align center
        # } -Id 'expand'


        # $Footer = New-UDCardFooter -Id 'footer' -Style @{backgroundColor = '#fff'; color = '#000'; justifyContent = "center"} -Content {
            
        #     $ButtonStyle = @{color = '#fff'}
        #     $Icons = @(
        #         New-UDIcon -Icon github -Size lg -Style $ButtonStyle
        #         New-UDIcon -Icon gitlab -Size lg -Style $ButtonStyle
        #         New-UDIcon -Icon git    -Size lg -Style $ButtonStyle
        #     )
            
        #     foreach ($Icon in $Icons) {
        #         $ButtonProps = @{
        #             Text = $Icon.icon.ToUpper()
        #             Size = "medium"
        #             Icon = $Icon
        #             OnClick = {Show-UDToast -Message 'test'}
        #         }
        #         New-UDButton @ButtonProps
        #     }
        # } 
        # $CardProps = @{
        #     Id              = 'ud-card-demo'
        #     Elevation       = 24    
        #     ShowToolBar     = $true
        #     ToolBar         = $ToolBar
        #     Header          = $Header
        #     Body            = $Body
        #     Expand          = $Expand
        #     Footer          = $Footer
        #     Style           = @{ display = "flex"; justifyContent = "center"; backgroundColor = '#fff' }
        # }

        # New-UDGrid -Container -Content {
        #     New-UDGrid -Item -LargeSize 8 -Content {
        #         New-UDCard @CardProps
        #     }
        # }
    }

    New-UDPage -Name 'Checkbox' -Content {
        New-UDCheckBox -Label 'Demo' -Id 'chkLabel' -OnChange {}

        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementStart' -OnChange {} -LabelPlacement start

        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementTop' -OnChange {} -LabelPlacement top
        
        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementBottom' -OnChange {} -LabelPlacement bottom

        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementEnd' -OnChange {} -LabelPlacement end

        $Icon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon' -Regular
        $CheckedIcon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon-checked' 
        New-UDCheckBox -Id 'btnCustomIcon' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {} -Style @{color = '#2196f3'}

        New-UDCheckBox -Id 'chkChange' -OnChange {
            Set-TestData -Data "OnChange"
        }

        New-UDCheckBox -Id 'chkStyle' -Style @{color = 'pink'} -Label "I'm in love"

        New-UDCheckBox -Id 'chkDisabled' -Disabled

        New-UDCheckBox -Id 'chkChecked' -Checked $true

        New-UDCheckBox -Id 'chkCheckedDisabled' -Checked $true -Disabled
    }

    New-UDPage -Name 'Chips' -Content {
        New-UDChip -Label "my Label" -Id "chipLabel"

        $Icon = New-UDIcon -Icon 'user' -Size sm -Style @{color = '#fff'}
        New-UDChip -Label "Demo User" -Id "chipIcon" -Icon $Icon -OnClick {Show-UDToast -Message 'test'} -Style @{backgroundColor = '#00838f'}

        New-UDChip -Label "my Label" -Id "chipClick" -OnClick {
            Set-TestData -Data "chipClick"
        }

        New-UDChip -Label "my Label" -Id "chipDelete" -OnDelete {
            Set-TestData -Data "chipDelete"
        } 
    }

    New-UDPage -Name 'Expansion Panel' -Content {
        New-UDExpansionPanelGroup -Children {
            New-UDExpansionPanel -Title "Hello" -Id 'expTitle' -Children {}

            New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Children {
                New-UDElement -Tag 'div' -id 'expContentDiv' -Content { "Hello" }
            }
        }
    }

    New-UDPage -Name 'Typography' -Content {
        New-UDTypography -Variant h1 -Text "$(get-date -Format 'HH:mm:ss') as h1" -Style @{ color = 'pink' } -Align center 
        New-UDTypography -Variant h3 -Text "$(get-date -Format 'HH:mm:ss') as h3" -Style @{ color = 'pink' } -Align center
        New-UDTypography -Variant h5 -Text "$(get-date -Format 'HH:mm:ss') as h5" -Style @{ color = 'pink' } -Align center
    }

    New-UDPage -Name 'Floating Action Button' -Content {

        $Icon = New-UDIcon -Icon 'user'

        New-UDFloatingActionButton -Id 'fabIcon' -Icon $Icon

        New-UDFloatingActionButton -Id 'fabClick' -Icon $Icon -OnClick {
            Set-TestData -Data "fabClick"
        }

        New-UDFloatingActionButton -Id 'fabSmall' -Icon $Icon -Size small 

        New-UDFloatingActionButton -Id 'fabMedium' -Icon $Icon -Size medium

        New-UDFloatingActionButton -Id 'fabLarge' -Icon $Icon -Size large
    }

    New-UDPage -Name 'Form' -Content {
        New-UDForm -Id 'form' -Content {
            New-UDTextbox -Id 'txtName' 
            New-UDTextbox -Id 'txtLastName' 
            New-UDCheckbox -Id 'chkYes' -Label YesOrNo

            New-UDSelect -Label '1-3' -Id 'select' -Option {
                New-UDSelectOption -Name "One" -Value 1
                New-UDSelectOption -Name "Two" -Value 2
                New-UDSelectOption -Name "Three" -Value 3
            } 

            New-UDSwitch -Id 'switchYes'

            New-UDDatePicker -Id 'dateDate'

            New-UDTimePicker -Id 'timePicker'

            New-UDRadioGroup -Label 'group' -Id 'simpleRadio' -Children {
                New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adam'
                New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alon'
                New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'lee'
            } -Value 'Adam'

            New-UDAutocomplete -Id 'autoCompleteForm' -Options @('Test', 'Test2', 'Test3', 'Test4') 

        } -OnSubmit {
            Show-UDToast -Message $Body
            $Fields = $Body | ConvertFrom-Json
            Set-TestData $Fields
        }

        New-UDForm -Id 'defaultForm' -Content {
            New-UDTextbox -Id 'txtNameDefault' -Value 'Name'
            New-UDTextbox -Id 'txtLastNameDefault' -Value 'LastName'
            New-UDCheckbox -Id 'chkYesDefault' -Label YesOrNo -Checked $true

            New-UDSelect -Label '1-3' -Id 'selectDefault' -Option {
                New-UDSelectOption -Name "OneDefault" -Value 1
                New-UDSelectOption -Name "TwoDefault" -Value 2
                New-UDSelectOption -Name "ThreeDefault" -Value 3
            } -DefaultValue '1'

            New-UDSwitch -Id 'switchYesDefault' -Checked $true

            New-UDDatePicker -Id 'dateDateDefault' -Value '1-2-2020'

            New-UDTimePicker -Id 'timePickerDefault' -Value '10:30 AM'

            New-UDRadioGroup -Label 'group' -Id 'simpleRadioDefault' -Children {
                New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adamDefault'
                New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alonDefault'
                New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'leeDefault'
            } -Value 'Adam'
        } -OnSubmit {
            Show-UDToast -Message $Body
            $Fields = $Body | ConvertFrom-Json
            Set-TestData $Fields
        }

        New-UDForm -Id 'custom' -Content {
            New-UDPaper -Content {
                New-UDSelect -Label '1-3' -Id 'selection' -Option {
                    New-UDSelectOption -Name "Dog" -Value 1
                    New-UDSelectOption -Name "Car" -Value 2
                    New-UDSelectOption -Name "Lion" -Value 3
                } -OnChange {
                    $EventData = $Body | ConvertFrom-Json 

                    Clear-UDElement -Id 'img'
                    Add-UDElement -ParentId 'img' -Content {
                        if ($EventData -eq '1')
                        {
                            New-UDImage -Url 'https://i.imgur.com/OpB960K.jpg' -Height 150 -Width 150
                        }
    
                        if ($EventData -eq '2')
                        {
                            New-UDImage -Url 'https://i.imgur.com/a2lqPca.jpg' -Height 150 -Width 150
                        }
    
                        if ($EventData -eq '3')
                        {
                            New-UDImage -Url 'https://i.imgur.com/nAmS2Bt.jpg' -Height 150 -Width 150
                        }
                    }
                }

                New-UDElement -Id 'img' -Tag 'div' -Content {
                    New-UDImage -Url 'https://i.imgur.com/OpB960K.jpg' -Height 150 -Width 150
                }
            }  
        } -OnSubmit {
            Show-UDToast -Message $Body -Position bottomRight
        }

        New-UDForm -Id 'formReturnContent' -Content {

        } -OnSubmit {
            New-UDElement -Id 'newElement' -Tag 'div' -Content {'hello'}
        }

        New-UDForm -Id 'validateForm' -Content {
            New-UDTextbox -Id 'txtValidateForm'
        } -OnValidate {
            $FormContent = $Body | ConvertFrom-Json 

            if ($FormContent.txtValidateForm -eq $null -or $FormContent.txtValidateForm -eq '') {
                New-UDFormValidationResult -ValidationError "txtValidateForm is required"
            } else {
                New-UDFormValidationResult -Valid
            }
        } -OnSubmit {
            Set-TestData ($Body | ConvertFrom-Json)
        }
    }

    New-UDPage -Name "Grid" -Content {
        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDPaper -Content { "sm-6" }
            }
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDPaper -Content { "sm-6" }
            }
            New-UDGrid -Item -LargeSize 12 -Content {
                New-UDPaper -Content { "lg-6" }
            }
        }
    }

    New-UDPage -Name 'Icon' -Content {
        New-UDPaper -Content {
            New-UDIcon -Icon user -Size 3x -Style @{color = '#000'} -Id 'iconContent' 
        }

        New-UDPaper -Id 'iconSolid'  -Content {
            New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'} 
        }

        New-UDPaper -Id 'iconRegular' -Content {
            New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'} -Regular
        }

        New-UDPaper -Id 'iconFallback' -Content {
            New-UDIcon -Icon box -Size 3x -Style @{color = '#000'} -Regular
        }

        New-UDPaper -Id 'iconStyle' -Content {
            New-UDIcon -Icon user -Size 3x -Style @{color='rgb(33, 150, 243)'}
        }

        New-UDPaper -Content {
            New-UDIcon -Icon angry -Size xs -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size sm -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size lg -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 2x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 4x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 5x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 6x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 7x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 8x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 9x -Style @{color = '#000'}  
            New-UDIcon -Icon angry -Size 10x -Style @{color = '#000'}
        }
    }

    New-UDPage -Name "Icon Button" -Content {
        New-UDPaper -Content {
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'iconButtonContent' 
        }

        New-UDPaper -Content {
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'iconButtonIcon' 
        }

        New-UDPaper -Content {
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm )  -Id 'iconButtonStyle' -Style @{backgroundColor = '#000'; color='rgb(33, 150, 243)'}
        }

        New-UDPaper -Content {
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size xs -Style @{color = '#000'})  -Id 'iconButtonxs' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'iconButtonsm' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size lg -Style @{color = '#000'})  -Id 'iconButtonlg' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 2x -Style @{color = '#000'})  -Id 'iconButton2x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 3x -Style @{color = '#000'})  -Id 'iconButton3x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 4x -Style @{color = '#000'})  -Id 'iconButton4x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 5x -Style @{color = '#000'})  -Id 'iconButton5x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 6x -Style @{color = '#000'})  -Id 'iconButton6x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 7x -Style @{color = '#000'})  -Id 'iconButton7x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 8x -Style @{color = '#000'})  -Id 'iconButton8x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 9x -Style @{color = '#000'})  -Id 'iconButton9x' 
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size 10x -Style @{color = '#000'})  -Id 'iconButton10x' 
        }

        New-UDPaper -Content {
            New-UDIconButton -Icon (New-UDIcon -Icon user -Size lg)  -Id 'iconButtonOnClick' -Style @{backgroundColor = '#c9c9c9'; color='rgb(33, 150, 243)'} -OnClick {
                Set-TestData -Data "OnClick"
            }
        }
    }
    
    New-UDPage -Name 'Link' -Content { 
        $BodyProps = @{
            Style = @{backgroundColor = '#fff'; justifyContent = "center"}
            Content = {
                New-UDTypography -Variant h3 -Text "$(get-date -Format 'HH:mm:ss')" -Style @{ color = '#000' } -Align center
            }
            Id = 'body'
        }
        $Body = New-UDCardBody @BodyProps
            
        $CardProps = @{
            Id              = 'ud-card-demo'
            Elevation       = 24    
            Body            = $Body
            Style           = @{ display = "flex"; justifyContent = "center";backgroundColor = '#fff' }
        }
        
        $Card = New-UDCard @CardProps
        New-UDLink -Content {
            $card
        } -Id 'card-link' -url '#'         


        New-UDLink -text 'demo' -Id 'demo-link' -url '#' -variant body1 -ClassName 'gvili' -style @{color = 'red'}   
    }

    New-UDPage -Name 'List' -Content {
        New-UDPaper -Elevation 0 -Content {

            New-UDList -Id 'listContent' -Content {

                New-UDListItem -Id 'listContentItem' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {

                    New-UDListItem -Id 'list-item-security' -Label 'username and passwords'
                    New-UDListItem -Id 'list-item-api' -Label 'api keys'

                } 

                New-UDListItem -Id 'listContentItem' -Label 'Alon Gvili' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -Content {

                    New-UDListItem -Id 'list-item-inbox-new' -Label 'New Messages' -SubTitle 'You have 5 new messages.'
                    New-UDListItem -Id 'list-item-inbox-unread' -Label 'Unread Messages' -SubTitle 'You have alot of unread messages.' 

                } 

                New-UDListItem -Id 'listContentItem' -Label "Alon Gvili" -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -OnClick {
                    Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                } 
                New-UDListItem -Id 'listContentItem' -Label "Alon Gvili" -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -OnClick {
                    Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                } 
                New-UDListItem -Id 'listContentItem' -Label "Alon Gvili" -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/847923651282423808/M-SFbPV1_400x400.jpg' -OnClick {
                    Invoke-UDRedirect -Url 'https://github.com/AlonGvili' -OpenInNewWindow
                } 
            } -SubHeader "USERS  $(0..50 | get-random)"  
        }

        New-UDList -Id 'demo-list' -Content {

            New-UDListItem -Id 'list-item-user' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {

                New-UDListItem -Id 'list-item-security' -Label 'username and passwords' 
                New-UDListItem -Id 'list-item-api' -Label 'api keys'

            } 

        } -SubHeader 'USERS'
    }

    New-UDPage -Name "Paper" -Content {
        New-UDPaper -Content {
            New-UDHeading -Text "hi" -Id 'paperContent'
        }

        New-UDPaper -Content {
            New-UDHeading -Text "hi" -Id 'hi'
        } -Style @{
            backgroundColor = '#90caf9'
        } -Id 'paperStyle'

        New-UDPaper -Content {
            New-UDHeading -Text "hi" -Id 'hi'
        } -Style @{
            backgroundColor = '#90caf9'
        } -Id 'paperElevation' -Elevation 4
    }

    New-UDPage -Name "Progress" -Content {
        New-UDProgress -Circular -Id 'progressCircularIndeterminate'

        New-UDProgress -PercentComplete 75 -Id 'progressLinearDeterminate'

        New-UDProgress -Id 'progressLinearIndeterminate'
    }

    New-UDPage -Name 'Select' -Content {
        New-UDContainer -Children {
            New-UDSelect -Label '1-3' -Id 'select' -Option {
                New-UDSelectOption -Name "One" -Value 1
                New-UDSelectOption -Name "Two" -Value 2
                New-UDSelectOption -Name "Three" -Value 3
            } -DefaultValue 2 -OnChange { 
                $EventData = $Body | ConvertFrom-Json
                Set-TestData $EventData 
            }
    
            New-UDSelect -Id 'selectGrouped' -Option {
                New-UDSelectGroup -Name "Category 1" -Option {
                    New-UDSelectOption -Name "One" -Value 1
                    New-UDSelectOption -Name "Two" -Value 2
                    New-UDSelectOption -Name "Three" -Value 3
                }
                New-UDSelectGroup -Name "Category 2" -Option {
                    New-UDSelectOption -Name "Four" -Value 4
                    New-UDSelectOption -Name "Five" -Value 5
                    New-UDSelectOption -Name "Six" -Value 6
                }
            } -DefaultValue 2 -OnChange { Set-TestData $EventData }
    
            New-UDButton -Text 'Get State' -OnClick {
                $State = Get-UDElement -Id 'select'
                Show-UDToast -Message ($State | ConvertTo-Json)
            }
    
            New-UDButton -Text 'Set State' -OnClick {
                $Select = New-UDSelect -Label '10-12' -Id 'select' -Option {
                    New-UDSelectOption -Name "Ten" -Value 10
                    New-UDSelectOption -Name "Eleven" -Value 11
                    New-UDSelectOption -Name "Twelve" -Value 12
                } -DefaultValue 10 -OnChange { 
                    $EventData = $Body | ConvertFrom-Json
                    Set-TestData $EventData 
                }
    
                Set-UDElement -Id 'select' -Properties $Select
            }
    
            New-UDSelect -Label '1-3' -Id 'selectMultiple' -Option {
                New-UDSelectOption -Name "One" -Value 1
                New-UDSelectOption -Name "Two" -Value 2
                New-UDSelectOption -Name "Three" -Value 3
            } -DefaultValue 2 -OnChange { 
                $EventData = $Body | ConvertFrom-Json
                Set-TestData $EventData.Length
            } -Multiple
        }
    }

    
    New-UDPage -Name 'Stepper' -Content {
        New-UDStepper -Steps {
            New-UDStep -OnLoad {
                New-UDElement -tag 'div' -Content { "Step 1" }
            } -Label "Step 1"
            New-UDStep -OnLoad {
                New-UDElement -tag 'div' -Content { "Step 2" }
            } -Label "Step 2"
            New-UDStep -OnLoad {
                New-UDElement -tag 'div' -Content { "Step 3" }
            } -Label "Step 3"
        } -OnFinish {}
    }

    New-UDPage -Name 'Switch' -Content {
        New-UDSwitch -Id 'switchOff'
        New-UDSwitch -Id 'switchOffExplicit' -Checked $false
        New-UDSwitch -Id 'switchOn' -Checked $true
        New-UDSwitch -Id 'switchOnChange' -OnChange { 
            $EventData = $Body | ConvertFrom-Json
            Set-TestData $EventData 
        }
        New-UDSwitch -Id 'switchDisabled' -Disabled
    }

    New-UDPage -Name 'Table' -Content {

        $Data = @(
            @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
        ) 

        New-UDTable -Id 'defaultTable' -Data $Data

        $Columns = @(
            New-UDTableColumn -Property Dessert -Title "A Dessert"
            New-UDTableColumn -Property Calories -Title Calories 
            New-UDTableColumn -Property Fat -Title Fat 
            New-UDTableColumn -Property Carbs -Title Carbs 
            New-UDTableColumn -Property Protein -Title Protein 
        )

        New-UDTable -Id 'customColumnsTable' -Data $Data -Columns $Columns

        $Data = @(
            @{Dessert = 'Frozen yoghurt'; Calories = 1; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Gingerbread'; Calories = 200; Fat = 6.0; Carbs = 24; Protein = 4.0}
        ) 

        $Columns = @(
            New-UDTableColumn -Property Dessert -Title Dessert -Render { 
                $Item = $Body | ConvertFrom-Json 
                New-UDButton -Id "btn$($Item.Dessert)" -Text "Click for Dessert!" -OnClick { Show-UDToast -Message $Item.Dessert } 
            }
            New-UDTableColumn -Property Calories -Title Calories 
            New-UDTableColumn -Property Fat -Title Fat 
            New-UDTableColumn -Property Carbs -Title Carbs 
            New-UDTableColumn -Property Protein -Title Protein 
        )

        New-UDTable -Id 'customColumnsTableRender' -Data $Data -Columns $Columns -Sort -Export

        New-UDDynamic -Content {
            $DynamicData = @(
                @{Dessert = 'Frozen yoghurt'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Ice cream sandwich'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Eclair'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Cupcake'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Gingerbread'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            ) 

            New-UDTable -Id 'dynamicTable' -Data $DynamicData
        } -AutoRefresh -AutoRefreshInterval 2
        New-UDDynamic -Content {
            $DynamicData = @(
                @{Dessert = 'Frozen yoghurt'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Ice cream sandwich'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Eclair'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Cupcake'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Gingerbread'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            ) 

            New-UDTable -Id 'syncTable' -Data $DynamicData
        } -Id 'dynamicSection'

        New-UDButton -Text 'Sync Table' -Id 'btnSync' -OnClick {
            Sync-UDElement -Id 'dynamicSection'
        }

        $Columns = @(
            New-UDTableColumn -Property Dessert -Title "A Dessert"
            New-UDTableColumn -Property Calories -Title Calories 
            New-UDTableColumn -Property Fat -Title Fat 
            New-UDTableColumn -Property Carbs -Title Carbs 
            New-UDTableColumn -Property Protein -Title Protein 
        )

        New-UDTable -Id 'loadDataTable' -Columns $Columns -LoadData {
            $Query = $Body | ConvertFrom-Json

            <# Query will contain
                filters: []
                orderBy: undefined
                orderDirection: ""
                page: 0
                pageSize: 5
                properties: (5) ["dessert", "calories", "fat", "carbs", "protein"]
                search: ""
                totalCount: 0
            #>

            @(
                @{Dessert = 'Frozen yoghurt'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Ice cream sandwich'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Eclair'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Cupcake'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
                @{Dessert = 'Gingerbread'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            ) | Out-UDTableData -Page 0 -TotalCount 5 -Properties $Query.Properties 
        }

        $Data = ConvertFrom-Json '[{"Name":"AttributeTesting","Description":null,"ID":"162c27f4-7ad1-4a6c-b62c-20090151dcc7"},{"Name":"test","Description":"testing","ID":"1c229a64-d499-4d91-9102-829412efb6b0"},{"Name":"Auto","Description":null,"ID":"52103d0b-3144-4fe3-aa94-e3f986926e7c"},{"Name":"Person","Description":null,"ID":"72ae0e64-c35c-4a0a-aad1-39e056c51d48"},{"Name":"Person2","Description":null,"ID":"9a166c5b-0ddf-4759-84b0-b7c15c4d59bd"}]'
        New-UDTable -Data $Data -Id 'customData'
    }

    New-UDPage -Name "Tabs" -Id 'Tabs' -Content {
        New-UDTabs -Tabs {
            New-UDTab -Text "Tab1" -Id 'Tab1' -Content {
                New-UDElement -Tag div -Id 'tab1Content' -Content { "Tab1Content"}
            }
            New-UDTab -Text "Tab2" -Id 'Tab2' -Content {
                New-UDElement -Tag div -Id 'tab2Content' -Content { "Tab2Content"}
            }
            New-UDTab -Text "Tab3" -Id 'Tab3' -Content {
                New-UDElement -Tag div -Id 'tab3Content' -Content { "Tab3Content"}
            }
        }

        New-UDTabs -RenderOnActive -Id 'DynamicTabs' -Tabs {
            New-UDTab -Text "Tab1" -Id 'DynamicTab1' -Dynamic -Content {
                New-UDElement -Tag div -Id 'DynamicTab1Content' -Content { Get-Date } 
            }
            New-UDTab -Text "Tab2" -Id 'DynamicTab2' -Dynamic -Content {
                New-UDElement -Tag div -Id 'DynamicTab2Content' -Content { Get-Date }
            }
            New-UDTab -Text "Tab3" -Id 'DynamicTab2' -Dynamic -Content {
                New-UDElement -Tag div -Id 'DynamicTab3Content' -Content { Get-Date }
            }
        }

        New-UDTabs -Id 'verticalTabs' -Orientation 'vertical' -Tabs {
            New-UDTab -Text "Tab1" -Content {
                New-UDElement -Tag div -Content { Get-Date } 
            }
            New-UDTab -Text "Tab2" -Content {
                New-UDElement -Tag div -Content { Get-Date } 
            }
            New-UDTab -Text "Tab3" -Content {
                New-UDElement -Tag div -Content { Get-Date } 
            }
        }
    }

    New-UDPage -Name 'Textbox' -Content {
        New-UDTextbox -Label 'text' -Id 'txtLabel'

        New-UDTextbox -Label 'textValue' -Id 'txtValue' -Value 'value'

        New-UDTextbox -Label 'text' -Placeholder 'placeholder' -Id 'txtPlaceholder'

        New-UDTextbox -Label 'password' -Id 'txtPassword' -Type 'password'

        New-UDTextbox -Label 'email' -Id 'txtEmail' -Type 'email'

        New-UDTextbox -Label 'disabled' -Id 'txtDisabled' -Disabled

        New-UDButton -Text 'Get State' -OnClick {
            $State = Get-UDElement -Id 'txtLabel'
            Show-UDToast -Message ($State | ConvertTo-Json)
        }
    }

    New-UDPage -Name 'TreeView' -Content {
        New-UDTreeView -Node {
            New-UDTreeNode -Id 'Root' -Name 'Root' -Children {
                New-UDTreeNode -Id 'Level1' -Name 'Level 1' -Children {
                    New-UDTreeNode -Id 'Level2' -Name 'Level 2'
                }
                New-UDTreeNode -Name 'Level 1' -Children {
                    New-UDTreeNode -Name 'Level 2'
                }
                New-UDTreeNode -Name 'Level 1' -Children {
                    New-UDTreeNode -Name 'Level 2'
                }   
            }
            New-UDTreeNode -Id 'Root2' -Name 'Root 2'
        }
    }

    New-UDPage -Name 'Radio' -Content {
        New-UDRadioGroup -Label 'group' -Id 'simpleRadio' -Children {
            New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adam'
            New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alon'
            New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'lee'
        }

        New-UDRadioGroup -Label 'group' -Id 'onChangeRadio' -Children {
            New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adamOnChange'
            New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alonOnChange'
            New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'leeOnChange'
        } -OnChange { 
            $EventData = $Body | ConvertFrom-Json 

            Set-TestData $EventData
        }
    }

    New-UDPage -Name 'Named Page' -Content { New-UDElement -Tag div -Id 'namedPage' }
    New-UDPage -Name 'URL Page' -Url '/myurl' -Content { New-UDElement -Tag div -Id 'urlPage' }
    New-UDPage -Name 'URL with variable' -Url '/myurl/:test' -Content { param($test) New-UDElement -Tag div -Id 'urlPageWithVariable' -Content { $test } }
    New-UDPage -Name 'Page with loading' -Url '/loading' -Content { Start-Sleep -Seconds 3 } -OnLoading {
        New-UDElement -Id 'loading' -Tag 'div' -Content { 'Loading...' }
    }

)
