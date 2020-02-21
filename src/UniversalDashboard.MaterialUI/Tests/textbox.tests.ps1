Enter-SeUrl -Target $Driver -Url "http://localhost:10000/textbox"

Describe "Textbox" {
    It 'has label' {
        $Element = Find-SeElement -Id 'txtLabel' -Driver $Driver 
        $Element.FindElementByXPath('../..').FindElementByTagName('label').Text | should be 'text'
    }

    It 'has value' {
        (Find-SeElement -Id 'txtValue' -Driver $Driver).GetAttribute('value') | should be 'value'
    }

    It 'has placeholder' {
        $Element = Find-SeElement -Id 'txtPlaceholder' -Driver $Driver 
        $Element.FindElementByXPath('../..').FindElementByTagName('p').Text | should be 'placeholder'
    }

    It 'is password' {
        (Find-SeElement -Id 'txtPassword' -Driver $Driver).GetAttribute('type') | should be "password"
    }

    It 'is email' {
        (Find-SeElement -Id 'txtEmail' -Driver $Driver).GetAttribute('type') | should be "email"
    }

    It 'is disabled' {
        (Find-SeElement -Id 'txtDisabled' -Driver $Driver).GetAttribute('disabled') | should be $true
    }
}