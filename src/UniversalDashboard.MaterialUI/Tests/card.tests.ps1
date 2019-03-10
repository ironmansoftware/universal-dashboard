Describe "card" {
    Context "content" {
        Set-TestDashboard {
                    
                    New-UDMuCard -Content {
                        New-UDHeading -Text 'Card As Static' -Size 1 -Color '#000'
                        new-udheading -text (get-date -Format "HH:mm:ss") -size 4 -color '#000'
                    } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                        backgroundColor = '#03a9f4'
                        color = '#fff'
                    } -Icon (New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} ) -ToolbarContent {    
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})  
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon info_circle -Size sm -Style @{ color = '#0d47a1'} -Spin)  
                    }

                    New-UDMuCard -Content {
                        New-UDHeading -Text 'Card As EndPoint With Reload Button' -Size 1 -Color '#000'
                        new-udheading -text "$(0..100000 | Get-Random)" -Size 4 -color 'green'
                    } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                        backgroundColor = '#03a9f4'
                        color = '#fff'
                    } -Icon (New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} ) -ToolbarContent {    
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})  
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon info_circle -Size sm -Style @{ color = '#0d47a1'} -Spin)  
                    } -IsEndPoint

                    New-UDMuCard -Content {
                        New-UDHeading -Text 'Card As EndPoint' -Size 1 -Color '#000'

                        $MuIcon = [UniversalDashboard.Models.FontAwesomeIcons].DeclaredMembers.Name  | Select -skip 3 | get-random 
                        $UdIcon = [UniversalDashboard.Models.FontAwesomeIcons].DeclaredMembers.Name  | Select -skip 3 | get-random 
                        
                        #working no error
                        New-UDIcon -icon $UdIcon -size 5x -Color 'blue'


                        # Not working getting an error
                        New-UDMuIcon -icon $MuIcon -size 6x -style @{color = 'red'}
                        
                        # new-udheading -Text 'Demo' -Color '#000' -Size 2
                    } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{backgroundColor = '#03a9f4';color = '#fff'
                    } -Icon (New-UDMuIcon -Icon server -Size lg -FixedWidth -Style @{color = '#fff'} ) -ToolbarContent {    
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon github -Size sm -Style @{ color = '#0d47a1'})  
                        New-UDMuIconButton -Icon (New-UDMuIcon -Icon info_circle -Size sm -Style @{ color = '#0d47a1'} -Spin)  
                    } -Elevation 12 -AutoRefresh -RefreshInterval 10 -IsEndPoint 
                }
            
        
        It 'has content' {
            Find-SeElement -Id 'demo-card' -Driver $Driver | should not be $null
        }
    }
}
