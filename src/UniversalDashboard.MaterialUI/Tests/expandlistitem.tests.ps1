Describe "expand list item" {
    Context "style" {
        Set-TestDashboard {
            
                New-UDExpandListItem -Id 'item1' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item01' -SubTitle 'Item-01-Subtitle' -Style @{
                    backgroundColor = '#fff'
                } -Content {
                    New-UDElement -Tag 'div' -Attributes @{style=@{display = 'flex'; flexDirection = 'column'; justifyContent = 'space-between'; alignItems = 'center'}} -Content {
                        New-UDHeading -Text 'DEMO HEADLINE' -Size 4 -Color '#c9c9c9'
                        New-UDButton -Text DEMO -Flat 
                    }
                }
                New-UDExpandListItem -Id 'item1' -Icon (New-UDIcon -Icon github -Size sm) -Label 'Item01' -SubTitle 'Item-01-Subtitle' -Style @{
                    backgroundColor = '#fff'
                } -Content {
                    New-UDElement -Tag 'div' -Attributes @{style=@{display = 'flex'; flexDirection = 'column'; justifyContent = 'space-between'; alignItems = 'center'}} -Content {
                        New-UDHeading -Text 'DEMO HEADLINE' -Size 4 -Color '#c9c9c9'
                        New-UDButton -Text DEMO -Flat 
                    }
                }

            
            
        }

        It 'has background color of #90caf9 (rgb(144, 202, 249))' {
            $element = Find-SeElement -Id 'demo-list' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $style.Split(':')[1].trim().replace(';','') | should be 'rgb(144, 202, 249)'
        }
    }
}