Describe "card" {
    Context "content" {
        Set-TestDashboard {

            New-UDRow -columns {

                New-UDCOLUMN -LargeSize 8 -LargeOffset 2 -Content {
                    
                    New-UDMuCard -Content {
                        New-UDHeading -Text 'Demo' -Size 2
                    }  -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                        backgroundColor = '#03a9f4'
                        color = '#fff'
                    } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                        New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                        New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                    }
                
                }
            }
            
          new-udcolumn -Content {

              
  
                  new-udcolumn -LargeSize 6 -Content {
                      
                      New-UDMuCard -Content {
                        new-udheading -Text "$(0..100000 | Get-Random)" -Size 2 -Color '#009688'
                      } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                          backgroundColor = '#009688'
                          color = '#fff'
                      } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                          New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                          New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                      }
                  }
      
                  new-udcolumn -LargeSize 6 -Content {
                      
                      New-UDMuCard -AutoRefresh -RefreshInterval 3 -Content {
                            
                        new-udheading -Text "$(0..100000 | Get-Random)" -Size 2 -Color '#000'
                        
                      } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                          backgroundColor = '#009688'
                          color = '#fff'
                      } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                          New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                          New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                      } 
                  }
  
              }
          
            

            NEW-UDrow -Columns {

                New-UDCOLUMN -LargeSize 6 -Content {
                    New-UDMuCard -Content {
                        New-UDHeading -Text 'Demo' -Size 2
                    } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                        backgroundColor = '#ffc107'
                        color = '#fff'
                    } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                        New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                        New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                    }
                    New-UDMuCard -Content {
                        New-UDHeading -Text 'Demo' -Size 2
                    }  -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                        backgroundColor = '#ffc107'
                        color = '#fff'
                    } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                        New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                        New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                    }
                }
                New-UDCOLUMN -LargeSize 6 -Content {
                    

                New-UDMuCard -Content {
                    New-UDHeading -Text 'Demo' -Size 2
                }  -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                    backgroundColor = '#ffc107'
                    color = '#fff'
                } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                    New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                    New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                }
                New-UDMuCard -Content {
                    New-UDHeading -Text 'Demo' -Size 2
                } -ShowToolBar -ShowControls -Title 'Universal Dashboard MaterialUI Card' -ToolBarStyle @{
                    backgroundColor = '#ffc107'
                    color = '#fff'
                } -Icon (New-UDIcon -Icon server -Size xs -Color '#fff') -ToolbarContent {
                    New-UDIconButton -Icon (New-UDIcon -Icon github -Size sm -Color '#fff')  
                    New-UDIconButton -Icon (New-UDIcon -Icon plus -Size sm -Color '#fff')  
                }
            }
        
            }
        }

        It 'has content' {
            Find-SeElement -Id 'demo-card' -Driver $Driver | should not be $null
        }
    }
}
