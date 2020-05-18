Enter-SeUrl -Target $Driver -Url "$Address/Test/paper"

Describe "paper" {

    It 'has content' {
        Find-SeElement -Id 'hi' -Driver $Driver | should not be $null
    }

    It 'has background color of #90caf9 (rgb(144, 202, 249))' {
        $element = Find-SeElement -Id 'paperStyle' -Driver $Driver
        $style = Get-SeElementAttribute -Element $element -Attribute 'style' 
        $style.Split(':')[1].trim().replace(';','') | should be 'rgb(144, 202, 249)'
    }

    It 'has elevation of 4' {
        $element = Find-SeElement -Id 'paperElevation' -Driver $Driver
        (Get-SeElementAttribute -Element $element -Attribute 'class') -match '.MuiPaper-elevation4' | should be $true
    }
}