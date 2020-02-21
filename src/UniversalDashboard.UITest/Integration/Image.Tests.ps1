. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Image" {
    Context "path" {

        $image = (Join-Path $PSScriptRoot '..\assets\logo1.png')

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDImage -Path $image -Id "img" -height 100 -Width 100
        }

        Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have set base64 string" {
            $Element = Find-SeElement -Id "img" -Driver $Driver
        }
    }
}