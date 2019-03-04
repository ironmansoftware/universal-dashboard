Describe "paper" {
    Context "content" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDHeading -Text "hi" -Id 'hi'
            }
        }

        It 'has content' {
            Find-SeElement -Id 'hi' -Driver $Driver | should not be $null
        }
    }
    Context "style" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDHeading -Text "hi" -Id 'hi'
            } -Style @{
                backgroundColor = '#90caf9'
            } -Id 'paper-container'
        }

        It 'has background color of #90caf9 (rgb(144, 202, 249))' {
            $element = Find-SeElement -Id 'paper-container' -Driver $Driver
            $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
            $style.Split(':')[1].trim().replace(';','') | should be 'rgb(144, 202, 249)'
        }
    }
    Context "elevation" {
        Set-TestDashboard {
            New-UDPaper -Content {
                New-UDHeading -Text "hi" -Id 'hi'
            } -Style @{
                backgroundColor = '#90caf9'
            } -Id 'paper-container' -Elevation 4
        }

        It 'has elevation of 4' {
            $element = Find-SeElement -Id 'paper-container' -Driver $Driver
            (Get-SeElementAttribute -Element $element -Attribute 'class') -match '.jss8' | should be $true
        }
    }
}