New-UDDashboard -Title "Dashboard" -Pages @(

    New-UDPage -Name "Avatar" -Content {
        New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarContent'

        New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarStyle' -Style @{width = 80; height = 80}

        $AvatarProps = @{
            Image = 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
            Alt = 'alon gvili avatar'
            Id = 'avatarSquare'
            Style = @{width = 150; height = 150; borderRadius = '4px'}
        }
        New-UDAvatar @AvatarProps 
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

        New-UDCheckBox -Id 'chkChecked' -Checked

        New-UDCheckBox -Id 'chkCheckedDisabled' -Checked -Disabled
    }

    New-UDPage -Name 'Chips' -Content {
        New-UDChip -Label "my Label" -Id "chipLabel"

        $Icon = New-UDIcon -Icon 'user' -Size sm -Style @{color = '#fff'}
        New-UDChip -Label "Demo User" -Id "chipIcon" -Icon $Icon -OnClick {Show-UDToast -Message 'test'} -Clickable -Style @{backgroundColor = '#00838f'}

        New-UDChip -Label "my Label" -Id "chipClick" -OnClick {
            Set-TestData -Data "chipClick"
        }

        New-UDChip -Label "my Label" -Id "chipDelete" -OnDelete {
            Set-TestData -Data "chipDelete"
        } 
    }

    New-UDPage -Name 'Expansion Panel' -Content {
        New-UDExpansionPanelGroup -Items {
            New-UDExpansionPanel -Title "Hello" -Id 'expTitle' -Content {}

            New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Content {
                New-UDElement -Tag 'div' -id 'expContentDiv' -Content { "Hello" }
            }

            New-UDExpansionPanel -Title "Hello" -Id 'expEndpoint' -Endpoint {
                New-UDElement -Tag 'div' -id 'expEndpointDiv' -Content { "Hello" }
            }
        }
    }

    New-UDPage -Name 'Floating Action Button' -Content {
        New-UDFloatingActionButton -Id 'fabIcon' -Icon user 

        New-UDFloatingActionButton -Id 'fabClick' -Icon user -OnClick {
            Set-TestData -Data "fabClick"
        }

        New-UDFloatingActionButton -Id 'fabSmall' -Icon user -Size small 

        New-UDFloatingActionButton -Id 'fabMedium' -Icon user -Size medium

        New-UDFloatingActionButton -Id 'fabLarge' -Icon user -Size large
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

        New-UDPaper -Content {
            New-UDHeading -Text "$(0..10 | get-random)" -Id 'dynamic'
        } -Style @{
            backgroundColor = '#90caf9'
        } -Id 'paperEndpoint' -IsEndPoint -AutoRefresh -RefreshInterval 1
    }

    New-UDPage -Name "Preloader" -Content {
        New-UDProgress -Circular 
    }

    New-UDPage -Name 'Table' -Content {

        $Data = @(
            [PSCustomObject]@{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            [PSCustomObject]@{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            [PSCustomObject]@{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            [PSCustomObject]@{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
            [PSCustomObject]@{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
        ) | Out-UDTableContent

        New-UDTable -Id 'defaultTable' -Content {
            $Data
        }

        New-UDTable -Size small -Id 'smallTable' -Content {
            $Data
        }

        New-UDTable -StickyHeader -Id 'stickyHeaderTable' -Content {
            $Data
        }
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
    }
)
