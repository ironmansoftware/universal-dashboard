param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "New-UDCard" {
    It "should set id" {
        (New-UDCard -Id "Test").Id | Should be "Test"
    }

    It "should be div tag" {
        (New-UDCard).Tag | Should be "div"
    }

    It "should set card class" {
        (New-UDCard).Attributes.className | Should be "card  ud-card"
    }

    It "should set card size class" {
        (New-UDCard -Size small).Attributes.className | Should be "card small ud-card"
        (New-UDCard -Size medium).Attributes.className | Should be "card medium ud-card"
        (New-UDCard -Size large).Attributes.className | Should be "card large ud-card"
    }

    It "should set title" {
        (New-UDCard -Title "title").Content[0].Content[0].Content[0] | Should be "title"
    }

    It "should set title tag" {
        (New-UDCard -Title "title").Content[0].Content[0].Tag | Should be "span"
    }

    It "should set title class" {
        (New-UDCard -Title "title").Content[0].Content[0].Attributes.className | Should be "card-title left-align "
    }

    It "should set background color" {
        (New-UDCard -BackgroundColor 'black').Attributes.style.backgroundColor | Should be "rgba(0, 0, 0, 1)"
    }

    It "should set font color" {
        (New-UDCard -FontColor 'black').Attributes.style.color | Should be "rgba(0, 0, 0, 1)"
    }
}
