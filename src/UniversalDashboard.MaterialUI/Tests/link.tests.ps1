Describe "link" {

    Context "content" {

        Set-TestDashboard {
           
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
                
            $CardProps = @{
                Id              = 'ud-card-demo'
                Elevation       = 24    
                Body            = $Body
                Style           = @{ display = "flex"; justifyContent = "center";backgroundColor = '#fff' }
            }
            
            $Card = New-UDMuCard @CardProps
            new-udmulink -Content {
                $card
            } -Id 'card-link' -url '#'         


            new-udmulink -text 'demo' -Id 'demo-link' -url '#' -variant body1 -ClassName 'gvili' -style @{color = 'red'}          

        }
        
        It 'has content' {
            $element = Find-SeElement -Id 'card-link' -Driver $Driver
            $element.Text | should not be $null
        }
        It 'has text' {
            $element = Find-SeElement -Id 'demo-link' -Driver $Driver
            $element.Text | should be 'demo'
        }
    }

}
