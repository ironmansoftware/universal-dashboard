Describe "card" {
    # Context "content" {
    #     Set-TestDashboard {
                    
    #         $ToolBarContent = {
    #             New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})  
    #             New-UDMuIconButton -Icon (New-UDMuIcon -Icon info_circle -Size sm -Style @{ color = '#0d47a1'} -Spin)  
    #         }
    #         $ToolbarStyle = @{backgroundColor = '#03a9f4'; color = '#fff'}
    #         $icon = New-UDMuIcon -Icon server -Size sm -FixedWidth -Style @{color = '#fff'} 
    #         $CardProps = @{
    #             Elevation       = 12
    #             AutoRefresh     = $false
    #             RefreshInterval = 15
    #             IsEndPoint      = $false
    #             ShowToolBar     = $true
    #             ShowControls    = $true
    #             Icon            = $Icon
    #             ToolbarStyle    = $ToolbarStyle
    #             ToolBarContent  = $ToolBarContent
    #             Title           = 'Universal Dashboard MaterialUI Card'
    #         }

    #         New-UDMuCard -Id 'demo-card' -Content {

    #             new-udheading -text (get-date -Format "HH:mm:ss") -size 4 -color '#000'
            
    #         } @CardProps

    #     }
            
    #     It 'has content' {
    #         Find-SeElement -Id 'demo-card' -Driver $Driver | should not be $null
    #     }
    # }

    Context "endpoint" {

        Set-TestDashboard {
           
            $ToolBarProps = @{
                icon        = New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} 
                Style       = @{backgroundColor = '#2196f3'; color = '#fff';flexGrow = 1}
                Content     = {New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#fff'}) -OnClick {Show-UDToast -Message 'test'}}
                Title       = New-UDMuTypography -Variant h5 -Text "Universal Dashboard MaterialUI" -Style @{ color = '#fff' } 
                ShowButtons = $true
            }
            $ToolBar = New-UDMuCardToolbar @ToolBarProps

            $HeaderProps = @{
                Style = @{backgroundColor = '#bbdefb'}
                Content = {
                    New-UDMuCardMedia -Component video -Source "http://media.w3.org/2010/05/bunny/movie.mp4"
                }
                IsEndPoint = $false 
                AutoRefresh = $false
                RefreshInterval = 6
            }
            $Header = New-UDMuCardHeader  @HeaderProps

            $BodyProps = @{
                Style = @{backgroundColor = '#fff'; justifyContent = "center"}
                Content = {
                    New-UDMuTypography -Variant h3 -Text "$(get-date -Format 'HH:mm:ss')" -Style @{ color = '#000' } -Align center
                }
                IsEndPoint = $true 
                AutoRefresh = $true
                RefreshInterval = 1
            }
            $Body = New-UDMuCardBody  @BodyProps
                
            $Expand = New-UDMuCardExpand -Style @{backgroundColor = '#f8f8f8'; color = '#000'; justifyContent = "center"} -Content {
                New-UDMuTypography -Variant h2 -Text "YOU EXPAND ME!" -Style @{ color = '#000'; margin = '40px' } -Align center
            }

            $Footer = New-UDMuCardFooter -Style @{backgroundColor = '#fff'; color = '#000'; justifyContent = "center"} -Content {
                
                $Icon = New-UDMuIcon -Icon 'github' -Size sm -Style @{color = '#000'}
                New-UDMuButton -Text "GitLab" -Id "button" -variant flat -Size medium -Icon $Icon -OnClick {Show-UDToast -Message 'test'} 

                $Icon1 = New-UDMuIcon -Icon 'gitlab' -Size sm -Style @{color = '#000'}
                New-UDMuButton -Text "demo" -Id "button1" -variant outlined -Size medium -Icon $Icon1 -OnClick {Show-UDToast -Message 'test'}
                
            } 


            $CardProps = @{
                Elevation       = 24    
                AutoRefresh     = $false
                RefreshInterval = 5
                IsEndPoint      = $true
                ShowToolBar     = $true
                ToolBar         = $ToolBar
                Header          = $Header
                Body            = $Body
                Expand          = $Expand
                Footer          = $Footer
                Style           = @{ display = "flex"; justifyContent = "center"; backgroundColor = '#fff' }
            }
            
            New-UDRow -Columns {

                New-UDColumn -LargeSize 8 -LargeOffset 2 -Content {

                    New-UDMuCard @CardProps
                
                }
            }
        }
        # Wait-Debugger
            
        
        It 'has dynamic content' {
            $element = Find-SeElement -Id 'dynamic' -Driver $Driver
            start-sleep 3
            $element1 = Find-SeElement -Id 'dynamic' -Driver $Driver
            $element.text -eq $element1.text | should be $false

        }
    }

    # Context "media" {

    #     Set-TestDashboard {
                    
    #         $icon = New-UDMuIcon -Icon server -Size sm -FixedWidth -Style @{color = '#fff'} 
    #         $ToolbarStyle = @{backgroundColor = 'rgb(50, 56, 59)'; color = '#fff'}
    #         $ToolBarContent = {New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})}
    #         $CardTitle = New-UDMuTypography -Text "Universal Dashboard MaterialUI" -variant h6 -Align center -Style @{color = '#fff'; fontWeight = 800}
    #         $CardMedia = New-UDMuCardMedia -Component img -Image "https://drscdn.500px.org/photo/297879605/q%3D80_m%3D2000/v2?webp=true&sig=6597d2293a6bac2f2e408d3f0775c3c46d1a73a675f436ed5dd6f3e8d4d32b71" -Height 350
    #         $CardProps = @{
    #             Elevation       = 12
    #             AutoRefresh     = $false
    #             RefreshInterval = 15
    #             IsEndPoint      = $false
    #             ShowToolBar     = $true
    #             ShowControls    = $false
    #             Style           = @{backgroundColor = 'rgb(50, 56, 59)'}

    #         }
            
    #         New-UDMuCard -Id 'demo-card' -Content {
                
    #             New-UDHeading -Text "$(0..15 | get-random)" -Size 1 -Color '#000' -id 'dynamic'

    #         } -ToolBarStyle $ToolbarStyle -ToolBarContent $ToolBarContent -Title $CardTitle -Media $CardMedia @CardProps
    #     }
            
        
    #     It 'has dynamic content' {
    #         $element = Find-SeElement -Id 'dynamic' -Driver $Driver
    #         start-sleep 3
    #         $element1 = Find-SeElement -Id 'dynamic' -Driver $Driver
    #         $element.text -eq $element1.text | should be $false

    #     }
    # }

    # Context "media - video" {

    #     Set-TestDashboard {
            
    #         New-UDRow -Columns {

    #             New-UDColumn -LargeSize 6 -Content {

    #                 $icon = New-UDMuIcon -Icon server -Size sm -FixedWidth -Style @{color = '#fff'} 
    #                 $ToolbarStyle = @{backgroundColor = 'rgb(50, 56, 59)'; color = '#fff'}
    #                 $ToolBarContent = {New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})}
    #                 $CardTitle = New-UDMuTypography -Text "Universal Dashboard MaterialUI" -variant h6 -Align center -Style @{color = '#fff'; fontWeight = 800}
    #                 $CardMedia = New-UDMuCardMedia -Component video -Source "http://media.w3.org/2010/05/bunny/movie.mp4"
    #                 $CardProps = @{
    #                     Elevation       = 12
    #                     AutoRefresh     = $false
    #                     RefreshInterval = 15
    #                     IsEndPoint      = $false
    #                     ShowToolBar     = $false
    #                     ShowControls    = $false
    #                     Style           = @{backgroundColor = 'rgb(50, 56, 59)'}
        
    #                 }
                    
    #                 New-UDMuCardToolBar -Style @{} -ShowControls -Content {} -Title () -Icon ()
    #                 New-UDMuCard -Id 'demo-card' -Content {
                                
    #                 } -ToolBarStyle $ToolbarStyle -ToolBarContent $ToolBarContent -Title $CardTitle -Media $CardMedia @CardProps

    #             }
    #         }
    #     }
            
        
    #     It 'has dynamic content' {
    #         $element = Find-SeElement -Id 'dynamic' -Driver $Driver
    #         start-sleep 3
    #         $element1 = Find-SeElement -Id 'dynamic' -Driver $Driver
    #         $element.text -eq $element1.text | should be $false

    #     }
    # }
}
