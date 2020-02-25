return

. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Error" {
    Context "Page" {
        $dashboard = New-UDDashboard -Title "Test" -Pages @(
            New-UDPage -Id "Page" -Name "Home" -Content {
                New-UDTest
            }
        )
        
        Start-UDDashboard -Port 10001 -Dashboard $dashboard -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should show error for whole page" {
            $Target = Find-SeElement -Driver $Driver -Id "Page"
            $Target.Text | Should be "An error occurred on this page`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }
    }
}