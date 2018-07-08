param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Describe "New-UDImage" {
    It "should support path parameter" {
        $Image = New-UDImage -Path http://www.google.com/image.png 
        $Image.Attributes['src'] | Should be 'http://www.google.com/image.png'
    }
}