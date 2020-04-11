. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Invoke-UDRedirect" {
    Context "redirect to google" {
        $Dashboard = New-UdDashboard -Title "Sync Counter" -Content {
            New-UDButton -Text "Button" -Id "Button" -OnClick {
                Invoke-UDRedirect -Url "https://www.google.com"
            }
        } 

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should redirect to google" {
            $Element = Find-SeElement -Driver $Driver -Id 'Button'
            Invoke-SeClick -Element $Element

            Start-Sleep 2

            $Driver.Url.ToLower().COntains("https://www.google.com") | Should be $true 
        }
    }
}






