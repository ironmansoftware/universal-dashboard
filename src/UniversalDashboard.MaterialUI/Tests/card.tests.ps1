Describe "card" {

    Context "content" {

        Set-TestDashboard {
           
            $ToolBarProps = @{
                icon        = New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} 
                Style       = @{backgroundColor = '#2196f3'; color = '#fff';flexGrow = 1}
                Content     = {New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#fff'}) -OnClick {Show-UDToast -Message 'test'}}
                Title       = New-UDMuTypography -Variant h5 -Content{
                    Get-Date -Format "HH:mm:ss"
                } -IsEndPoint -AutoRefresh -RefreshInterval 1
                ShowButtons = $true
                Id = 'toolbar'
            }
            $ToolBar = New-UDMuCardToolbar @ToolBarProps

            $HeaderProps = @{
                Style = @{backgroundColor = '#bbdefb'; display = 'flex'; flexDirection = 'row'}
                Content = {
                    New-UDMuCardMedia -Component video -Source "http://media.w3.org/2010/05/bunny/movie.mp4" 
                    New-UDMuCardMedia -Component video -Source "https://gcs-vimeo.akamaized.net/exp=1552735105~acl=%2A%2F1062516359.mp4%2A~hmac=9af60d59dd6ed66cc5c9acaa6ffaebc039105a206cabe6d5499111b56f2d21c6/vimeo-prod-skyfire-std-us/01/1551/11/282759939/1062516359.mp4"
                }
                IsEndPoint = $false 
                AutoRefresh = $false
                RefreshInterval = 6
                Id = 'header'
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
                Id = 'body'
            }
            $Body = New-UDMuCardBody @BodyProps
                
            $Expand = New-UDMuCardExpand -Style @{backgroundColor = '#f8f8f8'; color = '#000'; justifyContent = "center"} -Content {
                New-UDMuTypography -Variant h2 -Text "YOU EXPAND ME!" -Style @{ color = '#000'; margin = '40px' } -Align center
            } -Id 'expand'


            $Footer = New-UDMuCardFooter -Id 'footer' -Style @{backgroundColor = '#fff'; color = '#000'; justifyContent = "center"} -Content {
                
                $ButtonStyle = @{color = '#fff'}
                $Icons = @(
                    New-UDMuIcon -Icon github -Size lg -Style $ButtonStyle
                    New-UDMuIcon -Icon gitlab -Size lg -Style $ButtonStyle
                    New-UDMuIcon -Icon git    -Size lg -Style $ButtonStyle
                )
                
                foreach ($Icon in $Icons) {
                    $ButtonProps = @{
                        Text = $Icon.icon.ToUpper()
                        Variant = "flat"
                        Size = "medium"
                        Icon = $Icon
                        OnClick = {Show-UDToast -Message 'test'}
                    }
                    New-UDMuButton @ButtonProps
                }
            } 


            $CardProps = @{
                Id              = 'ud-card-demo'
                Elevation       = 24    
                AutoRefresh     = $false
                RefreshInterval = 5
                IsEndPoint      = $false
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
        
        It 'has toolbar with content' {
            $element = Find-SeElement -Id 'toolbar' -Driver $Driver
            $element.Text | should not be $null
        }
        It 'has header with content' {
            $element = Find-SeElement -Id 'header' -Driver $Driver
            $element.Text | should not be $null
        }
        It 'has body with content' {
            $element = Find-SeElement -Id 'body' -Driver $Driver
            $element.Text | should not be $null
        }
        It 'has expand with content' {
            $button = Find-SeElement -id 'ud-card-expand-button' -Driver $Driver
            Invoke-SeClick -Element $button -Driver $Driver
            $element = Find-SeElement -Id 'expand' -Driver $Driver
            $element.Text | should not be $null
        }
        It 'has footer with content' {
            $element = Find-SeElement -Id 'footer' -Driver $Driver
            $element.FindElementsByTagName('button').count | should be 4
        }
    }

}
