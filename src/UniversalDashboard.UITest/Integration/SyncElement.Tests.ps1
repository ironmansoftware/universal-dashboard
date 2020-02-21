
. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Sync-UDElement" {
    Context "Sync Counter" {
        $Dashboard = New-UdDashboard -Title "Sync Counter" -Content {
            New-UDButton -Text "Button" -Id "Button" -OnClick {
                $Session:Clicked = $true
                Sync-UDElement -Id 'Counter'
            }

            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                if ($Session:Clicked) {
                    1
                } else {
                    0
                }
            }
        } 

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should update number in background" {
            $Element = Find-SeElement -Driver $Driver -Id 'Counter'
            $Text = $Element.Text

            $Element = Find-SeElement -Driver $Driver -Id 'Button'
            Invoke-SeClick -Element $Element

            Start-Sleep 2

            (Find-SeElement -Driver $Driver -Id 'Counter').Text | Should not be $Text
        }
    }
}






