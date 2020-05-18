Describe 'theme' {
    . "$PSScriptRoot\..\scripts\theme.ps1"

    It "should return themes" {
        (Get-UDTheme | Measure-Object).Count | should be 9
    }

    It "should return theme by name" {
        Get-UDTheme -Name 'Azure' | should not be $null
    }

    It "should convert theme to css" {
        $Theme = Get-UDTheme -Name 'Azure'
        $css = ConvertTo-UDThemeCss -Theme $Theme
    }
}