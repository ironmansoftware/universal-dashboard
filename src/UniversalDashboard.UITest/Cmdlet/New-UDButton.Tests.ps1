param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "New-UDButton" {
    It "should be an a tag" {
        (New-UDButton).Tag | Should be "a"
    }

    It "should have a btn class" {
        (New-UDButton).Attributes.className | Should be "btn"
    }
    
    It "should have a btn flat class" {
        (New-UDButton -Flat).Attributes.className | Should be "btn-flat"
    }

    It "should have a btn floating class" {
        (New-UDButton -Floating).Attributes.className | Should be "btn-floating"
    }

    It "should have text" {
        (New-UDButton -Text 'Button').Content | Should be "Button"
    }

    It "should add onClick event handler" {
        $Element = New-UDButton -Text 'Button' -OnClick {
            GPS
        }
        $Element.Events[0].Event | should be "onClick"
    }

    It "should have icon" {
        (New-UDButton -Icon user -IconAlignment 'right').Content.Attributes.className | should be 'fa fa-user right'
    }

    It "should set id" {
        (New-UDButton -Id "Test").Id | Should be "Test"
    }
}