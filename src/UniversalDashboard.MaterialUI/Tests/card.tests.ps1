Describe "card" {
    Context "content" {
        Set-TestDashboard {
                    
                    New-UDMuCard -Id 'demo-card' -Content {
                        New-UDHeading -Text 'Card As Static' -Size 1 -Color '#000'
                        new-udheading -text (get-date -Format "HH:mm:ss") -size 4 -color '#000'
                    } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                        backgroundColor = '#03a9f4'
                        color = '#fff'
                    } -Icon (New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} ) -ToolbarContent {    
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})  
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon info_circle -Size sm -Style @{ color = '#0d47a1'} -Spin)  
                    } -Elevation 12

                }
            
        
        It 'has content' {
            Find-SeElement -Id 'demo-card' -Driver $Driver | should not be $null
        }
    }

    Context "endpoint" {

        Set-TestDashboard {
                    
            $icon = New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} 
            $ToolbarStyle =  @{backgroundColor = '#03a9f4';color = '#fff'}
            $ToolBarContent = {New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})}
            $CardProps = @{
                Elevation = 12
                AutoRefresh = $true
                RefreshInterval = 1
                IsEndPoint = $true
                ShowToolBar = $true
                ShowControls = $true
            }

            New-UDMuCard -Id 'demo-card' -Title 'Universal Dashboard MaterialUI Card' -Content {
                
                New-UDHeading -Text "$(0..15 | get-random)" -Size 1 -Color '#000' -id 'dynamic'
        
            } -ToolBarStyle $ToolbarStyle -Icon $icon -ToolbarContent $ToolBarContent @CardProps
        }
            
        
        It 'has dynamic content' {
            $element = Find-SeElement -Id 'dynamic' -Driver $Driver
            start-sleep 3
            $element1 = Find-SeElement -Id 'dynamic' -Driver $Driver
            $element.text -eq $element1.text | should be $false

        }
    }
}
